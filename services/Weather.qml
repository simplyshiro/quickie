pragma Singleton

import QtQuick
import Quickshell

import qs.config

Singleton {
    // property string description: "Clear sky"
    property string icon: "clear_day"
    property int tempC: 0

    /* readonly property var weatherDescriptions: ({
        "0": "Clear sky",
        "1": "Mainly clear",
        "2": "Partly cloudy",
        "3": "Overcast",
        "45": "Fog",
        "48": "Depositing rime fog",
        "51": "Light drizzle",
        "53": "Moderate drizzle",
        "55": "Dense drizzle",
        "56": "Light freezing drizzle",
        "57": "Dense freezing drizzle",
        "61": "Slight rain",
        "63": "Moderate rain",
        "65": "Heavy rain",
        "66": "Light freezing rain",
        "67": "Heavy freezing rain",
        "71": "Slight snow fall",
        "73": "Moderate snow fall",
        "75": "Heavy snow fall",
        "77": "Snow grains",
        "80": "Slight rain showers",
        "81": "Moderate rain showers",
        "82": "Violent rain showers",
        "85": "Slight snow showers",
        "86": "Heavy snow showers",
        "95": "Thunderstorm",
        "96": "Thunderstorm with slight hail",
        "99": "Thunderstorm with heavy hail"
    }) */

    readonly property var weatherIcons: ({
            "0": "clear_day",
            "1": "clear_day",
            "2": "partly_cloudy_day",
            "3": "cloud",
            "45": "foggy",
            "48": "foggy",
            "51": "rainy",
            "53": "rainy",
            "55": "rainy",
            "56": "rainy",
            "57": "rainy",
            "61": "rainy",
            "63": "rainy",
            "65": "rainy",
            "66": "rainy",
            "67": "rainy",
            "71": "weather_snowy",
            "73": "weather_snowy",
            "75": "weather_snowy",
            "77": "weather_snowy",
            "80": "rainy",
            "81": "rainy",
            "82": "rainy",
            "85": "weather_snowy",
            "86": "weather_snowy",
            "95": "thunderstorm",
            "96": "weather_hail",
            "99": "weather_hail"
        })

    function getWeatherDescription(code) {
        return weatherDescriptions[code];
    }

    function getWeatherIcon(code) {
        if ((Sun.sunsetted || !Sun.sunrised) && (code === 0 || code === 1)) {
            return "bedtime";
        } else if ((Sun.sunsetted || !Sun.sunrised) && (code === 2)) {
            return "partly_cloudy_night";
        } else {
            return weatherIcons[code];
        }
    }

    function update() {
        const url = `https://api.open-meteo.com/v1/forecast?latitude=${Config.location.latitude}&longitude=${Config.location.longitude}&current=apparent_temperature,weather_code&timezone=auto`;
        Sun.update();

        Request.get(url, text => {
            const json = JSON.parse(text).current;
            // description = getWeatherDescription(json.weather_code);
            icon = getWeatherIcon(json.weather_code);
            tempC = Math.round(json.apparent_temperature);
        });
    }

    Component.onCompleted: update()
}
