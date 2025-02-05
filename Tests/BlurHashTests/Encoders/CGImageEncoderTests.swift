#if canImport(CoreGraphics) && canImport(ImageIO)
import CoreGraphics
import Foundation
import ImageIO
import Testing

@testable import BlurHash

struct CGImageEncoderTests {
    @Test(arguments: TestConstants.sampleHashResults)
    func encode(name: String, expectedHash: String) throws {
        let imageURL = try #require(Bundle.module.url(forResource: "TestResources/\(name)", withExtension: "png"))
        let imageData = try Data(contentsOf: imageURL)

        let dataProvider = try #require(CGDataProvider(data: imageData as CFData))
        let imageSource = try #require(CGImageSourceCreateWithDataProvider(dataProvider, nil))
        let image = try #require(CGImageSourceCreateImageAtIndex(imageSource, 0, nil))

        let actualHash = try CGImageEncoder().encode(image, numberOfComponents: (4, 3))
        #expect(actualHash == expectedHash)
    }
}
#endif

