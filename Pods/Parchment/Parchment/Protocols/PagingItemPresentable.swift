import Foundation

protocol PagingItemsPresentable {
  func widthForPagingItem<T: PagingItem>(_ pagingItem: T) -> CGFloat
  func pagingItemBeforePagingItem<T: PagingItem>(_ pagingItem: T) -> T?
  func pagingItemAfterPagingItem<T: PagingItem>(_ pagingItem: T) -> T?
}

extension PagingItemsPresentable {
  
  func visibleItems<T: PagingItem>(_ pagingItem: T, width: CGFloat) -> [T] where T: Equatable {
    let before = itemsBefore([pagingItem], width: width)
    let after = itemsAfter([pagingItem], width: width)
    return before + [pagingItem] + after
  }
  
  func itemsBefore<T: PagingItem>(_ items: [T], width: CGFloat) -> [T] where T: Equatable {
    if let first = items.first, let item = pagingItemBeforePagingItem(first), width > 0 {
      return itemsBefore([item] + items, width: width - widthForPagingItem(item))
    }
    return Array(items.dropLast())
  }
  
  func itemsAfter<T: PagingItem>(_ items: [T], width: CGFloat) -> [T] where T: Equatable {
    if let last = items.last, let item = pagingItemAfterPagingItem(last), width > 0 {
      return itemsAfter(items + [item], width: width - widthForPagingItem(item))
    }
    return Array(items.dropFirst())
  }
  
  func diffWidth<T: PagingItem>(from: [T], to: [T], itemSpacing: CGFloat) -> CGFloat where T: Equatable {
    let added = widthFromItem(to.first, items: from, itemSpacing: itemSpacing)
    let removed = widthFromItem(from.first, items: to, itemSpacing: itemSpacing)
    return added - removed
  }
  
  func widthFromItem<T: PagingItem>(_ item: T?, items: [T], itemSpacing: CGFloat, width: CGFloat = 0) -> CGFloat where T: Equatable {
    if items.isEmpty == false {
      if let item = item, items.contains(item) == false {
        return widthFromItem(pagingItemAfterPagingItem(item),
                             items: items,
                             itemSpacing: itemSpacing,
                             width: width + itemSpacing + widthForPagingItem(item))
      }
      return width
    }
    return 0
  }
  
}
