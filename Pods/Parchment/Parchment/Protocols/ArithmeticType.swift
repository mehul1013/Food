import Foundation

protocol ArithmeticType {
  static func +(lhs: Self, rhs: Self) -> Self
  static func -(lhs: Self, rhs: Self) -> Self
  static func /(lhs: Self, rhs: Self) -> Self
  static func *(lhs: Self, rhs: Self) -> Self
  static func %(lhs: Self, rhs: Self) -> Self
}

extension CGFloat: ArithmeticType {}

func tween<T: ArithmeticType>(from: T, to: T, progress: T) -> T {
  return ((to - from) * progress) + from
}
