import QtQuick

import qs.components
import qs.services

M3Button {
    colorType: M3Button.ColorType.Standard
    icon: Weather.icon
    onClicked: Weather.update()
    text: `${Weather.tempC}°C`
}
