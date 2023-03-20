//
//  OpenAIViewModel.swift
//  DALLEImageGen
//
//  Created by Jaehoon So on 2023/03/20.
//

import UIKit

import OpenAIKit

final class OpenAIViewModel {
    private var openai: OpenAI?
    
    func setup() {
        openai = OpenAI(
            Configuration(
                organizationId: "January1st",
                apiKey: "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"
            )
        )
    }
    
    func generateImage(prompt: String) async -> UIImage? {
        print(#function)
        guard let openai = openai else { return nil }
        
        do {
            let params = ImageParameters(
                prompt: prompt,
                resolution: .medium,
                responseFormat: .base64Json
            )
            let result = try await openai.createImage(parameters: params)
            let data = result.data[0].image
            let image = try openai.decodeBase64Image(data)
            
            return image
        } catch {
            print(String(describing: error))
            return nil
        }
    }
}
