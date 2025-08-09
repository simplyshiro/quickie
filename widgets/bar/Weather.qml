import QtQuick

import qs.components
import qs.services
import qs.styles

M3Button {
    _color: colors.text
    _icon: Weather.icon
    onClicked: Weather.update()
    text: `${Weather.tempC}°C`
}
