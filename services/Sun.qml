pragma Singleton

import QtQuick
import Quickshell

import qs.config

Singleton {
    readonly property QtObject rise: QtObject {
        property date date

        readonly property int hours: date.getHours()
        readonly property int minutes: date.getMinutes()
    }

    readonly property QtObject set: QtObject {
        property date date

        readonly property int hours: date.getHours()
        readonly property int minutes: date.getMinutes()
    }

    readonly property bool rised: Clock.date >= rise.date
    readonly property bool setted: Clock.date >= set.date

    function update() {
        const url = `https://api.sunrise-sunset.org/json?lat=${Location.latitude}&lng=${Location.longitude}&formatted=0`;

        Request.get(url, text => {
            const json = JSON.parse(text).results;
            rise.date = json.sunrise;
            set.date = json.sunset;
        });
    }
}
