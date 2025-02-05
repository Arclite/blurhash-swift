#if canImport(CoreGraphics)
import CoreGraphics

struct CGImageEncoder {
    func encode(_ image: CGImage, numberOfComponents components: (Int, Int)) throws -> String {
        let pixelData = try image.pixelData
        return try PixelDataEncoder().encode(pixelData, numberOfComponents: components)
    }
}
#endif
