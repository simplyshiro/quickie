import qs.components
import qs.styles

IconButton {
    _color: colors.standard
    onClicked: Color.toggleScheme()
    text: Color.scheme === Color.light ? "light_mode" : "dark_mode"
}
