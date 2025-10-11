import QtQuick

import qs.styles
import qs.styles.motion

Text {
    readonly property QtObject typescales: QtObject {
        readonly property var displayLarge: {
            "letterSpacing": -0.25,
            "pixelSize": 56,
            "weight": 400,
            "lineHeight": 64
        }

        readonly property var displayMedium: {
            "letterSpacing": 0,
            "pixelSize": 45,
            "weight": 400,
            "lineHeight": 52
        }

        readonly property var displaySmall: {
            "letterSpacing": 0,
            "pixelSize": 36,
            "weight": 400,
            "lineHeight": 44
        }

        readonly property var headlineLarge: {
            "letterSpacing": 0,
            "pixelSize": 32,
            "weight": 400,
            "lineHeight": 40
        }

        readonly property var headlineMedium: {
            "letterSpacing": 0,
            "pixelSize": 28,
            "weight": 400,
            "lineHeight": 36
        }

        readonly property var headlineSmall: {
            "letterSpacing": 0,
            "pixelSize": 24,
            "weight": 400,
            "lineHeight": 32
        }

        readonly property var titleLarge: {
            "letterSpacing": 0,
            "pixelSize": 22,
            "weight": 400,
            "lineHeight": 28
        }

        readonly property var titleMedium: {
            "letterSpacing": 0.15,
            "pixelSize": 16,
            "weight": 500,
            "lineHeight": 24
        }

        readonly property var titleSmall: {
            "letterSpacing": 0.1,
            "pixelSize": 14,
            "weight": 500,
            "lineHeight": 20
        }

        readonly property var bodyLarge: {
            "letterSpacing": 0.5,
            "pixelSize": 16,
            "weight": 400,
            "lineHeight": 24
        }

        readonly property var bodyMedium: {
            "letterSpacing": 0.25,
            "pixelSize": 14,
            "weight": 400,
            "lineHeight": 20
        }

        readonly property var bodySmall: {
            "letterSpacing": 0.4,
            "pixelSize": 12,
            "weight": 400,
            "lineHeight": 16
        }

        readonly property var labelLarge: {
            "letterSpacing": 0.1,
            "pixelSize": 14,
            "weight": 500,
            "lineHeight": 20
        }

        readonly property var labelMedium: {
            "letterSpacing": 0.5,
            "pixelSize": 12,
            "weight": 500,
            "lineHeight": 16
        }

        readonly property var labelSmall: {
            "letterSpacing": 0.5,
            "pixelSize": 11,
            "weight": 500,
            "lineHeight": 16
        }
    }

    property var typescale: typescales.bodyMedium

    property bool emphasized: false
    property int grad: Color.light ? 0 : -25
    property int pixelSize: typescale.pixelSize
    property int weight: emphasized ? (typescale.weight + 100) : typescale.weight

    color: Color.scheme._onSurface
    font.family: "Roboto Flex"
    font.hintingPreference: Font.PreferNoHinting
    font.letterSpacing: typescale.letterSpacing
    font.pixelSize: pixelSize
    font.preferTypoLineMetrics: true

    font.variableAxes: {
        "GRAD": grad,
        "opsz": pixelSize,
        "wght": weight
    }

    font.weight: weight
    horizontalAlignment: Text.AlignHCenter
    lineHeight: typescale.lineHeight
    lineHeightMode: Text.FixedHeight
    renderType: Text.NativeRendering
    verticalAlignment: Text.AlignVCenter

    Behavior on color {
        ExpressiveFastColor {}
    }
}
