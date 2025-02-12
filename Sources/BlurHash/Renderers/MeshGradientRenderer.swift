#if canImport(SwiftUI)
import SwiftUI

@available(iOS 18.0, *)
public struct MeshGradientRenderer {
    public init() {}

    public func render(_ blurHash: String, punch: Float = 1) throws -> MeshGradient {
        let output = try BlurHashDecoder().decode(blurHash, punch: punch)
        let (width, height, _) = output
        let pixelData = PixelDataRenderer().render(output, width: width, height: height)
        let data = pixelData.data

        var points = [SIMD2<Float>]()
        var colors = [Color]()
        let maxWidth = Float(width) - 1
        let maxHeight = Float(height) - 1
        for y in 0..<height {
            for x in 0..<width {
                let index = (y * width + x) * 3
                let r = Double(data[index]) / 255
                let g = Double(data[index + 1]) / 255
                let b = Double(data[index + 2]) / 255
                points.append(SIMD2(Float(x) / maxWidth, Float(y) / maxHeight))
                colors.append(Color(red: r, green: g, blue: b))
            }
        }

        return MeshGradient(
            width: width,
            height: height,
            points: points,
            colors: colors
        )
    }
}

enum MeshGradientRendererError: Error {
    case notImplemented
}
#endif
