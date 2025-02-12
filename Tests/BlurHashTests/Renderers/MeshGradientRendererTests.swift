#if canImport(SwiftUI)
import SwiftUI
import Testing

@testable import BlurHash

struct MeshGradientRendererTests {
    @Test @available(iOS 18.0, *)
    func render() throws {
        let gradient = try MeshGradientRenderer().render("LbJal#Vu8{~pkXsmR,a~xZoLWCRj")

        guard case .colors(let colors) = gradient.colors,
              case .points(let points) = gradient.locations
        else {
            Issue.record("Unknown color (\(String(describing: gradient.colors))) or locations (\(String(describing: gradient.locations))) type")
            return
        }

        #expect(gradient.width == 4)
        #expect(gradient.height == 3)

        #expect(colors.count == 12)
        #expect(points.count == 12)

        #expect(points[0].equals(SIMD2<Float>(0, 0), accuracy: 0.01))
        #expect(points[1].equals(SIMD2<Float>(1/3, 0), accuracy: 0.01))
        #expect(points[2].equals(SIMD2<Float>(2/3, 0), accuracy: 0.01))
        #expect(points[3].equals(SIMD2<Float>(1, 0), accuracy: 0.01))
        #expect(points[4].equals(SIMD2<Float>(0, 1/2), accuracy: 0.01))
        #expect(points[5].equals(SIMD2<Float>(1/3, 1/2), accuracy: 0.01))
        #expect(points[6].equals(SIMD2<Float>(2/3, 1/2), accuracy: 0.01))
        #expect(points[7].equals(SIMD2<Float>(1, 1/2), accuracy: 0.01))
        #expect(points[8].equals(SIMD2<Float>(0, 1), accuracy: 0.01))
        #expect(points[9].equals(SIMD2<Float>(1/3, 1), accuracy: 0.01))
        #expect(points[10].equals(SIMD2<Float>(2/3, 1), accuracy: 0.01))
        #expect(points[11].equals(SIMD2<Float>(1, 1), accuracy: 0.01))
    }
}

extension SIMD2<Float> {
    func equals(_ value: SIMD2<Float>, accuracy: Float) -> Bool {
        abs(x - value.x) < accuracy &&
        abs(y - value.y) < accuracy
    }
}
#endif
