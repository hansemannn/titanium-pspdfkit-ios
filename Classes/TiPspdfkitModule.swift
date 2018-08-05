//
//  TiPspdfkitModule.swift
//  ti.pspdfkit
//
//  Created by Hans Knoechel
//  Copyright (c) 2018 Your Company. All rights reserved.
//

import UIKit
import PSPDFKit
import PSPDFKitUI
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

  // MARK: Public Module Properties
  
  public let testProperty: String = "Hello World"
  
  var licenseKey: String {
    get {
      fatalError("There is no getter for this API")
    }
    set {
      PSPDFKit.setLicenseKey(newValue)
    }
  }

  var version: String {
    get {
      return PSPDFKit.versionString
    }
  }
  
  var languageDictionary: [String: [String: String]] {
    get {
      fatalError("There is no getter for this API")
    }
    set {
      PSPDFSetLocalizationDictionary(newValue)
    }
  }
  
  var logLevel: Int {
    get {
      return Int(PSPDFKit.sharedInstance.logLevel.rawValue)
    }
    set {
      PSPDFKit.sharedInstance.logLevel = PSPDFLogLevelMask(rawValue: PSPDFLogLevelMask.RawValue(newValue))
    }
  }

  // MARK: Private Module API's

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

  // MARK: Public Module Methods

  @objc(clearCache)
  func clearCache() {
    PSPDFKit.sharedInstance.cache.clear()
  }

  @objc(cacheDocument:)
  func cacheDocument(filePaths: [String]) {
    for document in TiPSPDFKitUtils.documents(from: filePaths) {
      PSPDFKit.sharedInstance.cache.cacheDocument(document, withPageSizes: [
        NSValue(cgSize: CGSize(width: 170, height: 220)),
        NSValue(cgSize: UIScreen.main.bounds.size)
      ])
    }
  }

  @objc(removeCacheForDocument:)
  func removeCacheForDocument(filePaths: [String]) {
    for document in TiPSPDFKitUtils.documents(from: filePaths) {
      PSPDFKit.sharedInstance.cache.remove(for: document)
    }
  }

  @objc(stopCachingDocument:)
  func stopCachingDocument(filePaths: [String]) {
    for document in TiPSPDFKitUtils.documents(from: filePaths) {
      PSPDFKit.sharedInstance.cache.stopCachingDocument(document)
    }
  }
  
  @objc(present:)
  func present(arguments: [Any]) {
    var pdfViewController: PSPDFViewController?
  
    guard let url = arguments.first as? String else { fatalError("Missing required 1st parameter (url)") }

    if let config = arguments[1] as? [String: Any], let nativeConfig = try? PSPDFConfiguration(dictionary: config) {
      pdfViewController = PSPDFViewController(document: TiPSPDFKitUtils.documents(from: [url]).first!, configuration: nativeConfig)
    } else {
      pdfViewController = PSPDFViewController(document: TiPSPDFKitUtils.documents(from: [url]).first!)
    }

    let nav = UINavigationController(rootViewController: pdfViewController!)
    TiApp().showModalController(nav, animated: true)
  }
  
  @objc(dismiss:)
  func dismiss(unused: [Any]?) {
    let topPresentedController = TiApp().controller.topPresentedController()
    if topPresentedController is UINavigationController, let first = topPresentedController?.childViewControllers.first, first is PSPDFViewController {
      topPresentedController?.dismiss(animated: true, completion: { [weak self] in
        guard let strongSelf = self else { return }
        strongSelf.fireEvent("close", with: nil)
      })
    }
  }
}
