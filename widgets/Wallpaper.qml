import QtQuick
import Quickshell
import Quickshell.Wayland

Scope {
    Variants {
        model: Quickshell.screens

        PanelWindow {
            id: panelWindow

            required property ShellScreen modelData

            WlrLayershell.exclusionMode: ExclusionMode.Ignore
            WlrLayershell.layer: WlrLayer.Background
            anchors.bottom: true
            anchors.left: true
            anchors.right: true
            anchors.top: true
            color: "transparent"
            screen: modelData

            Image {
                anchors.fill: parent
                asynchronous: true
                cache: false
                fillMode: Image.PreserveAspectCrop
                source: `${Quickshell.shellDir}/wallpaper`
                sourceSize.height: panelWindow.screen.height
                sourceSize.width: panelWindow.screen.width
            }
        }
    }
}
