#if canImport(UIKit)
import Foundation
import UIKit
import Testing

@testable import BlurHash

struct UIImageEncoderTests {
    @Test(arguments: TestConstants.sampleHashResults)
    func encode(name: String, expectedHash: String) throws {
        let imageURL = try #require(Bundle.module.url(forResource: "TestResources/\(name)", withExtension: "png"))
        let imageData = try Data(contentsOf: imageURL)
        let image = try #require(UIImage(data: imageData))

        let actualHash = try UIImageEncoder().encode(image, numberOfComponents: (4, 3))
        #expect(actualHash == expectedHash)
    }
}
#endif
