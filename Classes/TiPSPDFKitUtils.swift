//
//  TiPSPDFKitUtils.swift
//  TiPspdfkit
//
//  Created by Hans Knöchel on 05.08.18.
//

import PSPDFKit
import UIKit
import TitaniumKit

class TiPSPDFKitUtils: NSObject {

  static func documents(from files: [TiFile]) -> [PSPDFDocument] {
    var documents: [PSPDFDocument] = []
    
    for file in files {
      documents.append(PSPDFDocument(url: URL(fileURLWithPath: file.path)))
    }
    
    return documents
  }
}
