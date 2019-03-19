//
//  Prefilter.swift
//  Pods-Prestyler_Example
//
//  Created by Ilya Krupko on 18/03/2019.
//

import Foundation

public enum PrefilterType {
    case numbers
    // case links
}

public extension String {
    func prefilter(type: PrefilterType, by tag: String) -> String {
        switch type {
        case .numbers:
            return prefilterNumbers(tag: tag)
        }
    }

    func prefilter(text: String, by tag: String) -> String {
        let replacement = tag + text + tag
        return self.replacingOccurrences(of: text, with: replacement)
    }

    fileprivate func prefilterNumbers(tag: String) -> String {
        var str = self
        let characters = str.unicodeScalars
        var startIndex: Int?
        var endIndex: Int?
        var iterSum = 0
        for (index, element) in characters.enumerated() {
            let digitSet = CharacterSet.decimalDigits
            if digitSet.contains(element) {
                if startIndex == nil {
                    startIndex = index
                }
                endIndex = index + 1
            }
            if startIndex != nil && (!digitSet.contains(element) || index == characters.count-1) {
                str.insert(contentsOf: tag, at: str.index(str.startIndex, offsetBy: startIndex! + iterSum)) ;
                iterSum += tag.count
                str.insert(contentsOf: tag, at: str.index(str.startIndex, offsetBy: endIndex! + iterSum)) ;
                iterSum += tag.count
                startIndex = nil
            }
        }
        return str
    }
}
