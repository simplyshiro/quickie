import QtQuick

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

    enum WidthType {
        Narrow,
        Default,
        Wide
    }

    property int sizeType: IconButton.SizeType.Small
    property real containerHeight: sizeType === IconButton.SizeType.Xsmall ? 32 : sizeType === IconButton.SizeType.Small ? 40 : sizeType === IconButton.SizeType.Medium ? 56 : sizeType === IconButton.SizeType.Large ? 96 : sizeType === IconButton.SizeType.Xlarge ? 136 : null
    property int outlineWidth: sizeType === IconButton.SizeType.Xsmall ? 1 : sizeType === IconButton.SizeType.Small ? 1 : sizeType === IconButton.SizeType.Medium ? 1 : sizeType === IconButton.SizeType.Large ? 2 : sizeType === IconButton.SizeType.Xlarge ? 3 : null
    property int iconSize: sizeType === IconButton.SizeType.Xsmall ? 20 : sizeType === IconButton.SizeType.Small ? 24 : sizeType === IconButton.SizeType.Medium ? 24 : sizeType === IconButton.SizeType.Large ? 32 : sizeType === IconButton.SizeType.Xlarge ? 40 : null
    property real shapePressedMorph: sizeType === IconButton.SizeType.Xsmall ? 8 : sizeType === IconButton.SizeType.Small ? 8 : sizeType === IconButton.SizeType.Medium ? 12 : sizeType === IconButton.SizeType.Large ? 16 : sizeType === IconButton.SizeType.Xlarge ? 16 : null

    property int shapeType: IconButton.ShapeType.Round
    property real containerShape: {
        switch (shapeType) {
        case IconButton.ShapeType.Round:
            return containerHeight;
        case IconButton.ShapeType.Square:
            switch (sizeType) {
            case IconButton.SizeType.Xsmall:
            case IconButton.SizeType.Small:
                return 12;
            case IconButton.SizeType.Medium:
                return 16;
            case IconButton.SizeType.Large:
            case IconButton.SizeType.Xlarge:
                return 28;
            }
        }
    }
    property real selectedContainerShape: {
        switch (shapeType) {
        case IconButton.ShapeType.Round:
            switch (sizeType) {
            case IconButton.SizeType.Xsmall:
            case IconButton.SizeType.Small:
                return 12;
            case IconButton.SizeType.Medium:
                return 16;
            case IconButton.SizeType.Large:
            case IconButton.SizeType.Xlarge:
                return 28;
            }
        case IconButton.ShapeType.Square:
            return containerHeight;
        }
    }

    property int colorType: IconButton.ColorType.Filled
    property color containerColor: colorType === IconButton.ColorType.Filled ? Color.scheme.primary : colorType === IconButton.ColorType.Tonal ? Color.scheme.secondaryContainer : "transparent"
    property color containerColorToggleUnselected: colorType === IconButton.ColorType.Filled ? Color.scheme.surfaceContainer : colorType === IconButton.ColorType.Tonal ? Color.scheme.secondaryContainer : "transparent"
    property color containerColorToggleSelected: colorType === IconButton.ColorType.Filled ? Color.scheme.primary : colorType === IconButton.ColorType.Tonal ? Color.scheme.secondary : colorType === IconButton.ColorType.Outlined ? Color.scheme.inverseSurface : "transparent"
    property color iconColor: colorType === IconButton.ColorType.Filled ? Color.scheme._onPrimary : colorType === IconButton.ColorType.Tonal ? Color.scheme._onSecondaryContainer : Color.scheme._onSurfaceVariant
    property color iconColorToggleUnselected: colorType === IconButton.ColorType.Filled ? Color.scheme._onSurfaceVariant : colorType === IconButton.ColorType.Tonal ? Color.scheme._onSecondaryContainer : Color.scheme._onSurfaceVariant
    property color iconColorToggleSelected: colorType === IconButton.ColorType.Filled ? Color.scheme._onPrimary : colorType === IconButton.ColorType.Tonal ? Color.scheme._onSecondary : colorType === IconButton.ColorType.Outlined ? Color.scheme.inverseOnSurface : colorType === IconButton.ColorType.Standard ? Color.scheme._onSurfaceVariant : null
    property color outlineColor: colorType === IconButton.ColorType.Outlined ? Color.scheme.outlineVariant : "transparent"
    property color outlineColorToggleUnselected: colorType === IconButton.ColorType.Outlined ? Color.scheme.outlineVariant : "transparent"
    property color outlineColorToggleSelected: "transparent"

    property int widthType: IconButton.WidthType.Default
    property real leadingTrailingSpace: {
        switch (widthType) {
        case IconButton.WidthType.Narrow:
            switch (sizeType) {
            case IconButton.SizeType.Xsmall:
            case IconButton.SizeType.Small:
                return 4;
            case IconButton.SizeType.Medium:
                return 12;
            case IconButton.SizeType.Large:
                return 16;
            case IconButton.SizeType.Xlarge:
                return 32;
            }
        case IconButton.WidthType.Default:
            switch (sizeType) {
            case IconButton.SizeType.Xsmall:
                return 6;
            case IconButton.SizeType.Small:
                return 8;
            case IconButton.SizeType.Medium:
                return 16;
            case IconButton.SizeType.Large:
                return 32;
            case IconButton.SizeType.Xlarge:
                return 48;
            }
        case IconButton.WidthType.Wide:
            switch (sizeType) {
            case IconButton.SizeType.Xsmall:
                return 10;
            case IconButton.SizeType.Small:
                return 14;
            case IconButton.SizeType.Medium:
                return 24;
            case IconButton.SizeType.Large:
                return 48;
            case IconButton.SizeType.Xlarge:
                return 72;
            }
        }
    }

    required property string icon

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

    border.color: (checkable && checked) ? outlineColorToggleSelected : (checkable && !checked) ? outlineColorToggleUnselected : enabled ? outlineColor : colorType === IconButton.ColorType.Outlined ? Color.scheme.outlineVariant : "transparent"
    border.width: outlineWidth
    color: (checkable && checked) ? containerColorToggleSelected : (checkable && !checked) ? containerColorToggleUnselected : enabled ? containerColor : colorType === IconButton.ColorType.Outlined ? "transparent" : Qt.alpha(Color.scheme._onSurface, 0.1)
    implicitHeight: containerHeight
    implicitWidth: iconSize + (leadingTrailingSpace * 2)
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

    M3Icon {
        id: icon

        anchors.centerIn: parent
        color: (root.checkable && root.checked) ? root.iconColorToggleSelected : (root.checkable && !root.checked) ? root.iconColorToggleUnselected : root.enabled ? root.iconColor : Qt.alpha(Color.scheme._onSurface, 0.38)
        filled: (root.checkable && root.checked) ? true : mouseArea.containsMouse ? true : false
        icon: root.icon
        pixelSize: root.iconSize

        Behavior on color {
            ExpressiveFastColor {}
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
            color: (root.checkable && root.checked) ? root.iconColorToggleSelected : (root.checkable && !root.checked) ? root.iconColorToggleUnselected : root.enabled ? root.iconColor : Qt.alpha(Color.scheme._onSurface, 0.38)
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
