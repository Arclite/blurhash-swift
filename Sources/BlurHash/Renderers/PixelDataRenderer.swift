import Foundation

public struct PixelDataRenderer {
    public init() {}
    
    public func render(_ blurHash: String, width: Int, height: Int, punch: Float = 1) throws -> PixelData {
        let output = try BlurHashDecoder().decode(blurHash, punch: punch)
        return render(output, width: width, height: height)
    }

    func render(_ output: BlurHashDecoder.Output, width: Int, height: Int) -> PixelData {
        let (xComponentCount, yComponentCount, colors) = output
        let bytesPerRow = width * 3
        var data = Data(count: bytesPerRow * height)

        for yPixel in 0 ..< height {
            for xPixel in 0 ..< width {
                var r: Float = 0
                var g: Float = 0
                var b: Float = 0

                for yComponent in 0 ..< yComponentCount {
                    for xComponent in 0 ..< xComponentCount {
                        let basis = cos(Float.pi * Float(xPixel) * Float(xComponent) / Float(width)) * cos(Float.pi * Float(yPixel) * Float(yComponent) / Float(height))
                        let color = colors[xComponent + yComponent * xComponentCount]
                        r += color.0 * basis
                        g += color.1 * basis
                        b += color.2 * basis
                    }
                }

                let intR = UInt8(Math.linearToSRGB(r))
                let intG = UInt8(Math.linearToSRGB(g))
                let intB = UInt8(Math.linearToSRGB(b))

                data[3 * xPixel + 0 + yPixel * bytesPerRow] = intR
                data[3 * xPixel + 1 + yPixel * bytesPerRow] = intG
                data[3 * xPixel + 2 + yPixel * bytesPerRow] = intB
            }
        }

        return PixelData(width: width, height: height, bytesPerPixel: 3, data: data)
    }
}
