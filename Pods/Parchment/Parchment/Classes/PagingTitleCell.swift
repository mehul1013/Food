import UIKit

open class PagingTitleCell: PagingCell {
  
  fileprivate var viewModel: PagingTitleCellViewModel?
  fileprivate let titleLabel = UILabel(frame: .zero)
  
  open override var isSelected: Bool {
    didSet {
      configureTitleLabel()
    }
  }
  
  public override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }
  
  public required init?(coder: NSCoder) {
    super.init(coder: coder)
    configure()
  }
  
  open override func setPagingItem(_ pagingItem: PagingItem, theme: PagingTheme) {
    if let titleItem = pagingItem as? PagingTitleItem {
      viewModel = PagingTitleCellViewModel(title: titleItem.title, theme: theme)
    }
    configureTitleLabel()
  }
  
  open func configure() {
    contentView.addSubview(titleLabel)
    contentView.constrainToEdges(titleLabel)
  }
  
  open func configureTitleLabel() {
    guard let viewModel = viewModel else { return }
    titleLabel.text = viewModel.title
    titleLabel.font = viewModel.font
    titleLabel.textAlignment = .center
    
    if isSelected {
      titleLabel.textColor = viewModel.selectedTextColor
    } else {
      titleLabel.textColor = viewModel.textColor
    }
  }
  
}
