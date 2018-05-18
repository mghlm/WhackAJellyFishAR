//
//  ViewController.swift
//  WorldTracking
//
//  Created by magnus holm on 17/05/2018.
//  Copyright © 2018 magnus holm. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController {
    
    @IBOutlet weak var sceneView: ARSCNView!
    
    let configuration = ARWorldTrackingConfiguration()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]
        self.sceneView.session.run(configuration)
        self.sceneView.autoenablesDefaultLighting = true
    }
    
    @IBAction func add(_ sender: Any) {
        
        let pyramidNode = SCNNode(geometry: SCNPyramid(width: 0.1, height: 0.1, length: 0.1))
        pyramidNode.geometry?.firstMaterial?.specular.contents = UIColor.orange
        pyramidNode.geometry?.firstMaterial?.diffuse.contents = UIColor.blue
        pyramidNode.position = SCNVector3(0, 0.3,-0.2)
        pyramidNode.eulerAngles = SCNVector3(180.degreesToRadians,0,0)

        let boxNode = SCNNode(geometry: SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0))
        boxNode.geometry?.firstMaterial?.diffuse.contents = UIColor.red
        boxNode.position = SCNVector3(0, -0.05, 0)

        let doorNode = SCNNode(geometry: SCNPlane(width: 0.02, height: 0.05))
        doorNode.geometry?.firstMaterial?.diffuse.contents = UIColor.brown
        doorNode.position = SCNVector3(0,-0.025,0.0501)

        self.sceneView.scene.rootNode.addChildNode(pyramidNode)
        pyramidNode.addChildNode(boxNode)
        boxNode.addChildNode(doorNode)

    }
    
    @IBAction func reset(_ sender: Any) {
        self.restartSession()
    }
    
    func restartSession() {
        self.sceneView.session.pause()
        self.sceneView.scene.rootNode.enumerateChildNodes { (node, _) in
            node.removeFromParentNode()
        }
        self.sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }
    func randomNumbers(firstNum: CGFloat, secondNum: CGFloat) -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum)
    }
}

extension Int {
    var degreesToRadians: Double {
        return Double(self) * .pi/180
    }
}

