pragma Singleton

import Quickshell
import Quickshell.Io

Singleton {
    readonly property var json: JSON.parse(file.text())
    readonly property var latitude: json.latitude
    readonly property var longitude: json.longitude

    FileView {
        id: file
        blockLoading: true
        path: `${Quickshell.shellDir}/location.json`
    }
}
