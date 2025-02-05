#if canImport(UIKit)
import UIKit

struct UIImageEncoder {
    func encode(_ image: UIImage, numberOfComponents components: (Int, Int)) throws -> String {
        let pixelData = try image.pixelData
        return try PixelDataEncoder().encode(pixelData, numberOfComponents: components)
    }
}
#endif
