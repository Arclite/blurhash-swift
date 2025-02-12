#if canImport(UIKit)
import UIKit

struct UIImageRenderer {
    public init() {}

    public func render(_ blurHash: String, size: CGSize, punch: Float = 1) throws -> UIImage {
        let cgImage = try CGImageRenderer().render(blurHash, size: size, punch: punch)
        return UIImage(cgImage: cgImage)
    }
}

#endif
