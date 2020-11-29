import CoreGraphics
import Foundation
import SpriteKit

/// The apothem of a regular polygon is a line segment from the center to the
/// midpoint of one of its sides.
///
/// [en.wikipedia.org/wiki/Apothem](https://en.wikipedia.org/wiki/Apothem)
func apothem(side s: CGFloat, numberOfSides: Int) -> CGFloat {
    let pi = CGFloat.pi
    let n = CGFloat(numberOfSides)
    return s / (2 * tan(pi/n))
}

func hexLabel(letter: String?) -> SKLabelNode {
    let l = SKLabelNode(text: letter)
    l.fontColor = .black
    l.fontName = UIFont.boldSystemFont(ofSize: 1).fontName
    l.fontSize = 80
    l.horizontalAlignmentMode = .center
    l.verticalAlignmentMode = .center
    return l
}

func hexNode(radius r: CGFloat) -> SKShapeNode {
    let hex = CGMutablePath()
    hex.move   (to: CGPoint(x:                       r, y: 0 ))
    hex.addLine(to: CGPoint(x: cos(CGFloat.pi*1/3) * r, y: sin(CGFloat.pi*1/3) * r ))
    hex.addLine(to: CGPoint(x: cos(CGFloat.pi*2/3) * r, y: sin(CGFloat.pi*2/3) * r ))
    hex.addLine(to: CGPoint(x:                      -r, y: 0 ))
    hex.addLine(to: CGPoint(x: cos(CGFloat.pi*4/3) * r, y: sin(CGFloat.pi*4/3) * r ))
    hex.addLine(to: CGPoint(x: cos(CGFloat.pi*5/3) * r, y: sin(CGFloat.pi*5/3) * r ))
    hex.closeSubpath()
    return SKShapeNode(path: hex, centered: true)
}
