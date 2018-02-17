//
//  ViewController.swift
//  Planets
//
//  Created by Jacob Menke on 10/21/17.
//  Copyright © 2017 Jacob Menke. All rights reserved.
//

import UIKit
import ARKit

func test() -> Void {
    print("tonka")
}
class ViewController: UIViewController {
    
    @IBOutlet var arscene: ARSCNView!
    
    let config = ARWorldTrackingConfiguration()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        arscene.session.run(config)
        
        //        arscene.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]
        arscene.autoenablesDefaultLighting = true
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewDidAppear(_ animated: Bool) {
        
        let sun = SCNNode(geometry: SCNSphere(radius: 0.35))
        let earthParent = SCNNode()
        let venusParent = SCNNode()
        let earthMoonParent = SCNNode()
        let venusMoonParent = SCNNode()
        
        sun.geometry?.firstMaterial?.diffuse.contents = #imageLiteral(resourceName: "sun")
        sun.position = SCNVector3(0,0,-1)
        earthParent.position = SCNVector3(0,0,-1)
        venusParent.position = SCNVector3(0,0,-1)
        earthMoonParent.position = SCNVector3(1.2,0,0)
        venusMoonParent.position = SCNVector3(0.7,0,0)
        
        let earthNode = planet(geometry: SCNSphere(radius: 0.2), diffuse: #imageLiteral(resourceName: "EarthDay"), specular: #imageLiteral(resourceName: "spec"), emission: #imageLiteral(resourceName: "emiss"), normal: #imageLiteral(resourceName: "norm"), position: SCNVector3(1.2,0,0))
        
        let venusNode = planet(geometry: SCNSphere(radius: 0.2), diffuse: #imageLiteral(resourceName: "venus"), specular: nil, emission: #imageLiteral(resourceName: "venusAtmos"), normal: nil, position:SCNVector3(0.7,0,0))
        
        let earthMoonNode = planet(geometry: SCNSphere(radius: 0.05), diffuse: #imageLiteral(resourceName: "moon"), specular: nil, emission: nil, normal: nil, position: SCNVector3(0,0,-0.3))
        
        let venusMoonNode = planet(geometry: SCNSphere(radius: 0.05), diffuse: #imageLiteral(resourceName: "moon"), specular: nil, emission: nil, normal: nil, position: SCNVector3(0,0,-0.3))
        
        arscene.scene.rootNode.addChildNode(sun)
        arscene.scene.rootNode.addChildNode(earthParent)
        arscene.scene.rootNode.addChildNode(venusParent)
        
        earthNode.addChildNode(earthMoonNode)
        venusNode.addChildNode(venusMoonNode)
        earthParent.addChildNode(earthNode)
        earthParent.addChildNode(earthMoonParent)
        earthMoonParent.addChildNode(earthMoonNode)
        
        venusParent.addChildNode(venusNode)
        venusParent.addChildNode(venusMoonParent)
        venusMoonParent.addChildNode(venusMoonNode)

        //spinning of sun
        sun.runAction(rotation(time: 4))
        
        //rotation of planets
        earthParent.runAction(rotation(time: 5))
        venusParent.runAction(rotation(time: 4))
   
        //spinning of planets
        earthNode.runAction(rotation(time: 6))
        venusNode.runAction(rotation(time: 7))
        
        //rotation of earth moon
        earthMoonParent.runAction(rotation(time: 2))
        venusMoonParent.runAction(rotation(time: 1))
        
        //spinning of moons
        earthMoonNode.runAction(rotation(time: 2))
        venusMoonNode.runAction(rotation(time: 3))
        
    }
    
    func rotation(time: TimeInterval) -> SCNAction {
        let rot = SCNAction.rotateBy(x: 0, y: CGFloat(360.d2R), z: 0, duration: time)
        return SCNAction.repeatForever(rot)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func planet(geometry: SCNGeometry, diffuse: UIImage, specular: UIImage?, emission: UIImage?, normal: UIImage?, position: SCNVector3) -> SCNNode {
        let planetNode = SCNNode(geometry: geometry)
        planetNode.geometry?.firstMaterial?.diffuse.contents = diffuse
        planetNode.geometry?.firstMaterial?.specular.contents = specular
        planetNode.geometry?.firstMaterial?.emission.contents = emission
        planetNode.geometry?.firstMaterial?.normal.contents = normal
        
        planetNode.position = position
        
        return planetNode
    }
}

extension Int {
    var d2R : Double {
        return Double(self) * .pi/180
    }
}

