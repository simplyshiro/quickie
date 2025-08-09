import QtQuick
import QtQuick.Layouts

import qs.services
import qs.styles

Item {
    implicitHeight: 40
    implicitWidth: layout.width + (16 * 2)

    RowLayout {
        id: layout
        anchors.centerIn: parent
        spacing: 8

        M3Text {
            color: Color.scheme._onSurfaceVariant
            text: Qt.formatDateTime(Clock.date, "ddd, MMM d")
            typescale: typescales.labelLarge
        }

        M3Text {
            text: Qt.formatDateTime(Clock.date, "hh:mm")
            typescale: typescales.labelLarge
        }
    }
}
