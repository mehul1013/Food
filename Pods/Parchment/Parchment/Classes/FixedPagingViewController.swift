import UIKit

public struct ViewControllerItem: PagingTitleItem, Equatable {
  
  public let viewController: UIViewController
  public let title: String
  
  init(viewController: UIViewController) {
    self.viewController = viewController
    self.title = viewController.title ?? ""
  }
}

public func ==(lhs: ViewControllerItem, rhs: ViewControllerItem) -> Bool {
  return lhs.viewController == rhs.viewController
}

open class FixedPagingViewController: PagingViewController<ViewControllerItem> {
  
  let items: [ViewControllerItem]
  
  public init(viewControllers: [UIViewController], options: PagingOptions = DefaultPagingOptions()) {
    items = viewControllers.map { ViewControllerItem(viewController: $0) }
    super.init(options: options)
    dataSource = self
    
  }

  required public init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
  
  open override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    if let item = items.first {
      selectPagingItem(item)
    }
  }
  
}

extension FixedPagingViewController: PagingViewControllerDataSource {
  
  public func pagingViewController<T>(_ pagingViewController: PagingViewController<T>, viewControllerForPagingItem pagingItem: T) -> UIViewController {
    
    //Post Observer for Refresh Cart
    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "RefreshCart"), object: nil)
    
    let index = items.index(of: pagingItem as! ViewControllerItem)!
    return items[index].viewController
  }
  
  public func pagingViewController<T>(_ pagingViewController: PagingViewController<T>, pagingItemBeforePagingItem pagingItem: T) -> T? {
    guard let index = items.index(of: pagingItem as! ViewControllerItem) else { return nil }
    if index > 0 {
      return items[index - 1] as? T
    }
    return nil
  }
  
  public func pagingViewController<T>(_ pagingViewController: PagingViewController<T>, pagingItemAfterPagingItem pagingItem: T) -> T? {
    guard let index = items.index(of: pagingItem as! ViewControllerItem) else { return nil }
    if index < items.count - 1 {
      return items[index + 1] as? T
    }
    return nil
  }
  
}
