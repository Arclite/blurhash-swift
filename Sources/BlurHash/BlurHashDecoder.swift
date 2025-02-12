struct BlurHashDecoder {
    typealias Output = (xComponentCount: Int, yComponentCount: Int, colors: [(Float, Float, Float)])
    func decode(_ blurHash: String, punch: Float = 1) throws -> Output {
        guard blurHash.count >= 6 else { throw BlurHashDecoderError.invalidHashLength }

        let sizeFlag = String(blurHash[0]).decode83()
        let yComponentCount = (sizeFlag / 9) + 1
        let xComponentCount = (sizeFlag % 9) + 1

        let quantisedMaximumValue = String(blurHash[1]).decode83()
        let maximumValue = Float(quantisedMaximumValue + 1) / 166

        guard blurHash.count == 4 + 2 * xComponentCount * yComponentCount else { throw BlurHashDecoderError.invalidHashLength }

        let colors: [(Float, Float, Float)] = (0 ..< xComponentCount * yComponentCount).map { i in
            if i == 0 {
                let value = String(blurHash[2 ..< 6]).decode83()
                return decodeDC(value)
            } else {
                let value = String(blurHash[4 + i * 2 ..< 4 + i * 2 + 2]).decode83()
                return decodeAC(value, maximumValue: maximumValue * punch)
            }
        }

        return (xComponentCount, yComponentCount, colors)
    }
}

enum BlurHashDecoderError: Error {
    case invalidHashLength
}
