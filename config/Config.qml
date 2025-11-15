pragma Singleton

import Quickshell
import Quickshell.Io

Singleton {
    readonly property var object: JSON.parse(json.text())
    readonly property var location: object.location

    FileView {
        id: json

        blockLoading: true
        path: `${Quickshell.shellDir}/shell.json`
    }
}
