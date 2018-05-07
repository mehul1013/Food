import Foundation

protocol PagingStateMachineDelegate: class {
  func pagingStateMachine<T>(_ pagingStateMachine: PagingStateMachine<T>, pagingItemBeforePagingItem: T) -> T?
  func pagingStateMachine<T>(_ pagingStateMachine: PagingStateMachine<T>, pagingItemAfterPagingItem: T) -> T?
}

class PagingStateMachine<T: PagingItem> where T: Equatable {
  
  weak var delegate: PagingStateMachineDelegate?
  
  var didSelectPagingItem: ((T, PagingDirection, Bool) -> Void)?
  var didChangeState: ((PagingState<T>, PagingEvent<T>?) -> Void)?
  
  fileprivate(set) var state: PagingState<T>
  
  init(initialState: PagingState<T>) {
    self.state = initialState
  }
  
  func fire(_ event: PagingEvent<T>) {
    switch event {
    case let .scroll(offset):
      handleScrollEvent(
        event,
        offset: offset)
    case let .select(pagingItem, direction, animated):
      handleSelectEvent(
        event,
        selectedPagingItem: pagingItem,
        direction: direction,
        animated: animated)
    case .finishScrolling:
      handleFinishScrollingEvent(event)
    case .cancelScrolling:
      handleCancelScrollingEvent(event)
    }
  }
  
  fileprivate func handleScrollEvent(_ event: PagingEvent<T>, offset: CGFloat) {
    switch state {
    case let .scrolling(pagingItem, upcomingPagingItem, oldOffset):
      if oldOffset < 0 && offset > 0 {
        state = .selected(pagingItem: pagingItem)
      } else if oldOffset > 0 && offset < 0 {
        state = .selected(pagingItem: pagingItem)
      } else if offset == 0 {
        state = .selected(pagingItem: pagingItem)
      } else {
        state = .scrolling(
          pagingItem: pagingItem,
          upcomingPagingItem: upcomingPagingItem,
          offset: offset)
      }
    case let .selected(pagingItem):
      if offset > 0 {
        state = .scrolling(
          pagingItem: pagingItem,
          upcomingPagingItem: delegate?.pagingStateMachine(self,
            pagingItemAfterPagingItem: pagingItem),
          offset: offset)
      } else if offset < 0 {
        state = .scrolling(
          pagingItem: pagingItem,
          upcomingPagingItem: delegate?.pagingStateMachine(self,
            pagingItemBeforePagingItem: pagingItem),
          offset: offset)
      }
    }
    didChangeState?(state, event)
  }
  
  fileprivate func handleSelectEvent(_ event: PagingEvent<T>, selectedPagingItem: T, direction: PagingDirection, animated: Bool) {
    if selectedPagingItem != state.currentPagingItem {
      if case .selected = state {
        state = .scrolling(
          pagingItem: state.currentPagingItem,
          upcomingPagingItem: selectedPagingItem,
          offset: 0)
        
        didSelectPagingItem?(selectedPagingItem, direction, animated)
        didChangeState?(state, event)
      }
    }
  }
  
  fileprivate func handleFinishScrollingEvent(_ event: PagingEvent<T>) {
    switch state {
    case let .scrolling(currentPagingItem, upcomingPagingItem, _):
      state = .selected(pagingItem: upcomingPagingItem ?? currentPagingItem)
      didChangeState?(state, event)
    case .selected:
      break
    }
  }
  
  fileprivate func handleCancelScrollingEvent(_ event: PagingEvent<T>) {
    switch state {
    case let .scrolling(currentPagingItem, _, _):
      state = .selected(pagingItem: currentPagingItem)
      didChangeState?(state, event)
    case .selected:
      break
    }
  }
  
}
