pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import Quickshell.Io
import Quickshell.Wayland

import qs.components
import qs.styles

Scope {
    Loader {
        id: loader
        active: false

        PanelWindow {
            id: panel

            anchors.bottom: true
            anchors.left: true
            anchors.right: true
            anchors.top: true
            color: "transparent"
            visible: loader.active
            WlrLayershell.exclusionMode: ExclusionMode.Ignore
            WlrLayershell.keyboardFocus: WlrKeyboardFocus.Exclusive
            WlrLayershell.layer: WlrLayer.Overlay

            contentItem {
                focus: true
                Keys.onEscapePressed: loader.active = false
            }

            Rectangle {
                anchors.fill: parent
                color: Qt.alpha("black", 0.32)

                MouseArea {
                    anchors.fill: parent
                    onClicked: loader.active = false

                    Rectangle {
                        anchors.centerIn: parent
                        color: Color.scheme.surface
                        height: row.height + (24 * 2)
                        width: row.width + (24 * 2)
                        radius: 16

                        RowLayout {
                            id: row
                            anchors.centerIn: parent
                            spacing: 8

                            PowerButton {
                                command: "systemctl poweroff"
                                text: "mode_off_on"
                            }

                            PowerButton {
                                _color: colors.tonal
                                command: "systemctl reboot"
                                text: "restart_alt"
                            }

                            PowerButton {
                                _color: colors.tonal
                                command: "systemctl reboot --boot-loader-entry=auto-windows"
                                text: "browse"
                            }

                            PowerButton {
                                _color: colors.tonal
                                command: "loginctl terminate-user ''"
                                text: "logout"
                            }
                        }
                    }
                }
            }
        }
    }

    GlobalShortcut {
        name: "powerPanel"
        onPressed: loader.active = !loader.active
    }

    component PowerButton: IconButton {
        id: button

        required property string command

        readonly property Process process: Process {
            command: ["fish", "-c", button.command]
        }

        onClicked: process.startDetached()
        size: sizes.medium
    }
}
