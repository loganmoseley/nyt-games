import SpriteKit

extension SKAction {
    func easingInOut() -> SKAction {
        timingMode = .easeInEaseOut
        return self
    }
}

func pulse() -> SKAction {
    SKAction.sequence([
        .group([.scale(to: 0.6, duration: 0.3), .fadeOut(withDuration: 0.3)]),
        .group([.scale(to: 1.0, duration: 0.3), .fadeIn(withDuration: 0.3)])
    ])
    .easingInOut()
}

func restore() -> SKAction {
    SKAction.group([
        .scale(to: 1, duration: 0.2),
        .rotate(toAngle: 0, duration: 0.2)
    ])
    .easingInOut()
}

func squishCCW() -> SKAction {
    SKAction.group([
        .scale(to: 0.85, duration: 0.2),
        .rotate(toAngle: .pi/36 /* 5 degrees */, duration: 0.2)
    ])
    .easingInOut()
}

func squishCW() -> SKAction {
    SKAction.group([
        .scale(to: 0.85, duration: 0.2),
        .rotate(toAngle: -CGFloat.pi/36 /* -5 degrees */, duration: 0.2)
    ])
    .easingInOut()
}
