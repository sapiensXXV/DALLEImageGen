//
//  OpenAIViewModelProtocol.swift
//  DALLEImageGen
//
//  Created by Jaehoon So on 2023/03/20.
//

import UIKit
import OpenAIKit

protocol OpenAIViewModelDelegate {
    
    func openAIResultImageDidChange(to image: UIImage)
    func openAIErrorOccur(with errorResponse: OpenAIErrorResponse)
}

enum OpenAIViewModelAction {
    case generateImage(String)
}
