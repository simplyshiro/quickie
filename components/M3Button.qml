import QtQuick
import QtQuick.Layouts

import qs.styles
import qs.styles.motion

Rectangle {
    id: root

    enum SizeType {
        Xsmall,
        Small,
        Medium,
        Large,
        Xlarge
    }

    enum ShapeType {
        Round,
        Square
    }

    enum ColorType {
        // TODO Elevated,
        Filled,
        Tonal,
        Outlined,
        Standard
    }

    property int sizeType: M3Button.SizeType.Small
    property real containerHeight: sizeType === M3Button.SizeType.Xsmall ? 32 : sizeType === M3Button.SizeType.Small ? 40 : sizeType === M3Button.SizeType.Medium ? 56 : sizeType === M3Button.SizeType.Large ? 96 : sizeType === M3Button.SizeType.Xlarge ? 136 : null
    property int outlineWidth: sizeType === M3Button.SizeType.Xsmall ? 1 : sizeType === M3Button.SizeType.Small ? 1 : sizeType === M3Button.SizeType.Medium ? 1 : sizeType === M3Button.SizeType.Large ? 2 : sizeType === M3Button.SizeType.Xlarge ? 3 : null
    property int iconSize: sizeType === M3Button.SizeType.Xsmall ? 20 : sizeType === M3Button.SizeType.Small ? 20 : sizeType === M3Button.SizeType.Medium ? 24 : sizeType === M3Button.SizeType.Large ? 32 : sizeType === M3Button.SizeType.Xlarge ? 40 : null
    property real leadingTrailingSpace: sizeType === M3Button.SizeType.Xsmall ? 12 : sizeType === M3Button.SizeType.Small ? 16 : sizeType === M3Button.SizeType.Medium ? 24 : sizeType === M3Button.SizeType.Large ? 48 : sizeType === M3Button.SizeType.Xlarge ? 64 : null
    property real betweenIconLabelSpace: sizeType === M3Button.SizeType.Xsmall ? 8 : sizeType === M3Button.SizeType.Small ? 8 : sizeType === M3Button.SizeType.Medium ? 8 : sizeType === M3Button.SizeType.Large ? 12 : sizeType === M3Button.SizeType.Xlarge ? 16 : null
    property real shapePressedMorph: sizeType === M3Button.SizeType.Xsmall ? 8 : sizeType === M3Button.SizeType.Small ? 8 : sizeType === M3Button.SizeType.Medium ? 12 : sizeType === M3Button.SizeType.Large ? 16 : sizeType === M3Button.SizeType.Xlarge ? 16 : null

    property int shapeType: M3Button.ShapeType.Round
    property real containerShape: {
        switch (shapeType) {
        case M3Button.ShapeType.Round:
            return containerHeight;
        case M3Button.ShapeType.Square:
            switch (sizeType) {
            case M3Button.SizeType.Xsmall:
            case M3Button.SizeType.Small:
                return 12;
            case M3Button.SizeType.Medium:
                return 16;
            case M3Button.SizeType.Large:
            case M3Button.SizeType.Xlarge:
                return 28;
            }
        }
    }
    property real selectedContainerShape: {
        switch (shapeType) {
        case M3Button.ShapeType.Round:
            switch (sizeType) {
            case M3Button.SizeType.Xsmall:
            case M3Button.SizeType.Small:
                return 12;
            case M3Button.SizeType.Medium:
                return 16;
            case M3Button.SizeType.Large:
            case M3Button.SizeType.Xlarge:
                return 28;
            }
        case M3Button.ShapeType.Square:
            return containerHeight;
        }
    }

    property int colorType: M3Button.ColorType.Filled
    property color containerColor: colorType === M3Button.ColorType.Filled ? Color.scheme.primary : colorType === M3Button.ColorType.Tonal ? Color.scheme.secondaryContainer : "transparent"
    property color containerColorToggleUnselected: colorType === M3Button.ColorType.Filled ? Color.scheme.surfaceContainer : colorType === M3Button.ColorType.Tonal ? Color.scheme.secondaryContainer : "transparent"
    property color containerColorToggleSelected: colorType === M3Button.ColorType.Filled ? Color.scheme.primary : colorType === M3Button.ColorType.Tonal ? Color.scheme.secondary : colorType === M3Button.ColorType.Outlined ? Color.scheme.inverseSurface : "transparent"
    property color labelIconColor: colorType === M3Button.ColorType.Filled ? Color.scheme._onPrimary : colorType === M3Button.ColorType.Tonal ? Color.scheme._onSecondaryContainer : colorType === M3Button.ColorType.Outlined ? Color.scheme._onSurfaceVariant : colorType === M3Button.ColorType.Standard ? Color.scheme.primary : null
    property color labelIconColorToggleUnselected: colorType === M3Button.ColorType.Filled ? Color.scheme._onSurfaceVariant : colorType === M3Button.ColorType.Tonal ? Color.scheme._onSecondaryContainer : colorType === M3Button.ColorType.Outlined ? Color.scheme._onSurfaceVariant : null
    property color labelIconColorToggleSelected: colorType === M3Button.ColorType.Filled ? Color.scheme._onPrimary : colorType === M3Button.ColorType.Tonal ? Color.scheme._onSecondary : colorType === M3Button.ColorType.Outlined ? Color.scheme.inverseOnSurface : null
    property color outlineColor: colorType === M3Button.ColorType.Outlined ? Color.scheme.outlineVariant : "transparent"
    property color outlineColorToggleUnselected: colorType === M3Button.ColorType.Outlined ? Color.scheme.outlineVariant : "transparent"
    property color outlineColorToggleSelected: "transparent"

    required property string text

    property string icon

    property bool checkable: false
    property bool checked: false
    property alias enabled: mouseArea.enabled

    signal clicked

    function onClicked() {
        if (checkable) {
            checked = !checked;
        }
        clicked();
    }

    border.color: (checkable && checked) ? outlineColorToggleSelected : (checkable && !checked) ? outlineColorToggleUnselected : enabled ? outlineColor : colorType === M3Button.ColorType.Outlined ? Color.scheme.outlineVariant : "transparent"
    border.width: outlineWidth
    color: (checkable && checked) ? containerColorToggleSelected : (checkable && !checked) ? containerColorToggleUnselected : enabled ? containerColor : colorType === M3Button.ColorType.Outlined ? "transparent" : Qt.alpha(Color.scheme._onSurface, 0.1)
    implicitHeight: containerHeight
    implicitWidth: rowLayout.width + (leadingTrailingSpace * 2)
    radius: (checkable && checked) ? selectedContainerShape : mouseArea.pressed ? shapePressedMorph : containerShape

    Behavior on border.color {
        ExpressiveFastColor {}
    }

    Behavior on color {
        ExpressiveFastColor {}
    }

    Behavior on radius {
        ExpressiveFastSpatial {}
    }

    RowLayout {
        id: rowLayout

        anchors.centerIn: parent
        spacing: root.betweenIconLabelSpace

        M3Icon {
            id: icon

            color: (root.checkable && root.checked) ? root.labelIconColorToggleSelected : (root.checkable && !root.checked) ? root.labelIconColorToggleUnselected : root.enabled ? root.labelIconColor : Qt.alpha(Color.scheme._onSurface, 0.38)
            filled: (root.checkable && root.checked) ? true : mouseArea.containsMouse ? true : false
            icon: root.icon
            pixelSize: root.iconSize
            visible: root.icon

            Behavior on color {
                ExpressiveFastColor {}
            }
        }

        M3Text {
            id: label

            color: (root.checkable && root.checked) ? root.labelIconColorToggleSelected : (root.checkable && !root.checked) ? root.labelIconColorToggleUnselected : root.enabled ? root.labelIconColor : Qt.alpha(Color.scheme._onSurface, 0.38)
            text: root.text
            typescale: root.sizeType === M3Button.SizeType.Xsmall ? typescales.labelLarge : root.sizeType === M3Button.SizeType.Small ? typescales.labelLarge : root.sizeType === M3Button.SizeType.Medium ? typescales.titleMedium : root.sizeType === M3Button.SizeType.Large ? typescales.headlineSmall : root.sizeType === M3Button.SizeType.Xlarge ? typescales.headlineLarge : null

            Behavior on color {
                ExpressiveFastColor {}
            }
        }
    }

    MouseArea {
        id: mouseArea

        anchors.fill: parent
        cursorShape: enabled ? Qt.PointingHandCursor : undefined
        hoverEnabled: true
        onClicked: root.onClicked()

        Rectangle {
            anchors.fill: parent
            color: (root.checkable && root.checked) ? root.labelIconColorToggleSelected : (root.checkable && !root.checked) ? root.labelIconColorToggleUnselected : root.enabled ? root.labelIconColor : Qt.alpha(Color.scheme._onSurface, 0.38)
            opacity: parent.pressed ? 0.1 : parent.containsMouse ? 0.08 : 0
            radius: root.radius
            visible: parent.enabled

            Behavior on color {
                ExpressiveFastColor {}
            }

            Behavior on opacity {
                ExpressiveFastEffects {}
            }
        }
    }
}
