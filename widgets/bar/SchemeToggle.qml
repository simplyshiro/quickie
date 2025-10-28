import qs.components
import qs.styles

IconButton {
    colorType: IconButton.ColorType.Standard
    onClicked: Color.toggleScheme()
    icon: Color.scheme === Color.light ? "light_mode" : "dark_mode"
}
