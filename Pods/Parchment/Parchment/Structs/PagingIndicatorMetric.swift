import Foundation

struct PagingIndicatorMetric {
  
  enum Inset {
    case left(CGFloat)
    case right(CGFloat)
    case none
  }
  
  let frame: CGRect
  let insets: Inset
  
  var x: CGFloat {
    switch insets {
    case let .left(inset):
      return frame.origin.x + inset
    default:
      return frame.origin.x
    }
  }
  
  var width: CGFloat {
    switch insets {
    case let .left(inset):
      return frame.size.width - inset
    case let .right(inset):
      return frame.size.width - inset
    case .none:
      return frame.size.width
    }
  }
  
}
