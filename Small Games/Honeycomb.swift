import SpriteKit

let cellRadius: CGFloat = 80
let cellSpacing: CGFloat = 5
let primaryCellColor = UIColor(hue: 46/359, saturation: 0.71, brightness: 0.93, alpha: 1.0)
let secondaryCellColor = UIColor(hue: 211/359, saturation: 0.01, brightness: 0.89, alpha: 1.0)

class Honeycomb: SKNode {

    let primaryCell: SKShapeNode
    let secondaryCells: [SKShapeNode]

    init(letters: [String]) {
        // the center
        primaryCell = hexNode(radius: cellRadius)
        primaryCell.fillColor = primaryCellColor
        primaryCell.addChild(hexLabel(letter: letters.first))
        // the ring
        secondaryCells = letters.dropFirst().prefix(6).enumerated().map { elem -> SKShapeNode in
            let letter = elem.element
            let i = elem.offset
            let hex = hexNode(radius: cellRadius)
            hex.fillColor = secondaryCellColor
            let divvy = CGFloat.pi / 3 * CGFloat(i)
            let phase = CGFloat.pi / 6
            let theta = (divvy) + (phase)
            // In a regular hexagon, the radius equals the side or edge length.
            let apo = apothem(side: cellRadius, numberOfSides: 6) + cellSpacing
            hex.position = CGPoint(
                x: cos(theta) * apo * 2,
                y: sin(theta) * apo * 2)
            hex.addChild(hexLabel(letter: letter))
            return hex
        }

        super.init()

        addChild(primaryCell)
        secondaryCells.forEach { addChild($0) }
    }

    @available(*, unavailable, message: "Use init() instead.")
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
