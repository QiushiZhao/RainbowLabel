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

  private let gradientView = GradientView()

  public override func layoutSubviews() {
    super.layoutSubviews()
    gradientView.frame = bounds
    textColor = UIColor.gradientColor(gradientLayer: gradientView.gradientLayer)
  }
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
