import QtQuick
import QtQuick.Controls

import qs.styles
import qs.styles.motion

Button {
    id: root

    readonly property QtObject colors: QtObject {
        readonly property var filled: {
            "outlineColor": "transparent",
            "containerColor": Color.scheme.primary,
            "containerColorToggleUnselected": Color.scheme.surfaceContainer,
            "containerColorToggleSelected": Color.scheme.primary,
            "iconColor": Color.scheme._onPrimary,
            "iconColorToggleUnselected": Color.scheme._onSurfaceVariant,
            "iconColorToggleSelected": Color.scheme._onPrimary,
        }

        readonly property var tonal: {
            "outlineColor": "transparent",
            "containerColor": Color.scheme.secondaryContainer,
            "containerColorToggleUnselected": Color.scheme.secondaryContainer,
            "containerColorToggleSelected": Color.scheme.secondary,
            "iconColor": Color.scheme._onSecondaryContainer,
            "iconColorToggleUnselected": Color.scheme._onSecondaryContainer,
            "iconColorToggleSelected": Color.scheme._onSecondary,
        }

        readonly property var outlined: {
            "outlineColor": Color.scheme.outlineVariant,
            "containerColor": "transparent",
            "containerColorToggleUnselected": "transparent",
            "containerColorToggleSelected": Color.scheme.inverseSurface,
            "iconColor": Color.scheme._onSurfaceVariant,
            "iconColorToggleUnselected": Color.scheme._onSurfaceVariant,
            "iconColorToggleSelected": Color.scheme.inverseOnSurface,
        }

        readonly property var standard: {
            "outlineColor": "transparent",
            "containerColor": "transparent",
            "containerColorToggleUnselected": "transparent",
            "containerColorToggleSelected": "transparent",
            "iconColor": Color.scheme._onSurfaceVariant,
            "iconColorToggleUnselected": Color.scheme._onSurfaceVariant,
            "iconColorToggleSelected": Color.scheme.primary,
        }
    }

    readonly property QtObject sizes: QtObject {
        readonly property var xsmall: {
            "containerHeight": 32,
            "iconSize": 20,
            "narrowLeadingTrailingSpace": 4,
            "defaultLeadingTrailingSpace": 6,
            "wideLeadingTrailingSpace": 10,
            "outlineWidth": 1,
            "shapePressedMorph": 8,
            "selectedContainerShapeRound": 12,
        }

        readonly property var small: {
            "containerHeight": 40,
            "iconSize": 24,
            "narrowLeadingTrailingSpace": 4,
            "defaultLeadingTrailingSpace": 8,
            "wideLeadingTrailingSpace": 14,
            "outlineWidth": 1,
            "shapePressedMorph": 8,
            "selectedContainerShapeRound": 12,
        }

        readonly property var medium: {
            "containerHeight": 56,
            "iconSize": 24,
            "narrowLeadingTrailingSpace": 12,
            "defaultLeadingTrailingSpace": 16,
            "wideLeadingTrailingSpace": 24,
            "outlineWidth": 1,
            "shapePressedMorph": 12,
            "selectedContainerShapeRound": 16,
        }

        readonly property var large: {
            "containerHeight": 96,
            "iconSize": 32,
            "narrowLeadingTrailingSpace": 16,
            "defaultLeadingTrailingSpace": 32,
            "wideLeadingTrailingSpace": 48,
            "outlineWidth": 2,
            "shapePressedMorph": 16,
            "selectedContainerShapeRound": 28,
        }

        readonly property var xlarge: {
            "containerHeight": 136,
            "iconSize": 40,
            "narrowLeadingTrailingSpace": 32,
            "defaultLeadingTrailingSpace": 48,
            "wideLeadingTrailingSpace": 72,
            "outlineWidth": 3,
            "shapePressedMorph": 16,
            "selectedContainerShapeRound": 28,
        }
    }

    property var _color: colors.filled
    property var size: sizes.small
    property var leadingTrailingSpace: size.defaultLeadingTrailingSpace

    property int iconSize: 24

    background: Rectangle {
        border.color: root._color.outlineColor
        color: (root.checkable && root.checked) ? root._color.containerColorToggleSelected : (root.checkable && !root.checked) ? root._color.containerColorToggleUnselected : (root.enabled) ? root._color.containerColor : Qt.alpha(Color.scheme._onSurface, 0.1)
        implicitHeight: root.size.containerHeight
        implicitWidth: icon.width + (root.leadingTrailingSpace * 2)
        radius: root.checked ? root.size.selectedContainerShapeRound : root.pressed ? root.size.shapePressedMorph : root.size.containerHeight

        Behavior on border.color {
            ExpressiveFastColor {}
        }

        Behavior on color {
            ExpressiveFastColor {}
        }

        Behavior on implicitWidth {
            ExpressiveFastSpatial {}
        }

        Behavior on radius {
            ExpressiveFastSpatial {}
        }
    }

    contentItem: Item {} // anchors.centerIn doesn't work with contentItem

    M3Icon {
        id: icon
        anchors.centerIn: root.background
        color: (root.checkable && root.checked) ? root._color.iconColorToggleSelected : (root.checkable && !root.checked) ? root._color.iconColorToggleUnselected : (root.enabled) ? root._color.iconColor : Qt.alpha(Color.scheme._onSurface, 0.38)
        filled: (root.checkable && root.checked) ? true : (root.enabled) ? root.hovered : false
        icon: root.text
        pixelSize: root.size.iconSize
    }

    Rectangle {
        anchors.fill: root.background
        color: (root.checkable && root.checked) ? root._color.iconColorToggleSelected : root._color.iconColor
        opacity: root.pressed ? 0.1 : root.hovered ? 0.08 : 0
        radius: root.background.radius
        visible: root.enabled

        Behavior on color {
            ExpressiveFastColor {}
        }

        Behavior on opacity {
            ExpressiveFastEffects {}
        }
    }

    HoverHandler {
        cursorShape: root.enabled ? Qt.PointingHandCursor : undefined
    }
}
