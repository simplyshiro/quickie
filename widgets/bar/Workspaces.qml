pragma ComponentBehavior: Bound

import QtQuick
import Quickshell.Hyprland

import qs.components
import qs.styles
import qs.styles.motion

Rectangle {
    id: root

    readonly property color containerColor: "transparent"
    readonly property color pillColor: Color.scheme._onSurfaceVariant
    readonly property color pillColorToggleUnselected: Color.scheme._onSurface
    readonly property color pillColorToggleSelected: Color.scheme.primary
    readonly property real pillSize: 8
    readonly property real pillSizeFocused: 24
    readonly property real betweenPillSpace: 8
    
    color: containerColor
    implicitHeight: 40

    // using `layout.width` results in jittering when pill width changes too fast
    implicitWidth: pillSizeFocused + (pillSize * (repeater.model - 1)) + (betweenPillSpace * repeater.model) + (16 * 2)

    radius: implicitHeight

    Behavior on color {
        ExpressiveFastColor {}
    }

    // `RowLayout` is pixel-aligned, animations look jittery
    Row {
        id: layout
        anchors.centerIn: parent
        spacing: root.betweenPillSpace

        Repeater {
            id: repeater
            model: 10

            delegate: Rectangle {
                required property int index
                readonly property int id: (index + 1)
                readonly property bool focused: Hyprland.focusedWorkspace?.id === id

                readonly property var occupied: {
                    Hyprland.workspaces.values.reduce((acc, curr) => {
                        acc[curr.id] = curr.lastIpcObject.windows >= 0;
                        return acc;
                    }, {})
                }
    
                color: focused ? root.pillColorToggleSelected : occupied[id] ? root.pillColorToggleUnselected : root.pillColor
                implicitHeight: root.pillSize
                implicitWidth: focused ? root.pillSizeFocused : root.pillSize
                radius: implicitHeight

                Behavior on color {
                    ExpressiveFastColor {}
                }

                Behavior on implicitWidth {
                    ExpressiveFastSpatial {}
                }
            }
        }
    }

    MouseArea {
        anchors.fill: parent
        cursorShape: undefined
        hoverEnabled: true

        onWheel: (wheel) => {
            if (wheel.angleDelta.y > 0) {
                if (Hyprland.focusedWorkspace.id === 1) {
                    Hyprland.dispatch(`workspace ${repeater.model}`);
                } else {
                    Hyprland.dispatch("workspace -1");
                }
            }

            if (wheel.angleDelta.y < 0) {
                if (Hyprland.focusedWorkspace.id === repeater.model) {
                    Hyprland.dispatch("workspace 1");
                } else {
                    Hyprland.dispatch("workspace +1");
                }
            }
        }

        Rectangle {
            anchors.fill: parent
            color: root.pillColor
            opacity: parent.pressed ? 0.1 : parent.containsMouse ? 0.08 : 0
            radius: root.radius

            Behavior on color {
                ExpressiveFastColor {}
            }

            Behavior on opacity {
                ExpressiveFastEffects {}
            }
        }
    }
}
