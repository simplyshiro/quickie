import QtQuick
import QtQuick.Layouts
import Quickshell

import qs.styles
import qs.styles.motion

Scope {
    Variants {
        model: Quickshell.screens

        PanelWindow {
            property var modelData

            anchors.bottom: true
            anchors.left: true
            anchors.right: true
            color: Color.scheme.surfaceContainer
            implicitHeight: 64
            screen: modelData

            Behavior on color {
                ExpressiveDefaultColor {}
            }

            RowLayout {
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                anchors.leftMargin: 40
                anchors.top: parent.top
                spacing: 4

                SchemeToggle {}
            }

            RowLayout {
                anchors.centerIn: parent

                Workspaces {}
            }

            RowLayout {
                anchors.bottom: parent.bottom
                anchors.right: parent.right
                anchors.rightMargin: 40
                anchors.top: parent.top

                Weather {}
                ClockDate {}
            }
        }
    }
}
