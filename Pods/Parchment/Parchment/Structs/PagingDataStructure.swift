import Foundation

struct PagingDataStructure<T: PagingItem> where T: Equatable {
  
  let visibleItems: [T]
  let totalWidth: CGFloat
  
  init(visibleItems: [T], totalWidth: CGFloat) {
    self.visibleItems = visibleItems
    self.totalWidth = totalWidth
  }
  
  func directionForIndexPath(_ indexPath: IndexPath, currentPagingItem: T) -> PagingDirection {
    guard let currentIndexPath = indexPathForPagingItem(currentPagingItem) else { return .none }
    
    if indexPath.item > currentIndexPath.item {
      return .forward
    } else if indexPath.item < currentIndexPath.item {
      return .reverse
    }
    return .none
  }
  
  func indexPathForPagingItem(_ pagingItem: T) -> IndexPath? {
    guard let index = visibleItems.index(of: pagingItem) else { return nil }
    return IndexPath(item: index, section: 0)
  }
  
  func pagingItemForIndexPath(_ indexPath: IndexPath) -> T {
    return visibleItems[indexPath.item]
  }
  
}
