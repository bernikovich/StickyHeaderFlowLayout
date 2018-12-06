//
//  Created by Tsimur Bernikovich on 12/6/18.
//  Copyright © 2018 Tsimur Bernikovich. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    let stickyHeaderFlowLayout = StickyHeaderFlowLayout()
    let collectionViewController = CollectionViewController(collectionViewLayout: stickyHeaderFlowLayout)
    
    let window = UIWindow(frame: UIScreen.main.bounds)
    window.rootViewController = collectionViewController
    window.makeKeyAndVisible()
    self.window = window
    
    return true
  }
  
}
