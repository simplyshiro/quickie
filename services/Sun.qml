pragma Singleton

import QtQuick
import Quickshell

import qs.config

Singleton {
    readonly property QtObject sunrise: QtObject {
        property date date
        readonly property int hours: date.getHours()
        readonly property int minutes: date.getMinutes()
    }

    readonly property QtObject sunset: QtObject {
        property date date
        readonly property int hours: date.getHours()
        readonly property int minutes: date.getMinutes()
    }

    readonly property bool sunrised: Clock.date >= sunrise.date
    readonly property bool sunsetted: Clock.date >= sunset.date

    function update() {
        const url = `https://api.sunrise-sunset.org/json?lat=${Config.location.latitude}&lng=${Config.location.longitude}&formatted=0`;

        Request.get(url, text => {
            const json = JSON.parse(text).results;
            sunrise.date = json.sunrise;
            sunset.date = json.sunset;
        });
    }
}
