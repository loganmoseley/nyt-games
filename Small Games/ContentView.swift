import SpriteKit
import SwiftUI

class SpellingBeeScene: SKScene {

    private var label: SKLabelNode!
    private var spinnyNode : SKShapeNode?

    /// The scene initializer and the color-node child need to have
    /// the same size, but I'm not sure how to *derive* the size,
    /// so just punching something in for now.
    private let assumedScreenSize = CGSize(width: 640, height: 1096)

    override init() {
        super.init(size: assumedScreenSize)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        addChild(SKSpriteNode(
            color: UIColor.systemIndigo,
            size: assumedScreenSize))

        addChild(Honeycomb(letters: ["H", "A", "E", "C", "M", "L", "Y"]))

        label = SKLabelNode(text: "Hello, world! \(view.bounds.size)")
        addChild(label)

        // Create shape node to use during mouse interaction
        let w = (size.width + size.height) * 0.05
        spinnyNode = SKShapeNode(rectOf: CGSize.init(width: w, height: w), cornerRadius: w * 0.3)

        if let spinnyNode = spinnyNode {
            spinnyNode.lineWidth = 2.5

            spinnyNode.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 1)))
            spinnyNode.run(SKAction.sequence([SKAction.wait(forDuration: 0.5),
                                              SKAction.fadeOut(withDuration: 0.5),
                                              SKAction.removeFromParent()]))
        }
    }

    func touchDown(atPoint pos: CGPoint) {
        if let n = spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.green
            addChild(n)
        }
    }

    func touchMoved(toPoint pos: CGPoint) {
        if let n = spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.blue
            addChild(n)
        }
    }

    func touchUp(atPoint pos: CGPoint) {
        if let n = spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.red
            addChild(n)
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { touchDown(atPoint: t.location(in: self)) }
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { touchMoved(toPoint: t.location(in: self)) }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { touchUp(atPoint: t.location(in: self)) }
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { touchUp(atPoint: t.location(in: self)) }
    }
}

/// Wraps the SpriteKit scene.
///
/// Can't extract this because Previews are unhappy. I guess Previews use @objc
/// reflection, which is incompatible with generic types.
class SpellingBeeViewController: UIViewController {

    var skView: SKView! // self.view

    override func loadView() {
        skView = SKView()
        view = skView
        let scene = SpellingBeeScene()
        scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        skView.presentScene(scene)
    }
}

struct SpellingBeeScene_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            BasicVCView<SpellingBeeViewController>()
        }
    }
}
