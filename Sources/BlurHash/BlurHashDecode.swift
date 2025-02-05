import Foundation

func decodeDC(_ value: Int) -> (Float, Float, Float) {
    let intR = value >> 16
    let intG = (value >> 8) & 255
    let intB = value & 255
    return (Math.srgbToLinear(intR), Math.srgbToLinear(intG), Math.srgbToLinear(intB))
}

func decodeAC(_ value: Int, maximumValue: Float) -> (Float, Float, Float) {
    let quantR = value / (19 * 19)
    let quantG = (value / 19) % 19
    let quantB = value % 19

    let rgb = (
        Math.signPow((Float(quantR) - 9) / 9, 2) * maximumValue,
        Math.signPow((Float(quantG) - 9) / 9, 2) * maximumValue,
        Math.signPow((Float(quantB) - 9) / 9, 2) * maximumValue
    )

    return rgb
}
