import UIKit

open class PagingViewController<T: PagingItem>:
  UIViewController,
  UICollectionViewDataSource,
  UICollectionViewDelegateFlowLayout,
  EMPageViewControllerDataSource,
  EMPageViewControllerDelegate,
  PagingItemsPresentable,
  PagingStateMachineDelegate where T: Equatable {
  
  open let options: PagingOptions
  open weak var delegate: PagingViewControllerDelegate?
  open weak var dataSource: PagingViewControllerDataSource?
  fileprivate var dataStructure: PagingDataStructure<T>
  
  fileprivate var stateMachine: PagingStateMachine<T>? {
    didSet {
      handleStateMachineUpdate()
    }
  }
  
  open lazy var collectionViewLayout: PagingCollectionViewLayout<T> = {
    return PagingCollectionViewLayout(options: self.options, dataStructure: self.dataStructure)
  }()
  
  open lazy var collectionView: UICollectionView = {
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.collectionViewLayout)
    collectionView.backgroundColor = .white
    collectionView.isScrollEnabled = false
    return collectionView
  }()
  
  open let pageViewController: EMPageViewController = {
    return EMPageViewController(navigationOrientation: .horizontal)
  }()
  
  public init(options: PagingOptions = DefaultPagingOptions()) {
    self.options = options
    self.dataStructure = PagingDataStructure(visibleItems: [], totalWidth: 0)
    super.init(nibName: nil, bundle: nil)
  }

  required public init?(coder: NSCoder) {
    self.options = DefaultPagingOptions()
    self.dataStructure = PagingDataStructure(visibleItems: [], totalWidth: 0)
    super.init(coder: coder)
  }
  
  open override func loadView() {
    view = PagingView(
      pageView: pageViewController.view,
      collectionView: collectionView,
      options: options)
  }
  
  open override func viewDidLoad() {
    super.viewDidLoad()
    
    addChildViewController(pageViewController)
    pageViewController.didMove(toParentViewController: self)
    
    collectionView.delegate = self
    collectionView.dataSource = self
    pageViewController.delegate = self
    pageViewController.dataSource = self
    
    collectionView.registerReusableCell(options.menuItemClass)
    
    setupGestureRecognizers()
  }
  
  open func selectPagingItem(_ pagingItem: T, animated: Bool = false) {
    
    if let stateMachine = stateMachine {
      if let indexPath = dataStructure.indexPathForPagingItem(pagingItem) {
        let direction = dataStructure.directionForIndexPath(indexPath, currentPagingItem: pagingItem)
        stateMachine.fire(.select(
          pagingItem: pagingItem,
          direction: direction,
          animated: animated))
      }
    } else {
      
      let state: PagingState = .selected(pagingItem: pagingItem)
      stateMachine = PagingStateMachine(initialState: state)
      collectionViewLayout.state = state
      
      updateContentOffset(pagingItem)
      
      selectCollectionViewCell(
        pagingItem,
        scrollPosition: options.scrollPosition,
        animated: false)
      
      selectViewController(
        pagingItem,
        direction: .none,
        animated: false)
    }
  }
  
  open override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
    super.viewWillTransition(to: size, with: coordinator)
    guard let stateMachine = stateMachine else { return }
    coordinator.animate(alongsideTransition: { context in
      
      stateMachine.fire(.cancelScrolling)
      
      self.updateContentOffset(stateMachine.state.currentPagingItem)
      
      self.collectionView.selectItem(
        at: self.dataStructure.indexPathForPagingItem(stateMachine.state.currentPagingItem),
        animated: false,
        scrollPosition: self.options.scrollPosition)
      
      self.collectionViewLayout.invalidateLayout()
      
      }, completion: nil)
  }
  
  // MARK: Private
  
  fileprivate func setupGestureRecognizers() {
    let recognizerLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGestureRecognizer))
    recognizerLeft.direction = .left
    
    let recognizerRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGestureRecognizer))
    recognizerRight.direction = .right
    
    collectionView.addGestureRecognizer(recognizerLeft)
    collectionView.addGestureRecognizer(recognizerRight)
  }
  
  fileprivate dynamic func handleSwipeGestureRecognizer(_ recognizer: UISwipeGestureRecognizer) {
    guard let stateMachine = stateMachine else { return }
    
    let currentPagingItem = stateMachine.state.currentPagingItem
    var upcomingPagingItem: T? = nil
    
    if recognizer.direction.contains(.left) {
      upcomingPagingItem = pagingItemAfterPagingItem(currentPagingItem)
    } else if recognizer.direction.contains(.right) {
      upcomingPagingItem = pagingItemBeforePagingItem(currentPagingItem)
    }
    
    if let item = upcomingPagingItem {
      selectPagingItem(item, animated: true)
    }
  }
  
  fileprivate func handleStateUpdate(_ state: PagingState<T>, event: PagingEvent<T>?) {
    collectionViewLayout.state = state
    switch state {
    case let .selected(pagingItem):
      updateContentOffset(pagingItem)
      selectCollectionViewCell(
        pagingItem,
        scrollPosition: options.scrollPosition,
        animated: event?.animated ?? true)
    case .scrolling:
      collectionViewLayout.invalidateLayout()
      selectCollectionViewCell(
        state.visuallySelectedPagingItem,
        scrollPosition: UICollectionViewScrollPosition(),
        animated: false)
    }
  }
  
  fileprivate func handleStateMachineUpdate() {
    stateMachine?.didSelectPagingItem = { [weak self] pagingItem, direction, animated in
      self?.selectViewController(pagingItem, direction: direction, animated: animated)
    }
    
    stateMachine?.didChangeState = { [weak self] state, event in
      self?.handleStateUpdate(state, event: event)
    }
    
    stateMachine?.delegate = self
  }
  
  fileprivate func updateContentOffset(_ pagingItem: T) {
    let oldContentOffset: CGPoint = collectionView.contentOffset
    let fromItems = dataStructure.visibleItems
    let toItems = visibleItems(pagingItem, width: collectionView.bounds.width)
    let totalWidth = toItems.reduce(0) { widthForPagingItem($0.1) + $0.0 }
    
    dataStructure = PagingDataStructure(visibleItems: toItems, totalWidth: totalWidth)
    collectionViewLayout.dataStructure = dataStructure
    collectionView.reloadData()
    
    let offset = diffWidth(
      from: fromItems,
      to: toItems,
      itemSpacing: options.menuItemSpacing)
    
    collectionView.contentOffset = CGPoint(
      x: oldContentOffset.x + offset,
      y: oldContentOffset.y)
  }
  
  fileprivate func selectViewController(_ pagingItem: T, direction: PagingDirection, animated: Bool = true) {
    guard let dataSource = dataSource else { return }
    pageViewController.selectViewController(
      dataSource.pagingViewController(self, viewControllerForPagingItem: pagingItem),
      direction: direction.pageViewControllerNavigationDirection,
      animated: animated,
      completion: nil)
  }
  
  fileprivate func selectCollectionViewCell(_ pagingItem: T, scrollPosition: UICollectionViewScrollPosition, animated: Bool) {
    collectionView.selectItem(
      at: dataStructure.indexPathForPagingItem(pagingItem),
      animated: animated,
      scrollPosition: scrollPosition)
  }
  
  // MARK: UICollectionViewDelegateFlowLayout
  
  open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    if case .sizeToFit = options.menuItemSize {
      let inset = options.menuInsets.left + options.menuInsets.right
      if dataStructure.totalWidth + inset < collectionView.bounds.width {
        return CGSize(
          width: (collectionView.bounds.width - inset) / CGFloat(dataStructure.visibleItems.count),
          height: options.menuItemSize.height)
      }
    }
    return CGSize(
      width: widthForPagingItem(dataStructure.pagingItemForIndexPath(indexPath)),
      height: options.menuItemSize.height)
  }
    
  open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    switch options.menuHorizontalAlignment {
    case .center:
      if case .sizeToFit = options.menuItemSize {
        return options.menuInsets
      }
      var itemsWidth: CGFloat = 0.0
      for index in dataStructure.visibleItems.indices {
        let indexPath = IndexPath(item: index, section: section)
        itemsWidth += widthForPagingItem(dataStructure.pagingItemForIndexPath(indexPath))
      }
      let itemSpacing = options.menuItemSpacing * CGFloat(dataStructure.visibleItems.count - 1)
      let padding = collectionView.bounds.width - itemsWidth - itemSpacing
      let horizontalInset = max(0, padding) / 2
      return UIEdgeInsets(top: 0, left: horizontalInset, bottom: 0, right: horizontalInset)
    case .default:
      return options.menuInsets
    }
  }
  
  open func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    guard let stateMachine = stateMachine else { return }
    
    let currentPagingItem = stateMachine.state.currentPagingItem
    let selectedPagingItem = dataStructure.pagingItemForIndexPath(indexPath)
    let direction = dataStructure.directionForIndexPath(indexPath, currentPagingItem: currentPagingItem)

    stateMachine.fire(.select(
      pagingItem: selectedPagingItem,
      direction: direction,
      animated: true))
  }
  
  // MARK: UICollectionViewDataSource
  
  public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(indexPath: indexPath, cellType: options.menuItemClass)
    cell.setPagingItem(dataStructure.visibleItems[indexPath.item], theme: options.theme)
    return cell
  }
  
  open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return dataStructure.visibleItems.count
  }
  
  // MARK: EMPageViewControllerDataSource
  
  open func em_pageViewController(_ pageViewController: EMPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
    guard
      let dataSource = dataSource,
      let state = stateMachine?.state.currentPagingItem,
      let pagingItem = dataSource.pagingViewController(self, pagingItemBeforePagingItem: state) else { return nil }
    
    return dataSource.pagingViewController(self, viewControllerForPagingItem: pagingItem)
  }
  
  open func em_pageViewController(_ pageViewController: EMPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
    guard
      let dataSource = dataSource,
      let state = stateMachine?.state.currentPagingItem,
      let pagingItem = dataSource.pagingViewController(self, pagingItemAfterPagingItem: state) else { return nil }
    
    return dataSource.pagingViewController(self, viewControllerForPagingItem: pagingItem)
  }
  
  // MARK: PagingItemsPresentable
  
  func widthForPagingItem<U: PagingItem>(_ pagingItem: U) -> CGFloat {
    guard let pagingItem = pagingItem as? T else { return 0 }
    
    if let delegate = delegate {
      return delegate.pagingViewController(self, widthForPagingItem: pagingItem)
    }
    
    switch options.menuItemSize {
    case let .sizeToFit(minWidth, _):
      return minWidth
    case let .fixed(width, _):
      return width
    }
  }
  
  func pagingItemBeforePagingItem<U: PagingItem>(_ pagingItem: U) -> U? {
    return dataSource?.pagingViewController(self,
      pagingItemBeforePagingItem: pagingItem as! T) as? U
  }
  
  func pagingItemAfterPagingItem<U: PagingItem>(_ pagingItem: U) -> U? {
    return dataSource?.pagingViewController(self,
      pagingItemAfterPagingItem: pagingItem as! T) as? U
  }
  
  // MARK: EMPageViewControllerDelegate

  open func em_pageViewController(_ pageViewController: EMPageViewController, isScrollingFrom startingViewController: UIViewController, destinationViewController: UIViewController?, progress: CGFloat) {
    stateMachine?.fire(.scroll(offset: progress))
  }
  
  open func em_pageViewController(_ pageViewController: EMPageViewController, didFinishScrollingFrom startingViewController: UIViewController?, destinationViewController: UIViewController, transitionSuccessful: Bool) {
    if transitionSuccessful {
      stateMachine?.fire(.finishScrolling)
    }
  }
  
  // MARK: PagingStateMachineDelegate
  
  func pagingStateMachine<U>(
    _ pagingStateMachine: PagingStateMachine<U>,
    pagingItemBeforePagingItem pagingItem: U) -> U? {
    guard let pagingItem = pagingItem as? T else { return nil }
    return pagingItemBeforePagingItem(pagingItem) as? U
  }
  
  func pagingStateMachine<U>(
    _ pagingStateMachine: PagingStateMachine<U>,
    pagingItemAfterPagingItem pagingItem: U) -> U? {
    guard let pagingItem = pagingItem as? T else { return nil }
    return pagingItemAfterPagingItem(pagingItem) as? U
  }
  
}
