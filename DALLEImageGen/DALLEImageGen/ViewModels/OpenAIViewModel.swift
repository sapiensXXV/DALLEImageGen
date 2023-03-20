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
        guard let path = Bundle.main.path(forResource: "Keys", ofType: "plist"),
              let keys = NSDictionary(contentsOfFile: path),
              let organizationId = keys.object(forKey: "OpenAIOrganizationID") as? String,
              let apiKey = keys.object(forKey: "OpenAIAPIKey") as? String else { return }
        openai = OpenAI(
            Configuration(
                organizationId: organizationId,
                apiKey: apiKey
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
