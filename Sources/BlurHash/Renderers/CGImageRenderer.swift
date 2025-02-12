#if canImport(CoreGraphics)
import CoreGraphics

public struct CGImageRenderer {
    public init() {}

    public func render(_ blurHash: String, size: CGSize, punch: Float = 1) throws -> CGImage {
        let width = Int(size.width)
        let height = Int(size.height)
        let pixelData = try PixelDataRenderer().render(blurHash, width: width, height: height, punch: punch)

        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.none.rawValue)

        guard let provider = CGDataProvider(data: (pixelData.data as CFData))
        else { throw CGImageRendererError.cannotCreateDataProvider }

        guard let cgImage = CGImage(
            width: width,
            height: height,
            bitsPerComponent: 8,
            bitsPerPixel: 24,
            bytesPerRow: width * 3,
            space: CGColorSpaceCreateDeviceRGB(),
            bitmapInfo: bitmapInfo,
            provider: provider,
            decode: nil,
            shouldInterpolate: true,
            intent: .defaultIntent
        ) else { throw CGImageRendererError.dataProviderFailedToCreateImage }

        return cgImage
    }
}

enum CGImageRendererError: Error {
    case cannotCreateData
    case cannotCreateDataProvider
    case cannotCreatePixels
    case dataProviderFailedToCreateImage
}
#endif
