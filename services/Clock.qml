pragma Singleton

import QtQuick
import Quickshell

Singleton {
    readonly property date date: clock.date
    readonly property int hours: clock.hours
    readonly property int minutes: clock.minutes

    SystemClock {
        id: clock

        readonly property bool has15MinutesPassed: (minutes % 15) === 0

        onDateChanged: {
            if (clock.has15MinutesPassed) {
                Weather.update();
            }
        }

        precision: SystemClock.Minutes
    }
}
