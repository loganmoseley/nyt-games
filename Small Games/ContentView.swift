import SpriteKit
import SwiftUI


class SpellingBeeScene: SKScene {

    private var label: SKLabelNode!

    /// The scene initializer and the color-node child need to have
    /// the same size, but I'm not sure how to *derive* the size,
    /// so just punching something in for now.
    private let assumedScreenSize = CGSize(width: 320, height: 548)

    override init() {
        super.init(size: assumedScreenSize)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func didMove(to view: SKView) {
        super.didMove(to: view)

        addChild(SKSpriteNode(
            color: UIColor.blue,
            size: assumedScreenSize))

        label = SKLabelNode(text: "Hello, world! \(view.bounds.size)")
        addChild(label)
    }
}

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

struct SpellingBeeView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> SpellingBeeViewController {
        SpellingBeeViewController()
    }

    func updateUIViewController(_ uiViewController: SpellingBeeViewController, context: Context) {

    }
}

struct ContentView: View {
    var body: some View {
        SpellingBeeView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
