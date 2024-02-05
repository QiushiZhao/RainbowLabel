import UIKit

public final class RainbowLabel: UILabel {
  public var startPoint: CGPoint {
    get { gradientView.gradientLayer.startPoint }
    set { gradientView.gradientLayer.startPoint = newValue }
  }

  public var endPoint: CGPoint {
    get { gradientView.gradientLayer.endPoint }
    set { gradientView.gradientLayer.endPoint = newValue }
  }

  public var colors: [Any]? {
    get { gradientView.gradientLayer.colors }
    set { gradientView.gradientLayer.colors = newValue }
  }

  public var locations: [NSNumber]? {
    get { gradientView.gradientLayer.locations }
    set { gradientView.gradientLayer.locations = newValue }
  }

  public var outlineWidth: CGFloat = 0 {
    didSet { setNeedsDisplay() }
  }

  public var outlineColor: UIColor? {
    didSet { setNeedsDisplay() }
  }

  private let gradientView = GradientView()
  

  public override func layoutSubviews() {
    super.layoutSubviews()
    gradientView.frame = bounds
  }

  public override func drawText(in rect: CGRect) {
    let shadowOffset = shadowOffset

    let context = UIGraphicsGetCurrentContext()
    if outlineWidth > 0 {
      context?.setLineWidth(outlineWidth)
      context?.setLineJoin(.round)
      context?.setTextDrawingMode(.stroke)
      textColor = outlineColor
      super.drawText(in: rect)
    }

    context?.setTextDrawingMode(.fill)
    textColor = UIColor.gradientColor(gradientLayer: gradientView.gradientLayer)
    self.shadowOffset = CGSize(width: 0, height: 0)
    super.drawText(in: rect)

    self.shadowOffset = shadowOffset
  }

  public override var intrinsicContentSize: CGSize {
    let contentSize = super.intrinsicContentSize
    return CGSize(
      width: contentSize.width == UIView.noIntrinsicMetric ? contentSize.width : contentSize.width + outlineWidth,
      height: contentSize.height == UIView.noIntrinsicMetric ? contentSize.height : contentSize.height + outlineWidth
    )
  }

  public override func sizeThatFits(_ size: CGSize) -> CGSize {
    let fixSize = CGSize(
      width: MinMax(0, size.width - outlineWidth, size.width),
      height: MinMax(0, size.height - outlineWidth, size.height)
    )
    let fitted = super.sizeThatFits(fixSize)
    return CGSize(width: fitted.width + outlineWidth, height: fitted.height + outlineWidth)
  }
}

@inline(__always) func MinMax<T: Comparable>(_ lower: T, _ value: T, _ upper: T) -> T {
  min(max(lower, value), upper)
}

class GradientView: UIView {
  override class var layerClass: AnyClass {
    CAGradientLayer.self
  }

  var gradientLayer: CAGradientLayer {
    layer as! CAGradientLayer
  }
}

extension UIColor {
  class func gradientColor(gradientLayer: CAGradientLayer) -> UIColor? {
    UIGraphicsBeginImageContext(gradientLayer.bounds.size)
    guard let context = UIGraphicsGetCurrentContext() else {
      return nil
    }
    gradientLayer.render(in: context)
    guard let image = UIGraphicsGetImageFromCurrentImageContext() else {
      return nil
    }
    UIGraphicsEndImageContext()
    return UIColor(patternImage: image)
  }
}
