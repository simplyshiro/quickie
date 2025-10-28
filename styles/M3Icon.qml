import QtQuick

import qs.styles

M3Text {
    id: root

    required property string icon

    property bool filled: false

    color: Color.scheme._onSurface
    font.family: "Material Symbols Rounded"
    pixelSize: 24

    font.variableAxes: {
        "FILL": filled ? 1 : 0,
        "GRAD": grad,
        "opsz": pixelSize,
        "wght": weight
    }

    text: icon
}
