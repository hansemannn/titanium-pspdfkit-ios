//
//  TiPspdfkitModule.swift
//  ti.pspdfkit
//
//  Created by Hans Knoechel
//  Copyright (c) 2018 Your Company. All rights reserved.
//

import UIKit
import TitaniumKit

/**
 
 Titanium Swift Module Requirements
 ---
 
 1. Use the @objc annotation to expose your class to Objective-C (used by the Titanium core)
 2. Use the @objc annotation to expose your method to Objective-C as well.
 3. Method arguments always have the "[Any]" type, specifying a various number of arguments.
 Unwrap them like you would do in Swift, e.g. "guard let arguments = arguments, let message = arguments.first"
 4. You can use any public Titanium API like before, e.g. TiUtils. Remember the type safety of Swift, like Int vs Int32
 and NSString vs. String.
 
 */

@objc(TiPspdfkitModule)
class TiPspdfkitModule: TiModule {

  public let testProperty: String = "Hello World"
  
  func moduleGUID() -> String {
    return "9791669a-7e47-44fd-b93c-7a6aa8b54163"
  }
  
  override func moduleId() -> String! {
    return "ti.pspdfkit"
  }

  override func startup() {
    super.startup()
    debugPrint("[DEBUG] \(self) loaded")
  }
  
  @objc(tryThis:)
  func tryThis(arguments: Array<Any>?) -> String {
    guard let arguments = arguments, let message = arguments.first else { return "No arguments" }
    
    return "\(message) from TiSwift!"
  }
}
