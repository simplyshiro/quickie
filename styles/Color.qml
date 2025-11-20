pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    readonly property bool isDark: scheme === dark

    readonly property QtObject light: QtObject {
        readonly property color primary: "#6750a4"
        readonly property color _onPrimary: "#ffffff"
        readonly property color primaryContainer: "#eaddff"
        readonly property color _onPrimaryContainer: "#4f378b"
        readonly property color secondary: "#625b71"
        readonly property color _onSecondary: "#ffffff"
        readonly property color secondaryContainer: "#e8def8"
        readonly property color _onSecondaryContainer: "#4a4458"
        readonly property color tertiary: "#7d5260"
        readonly property color _onTertiary: "#ffffff"
        readonly property color tertiaryContainer: "#ffd8e4"
        readonly property color _onTertiaryContainer: "#633b48"
        readonly property color error: "#b3261e"
        readonly property color _onError: "#ffffff"
        readonly property color errorContainer: "#f9dedc"
        readonly property color _onErrorContainer: "#8c1d18"
        readonly property color surface: "#fef7ff"
        readonly property color _onSurface: "#1d1b20"
        readonly property color surfaceVariant: "#e7e0ec"
        readonly property color _onSurfaceVariant: "#49454f"
        readonly property color surfaceContainerHighest: "#e6e0e9"
        readonly property color surfaceContainerHigh: "#ece6f0"
        readonly property color surfaceContainer: "#f3edf7"
        readonly property color surfaceContainerLow: "#f7f2fa"
        readonly property color surfaceContainerLowest: "#ffffff"
        readonly property color inverseSurface: "#322f35"
        readonly property color inverseOnSurface: "#f5eff7"
        readonly property color outline: "#79747e"
        readonly property color outlineVariant: "#cac4d0"
    }

    readonly property QtObject dark: QtObject {
        readonly property color primary: "#d0bcff"
        readonly property color _onPrimary: "#381e72"
        readonly property color primaryContainer: "#4f378b"
        readonly property color _onPrimaryContainer: "#eaddff"
        readonly property color secondary: "#ccc2dc"
        readonly property color _onSecondary: "#332d41"
        readonly property color secondaryContainer: "#4a4458"
        readonly property color _onSecondaryContainer: "#e8def8"
        readonly property color tertiary: "#efb8c8"
        readonly property color _onTertiary: "#492532"
        readonly property color tertiaryContainer: "#633b48"
        readonly property color _onTertiaryContainer: "#ffd8e4"
        readonly property color error: "#f2b8b5"
        readonly property color _onError: "#601410"
        readonly property color errorContainer: "#8c1d18"
        readonly property color _onErrorContainer: "#f9dedc"
        readonly property color surface: "#141218"
        readonly property color _onSurface: "#e6e0e9"
        readonly property color surfaceVariant: "#49454f"
        readonly property color _onSurfaceVariant: "#cac4d0"
        readonly property color surfaceContainerHighest: "#36343b"
        readonly property color surfaceContainerHigh: "#2b2930"
        readonly property color surfaceContainer: "#211f26"
        readonly property color surfaceContainerLow: "#1d1b20"
        readonly property color surfaceContainerLowest: "#0f0d13"
        readonly property color inverseSurface: "#e6e0e9"
        readonly property color inverseOnSurface: "#322f35"
        readonly property color outline: "#938f99"
        readonly property color outlineVariant: "#49454f"
    }

    property QtObject scheme: light

    function toggleScheme() {
        if (isDark) {
            scheme = light;
            footSwitchToLightTheme.startDetached();
        } else {
            scheme = dark;
            footSwitchToDarkTheme.startDetached();
        }
    }

    readonly property Process footSwitchToDarkTheme: Process {
        command: ["fish", "-c", "pkill -SIGUSR1 foot"]
    }

    readonly property Process footSwitchToLightTheme: Process {
        command: ["fish", "-c", "pkill -SIGUSR2 foot"]
    }
}
