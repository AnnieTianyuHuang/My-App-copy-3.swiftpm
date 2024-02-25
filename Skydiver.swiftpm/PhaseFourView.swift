import SpriteKit
import SwiftUI

class PhaseFourScene: SKScene {
    private var skydiver: SKShapeNode?
    private var cloudButton: SKShapeNode?
    private var stopAddingButton: SKShapeNode?
    private var placeSkydiverButton: SKShapeNode?
    private var isAddingClouds = false
    private var canPlaceSkydiver = false
    private var gameEnded = false
    var selection: Selection?
    
    private var placeButton: SKShapeNode! 
    var backgroundImage = SKSpriteNode(imageNamed: "simulator")
    private var statusBubble: SKSpriteNode!
    private var statusLabel: SKLabelNode!
    
    let topBoundary: CGFloat = 20 
    let bottomBoundary: CGFloat = 50 

    override func didMove(to view: SKView) {
        self.backgroundColor = .white
        resetGame() // 重置游戏到初始状态
    }
    
    func resetGame() {
        // 清除云朵和跳伞者
        self.removeAllChildren()
        self.isAddingClouds = false
        self.canPlaceSkydiver = false
        self.gameEnded = false
        setBackgroundImage(name: "simulator")
        setupCloudButton()
        print("resetted")
    }

    private func setBackgroundImage(name: String) {
        // Remove old background image if exists
        backgroundImage.removeFromParent()
        
        // Set new background image
        backgroundImage = SKSpriteNode(imageNamed: name)
        backgroundImage.position = CGPoint(x: size.width / 2, y: size.height / 2 + 5)
        backgroundImage.zPosition = -1 // Ensure it's behind everything
        backgroundImage.setScale(1.0/3.0) // Scale down to desired size
        addChild(backgroundImage)
    }

    private func setupCloudButton() {
        let buttonSize = CGSize(width: 630, height: 110)
        let cornerRadius: CGFloat = 100
        let backgroundColor = SKColor.black.withAlphaComponent(0.3)
        let buttonRect = CGRect(origin: CGPoint(x: -buttonSize.width / 2, y: -buttonSize.height / 2), size: buttonSize)
        let buttonPath = UIBezierPath(roundedRect: buttonRect, cornerRadius: cornerRadius)
        cloudButton = SKShapeNode(path: buttonPath.cgPath)
        cloudButton!.fillColor = backgroundColor
        cloudButton!.name = "addCloud"
        cloudButton?.position = CGPoint(x: frame.midX, y: frame.midY)
        
        let label = SKLabelNode()
        label.text = "Tap to add clould"
        label.fontSize = 64
        label.fontColor = SKColor.white
        label.verticalAlignmentMode = .center
        label.horizontalAlignmentMode = .center
        label.position = CGPoint(x: 0, y: 0)
        
        // Create attributed string with desired font weight
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: label.fontSize, weight: .light),
            .foregroundColor: SKColor.white
        ]
        let attributedText = NSAttributedString(string: "Tap to add clould", attributes: attributes)
        
        // Apply attributed string to label
        label.attributedText = attributedText
        
        cloudButton!.addChild(label)
        addChild(cloudButton!)
    }

    private func setupStopAddingButton() {
        let buttonSize = CGSize(width: 270, height: 60)
        let cornerRadius: CGFloat = 100
        let backgroundColor = SKColor.red.withAlphaComponent(0.6)
        let buttonRect = CGRect(origin: CGPoint(x: -buttonSize.width / 2, y: -buttonSize.height / 2), size: buttonSize)
        let buttonPath = UIBezierPath(roundedRect: buttonRect, cornerRadius: cornerRadius)
        stopAddingButton = SKShapeNode(path: buttonPath.cgPath)
        stopAddingButton!.fillColor = backgroundColor
        stopAddingButton!.position = CGPoint(x: self.frame.maxX - 220, y: self.frame.maxY - 90)
        stopAddingButton!.name = "stopAdding"

        let label = SKLabelNode()
        label.text = "Stop Adding"
        label.fontSize = 38
        label.fontColor = SKColor.white
        label.verticalAlignmentMode = .center
        label.horizontalAlignmentMode = .center
        label.position = CGPoint(x: 0, y: 0)
        
        // Create attributed string with desired font weight
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: label.fontSize, weight: .light),
            .foregroundColor: SKColor.white
        ]
        let attributedText = NSAttributedString(string: "Finished Adding", attributes: attributes)
        
        // Apply attributed string to label
        label.attributedText = attributedText
        
        stopAddingButton!.addChild(label)
        addChild(stopAddingButton!)
    }

    private func setupPlaceSkydiverButton() {
        let buttonSize = CGSize(width: 720, height: 110)
        let cornerRadius: CGFloat = 100
        let backgroundColor = SKColor.black.withAlphaComponent(0.3)
        let buttonRect = CGRect(origin: CGPoint(x: -buttonSize.width / 2, y: -buttonSize.height / 2), size: buttonSize)
        let buttonPath = UIBezierPath(roundedRect: buttonRect, cornerRadius: cornerRadius)
        placeSkydiverButton = SKShapeNode(path: buttonPath.cgPath)
        placeSkydiverButton!.fillColor = backgroundColor
        placeSkydiverButton!.name = "placeSkydiver"
        placeSkydiverButton?.position = CGPoint(x: frame.midX, y: frame.midY)
        
        let label = SKLabelNode()
        label.text = "Click to Place Skydiver"
        label.fontSize = 64
        label.fontColor = SKColor.white
        label.verticalAlignmentMode = .center
        label.horizontalAlignmentMode = .center
        label.position = CGPoint(x: 0, y: 0)
        
        // Create attributed string with desired font weight
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: label.fontSize, weight: .light),
            .foregroundColor: SKColor.white
        ]
        let attributedText = NSAttributedString(string: "Click to Place Skydiver", attributes: attributes)
        
        // Apply attributed string to label
        label.attributedText = attributedText
        
        placeSkydiverButton!.addChild(label)
        addChild(placeSkydiverButton!)
    }
    
    func addSkydiver(at position: CGPoint) {
        if !canPlaceSkydiver { return }
        skydiver?.removeFromParent()
        
        skydiver = SKShapeNode(circleOfRadius: 10)
        skydiver?.fillColor = SKColor.blue
        skydiver?.strokeColor = SKColor.blue
        skydiver?.position = position
        
        if let skydiverNode = skydiver {
            addChild(skydiverNode)
                       simulateSkydiving(from: position)
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let nodes = self.nodes(at: location)

        if nodes.contains(where: { $0.name == "addCloud" }) && !isAddingClouds {
            cloudButton?.removeFromParent()
            isAddingClouds = true
            setupStopAddingButton()
        } else if nodes.contains(where: { $0.name == "stopAdding" }) {
            stopAddingButton?.removeFromParent()
            isAddingClouds = false
            setupPlaceSkydiverButton()
        } else if nodes.contains(where: { $0.name == "placeSkydiver" }) && !isAddingClouds {
            placeSkydiverButton?.removeFromParent()
            canPlaceSkydiver = true
        } else if isAddingClouds {
            addCloud(at: location)
        } else if canPlaceSkydiver {
            addSkydiver(at: location)
            canPlaceSkydiver = false // 确保只放置一次 skydiver
        }
    }
    
    func determineSkydiverAction(at position: CGPoint) {
        let heightPortion = size.height / 5
        let topFifth = size.height * 4 / 5
        let bottomFifth = heightPortion

        if position.y > topFifth {
            flyChaotically(from: position)
        } else if position.y < bottomFifth {
            accelerateToGround(from: position)
        } else {
            simulateSkydiving(from: position)
        }
    }
    
    func accelerateToGround(from position: CGPoint) {
        let fallAction = SKAction.moveTo(y: 0, duration: 0.5)
        skydiver?.run(fallAction)
    }
    
    func flyChaotically(from position: CGPoint) {
        let moveUp = SKAction.moveBy(x: 0, y: 50, duration: 1)
        let moveLeft = SKAction.moveBy(x: -50, y: 0, duration: 1)
        let moveRight = SKAction.moveBy(x: 50, y: 0, duration: 1)
        let sequence = SKAction.sequence([moveUp, moveLeft, moveUp, moveRight])
        let repeatAction = SKAction.repeat(sequence, count: 2)
        skydiver?.run(repeatAction)
    }
    
    func countCloudsPassed(through position: CGPoint) -> Int {
        let cloudsPassed = self.children.filter { node in
            guard let cloud = node as? SKSpriteNode, cloud.name == "cloud" else { return false }
            return position.y > cloud.position.y && abs(cloud.position.x - position.x) < cloud.size.width / 2
        }
        return cloudsPassed.count
    }
    
    func simulateSkydiving(from position: CGPoint) {
        guard let skydiver = skydiver else { return }
        
        // 计算穿过的云层数
        let cloudsPassedCount = self.children.filter { node in
            guard let cloud = node as? SKSpriteNode, cloud.name == "cloud" else { return false }
            return position.y > cloud.position.y && abs(cloud.position.x - position.x) < cloud.size.width / 2
        }.count
        skydiver.physicsBody?.isDynamic = false
        
        let groundLevel: CGFloat = bottomBoundary
        let totalFallDistance = position.y - groundLevel
        
        // 加速下降阶段
        let accelerateFallDistance = totalFallDistance * 0.5
        let accelerateAction = SKAction.moveBy(x: 0, y: -accelerateFallDistance, duration: 1)
        
        // 匀速下降阶段
        let normalFallDistance = totalFallDistance * 0.3
        let normalFallAction = SKAction.moveBy(x: 0, y: -normalFallDistance, duration: 2)
        
        // 开伞动作，根据穿过云层数量决定是否开伞
        let sequence: SKAction
        if cloudsPassedCount >= 1 {
            // 如果穿过2个以上的云层，模拟开伞失败，直接进入自由落体
            let freeFallDistance = totalFallDistance - accelerateFallDistance - normalFallDistance
            let freeFallAction = SKAction.moveBy(x: 0, y: -freeFallDistance, duration: 0.5)
            
            sequence = SKAction.sequence([
                accelerateAction,
                normalFallAction,
                freeFallAction,
                SKAction.run { [weak self] in
                    self?.skydiverLanded()
                }
            ])
        } else {
            // 正常开伞过程
            let riseDistance: CGFloat = 55
            let parachuteOpenAction = SKAction.moveBy(x: 0, y: riseDistance, duration: 0.5)
            let finalDescentDistance = totalFallDistance - accelerateFallDistance - normalFallDistance - riseDistance
            let slowDescentAction = SKAction.moveBy(x: 0, y: -(finalDescentDistance + riseDistance), duration: 3.5)
            
            sequence = SKAction.sequence([
                accelerateAction,
                normalFallAction,
                parachuteOpenAction,
                slowDescentAction,
                SKAction.run { [weak self] in
                    self?.skydiverLanded()
                }
            ])
        }
        skydiver.run(sequence)
    }

    func addCloud(at position: CGPoint) {
            // 使用SKSpriteNode加载云朵图片
            let cloud = SKSpriteNode(imageNamed: "cloud")
            cloud.size = CGSize(width: 196, height: 122)
            cloud.position = position
            cloud.name = "cloud"
            addChild(cloud)
    }
    
    override func update(_ currentTime: TimeInterval) {
        guard let skydiver = skydiver else { return }
        // Check if skydiver has stopped or gone out of bounds
        if gameEnded || skydiver.position.y > size.height || skydiver.position.y < 0 {
            skydiverLanded()
        }
    }
    func skydiverLanded() {
        // Handle game ending logic here
        print("Skydiver end")
        self.selection?.value = 8
    }
}

struct PhaseFourView: View {
    let aspectRatio: CGFloat = 3.0 / 4.0
    let minPadding: CGFloat = 50.0
    let cornerRadius: CGFloat = 32.0
    @EnvironmentObject var selection: Selection
    @State private var scene: PhaseFourScene? = nil
    @State private var resetTrigger = false

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Image("background_5")
                    .resizable()
                    .scaledToFill()
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .clipped()
                    .edgesIgnoringSafeArea(.all)

                if let scene = scene {
                    SpriteView(scene: scene)
                        .frame(
                            width: min(geometry.size.width - minPadding * 2, (geometry.size.height - minPadding * 2) * aspectRatio),
                            height: min((geometry.size.width - minPadding * 2) / aspectRatio, geometry.size.height - minPadding * 2)
                        )
                        .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
                        .padding(minPadding)
                        .id(resetTrigger)
                }
                // 条件展示 EndView
                if selection.value == 8 {
                    EndView().environmentObject(selection)
                }
            }
        }
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            // 首次加载时设置场景
            self.scene = self.setupScene()
        }
        .onChange(of: selection.value) { newValue in
            // 监听selection.value的变化，当游戏需要重新开始时重置场景
            if newValue == 4 { // 假设4是游戏重新开始的状态
                self.resetGame()
            }
        }
    }

    private func setupScene() -> PhaseFourScene {
        let newScene = PhaseFourScene()
        newScene.size = CGSize(width: 900, height: 1200)
        newScene.scaleMode = .aspectFit
        newScene.selection = selection
        return newScene
    }
    private func resetGame() {
            self.scene = self.setupScene()
            // 修改状态变量以触发视图重绘
            self.resetTrigger.toggle()
        }
}
