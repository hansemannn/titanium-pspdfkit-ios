//
//  TiPSPDFKitUtils.swift
//  TiPspdfkit
//
//  Created by Hans Knöchel on 05.08.18.
//

import PSPDFKit
import UIKit

class TiPSPDFKitUtils: NSObject {

  static func documents(from filePaths: [String]) -> [PSPDFDocument] {
    var documents: [PSPDFDocument] = []
    
    for filePath in filePaths {
      if let pdfPath = resolve(filePath: filePath), FileManager.default.fileExists(atPath: pdfPath) {
        documents.append(PSPDFDocument(url: URL(fileURLWithPath: pdfPath)))
      }
    }
    
    return documents
  }
  
  static func resolve(filePaths: Any) -> [String] {
    var resolvedPaths: [String] = []

    if filePaths is String, let path = filePaths as? String {
      if let resolvedPath = TiPSPDFKitUtils.resolve(filePath: path) {
        resolvedPaths.append(resolvedPath)
      }
    } else if filePaths is [String] {
      for path in filePaths as! [String] {
        if let resolvedPath = TiPSPDFKitUtils.resolve(filePath: path) {
          resolvedPaths.append(resolvedPath)
        }
      }
    }
    
    return resolvedPaths
  }
  
  static func resolve(filePath: String) -> String? {
    if filePath.starts(with: "/") {
      return fixedIncorrect(filePath: filePath)
    }
    
    var pdfPath = filePath
    let fileManager = FileManager.default
    
    if !fileManager.fileExists(atPath: filePath) {
      if let path = URL(string: filePath)?.path, fileManager.fileExists(atPath: path) {
        return path
      } else {
        pdfPath = Bundle.main.bundlePath.appending(filePath)
        
        if !fileManager.fileExists(atPath: pdfPath) {
          if let cacheFolder = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first {
            pdfPath = cacheFolder.absoluteString.appending(filePath)
            
            if !fileManager.fileExists(atPath: pdfPath) {
              print("PSPDFKit Error: pdf \(filePath) could not be found. Searched native path, application bundle and documents directory.")
            }
          }
        }
      }
    }
    
    return pdfPath
  }
  
  private static func isIncorrect(filePath: String) -> Bool {
    return filePath.starts(with: "file://localhost")
  }

  private static func fixedIncorrect(filePath: String) -> String {
    if isIncorrect(filePath: filePath), let filePath = URL(string: filePath)?.path {
      return filePath
    }
    
    return filePath
  }
}
