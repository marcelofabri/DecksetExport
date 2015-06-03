//
//  DecksetDocument+PDF.swift
//  DecksetExport
//
//  Created by Marcelo Fabri on 03/06/15.
//  Copyright (c) 2015 Marcelo Fabri. All rights reserved.
//

import Foundation
import Quartz

extension DecksetDocument {
    func exportToPDF(file: NSURL) -> Bool {
        let documents = slides.map { PDFDocument(data: $0.pdfData) }
        
        let output = PDFDocument()
        var pageIndex = 0
        
        for doc in documents {
            for var i = 0; i < doc.pageCount(); i++ {
                let page = doc.pageAtIndex(i)
                output.insertPage(page, atIndex: pageIndex)
                pageIndex++
            }
        }
        
        return output.writeToURL(file)
    }
}