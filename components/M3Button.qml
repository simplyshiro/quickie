import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import qs.styles
import qs.styles.motion

Button {
    id: root

    readonly property QtObject colors: QtObject {
        // TODO shadow
        readonly property var elevated: {
            "outlineColor": "transparent",
            "containerColor": Color.scheme.surfaceContainerLow,
            "containerColorToggleUnselected": Color.scheme.surfaceContainerLow,
            "containerColorToggleSelected": Color.scheme.primary,
            "labelIconColor": Color.scheme.primary,
            "labelIconColorToggleUnselected": Color.scheme.primary,
            "labelIconColorToggleSelected": Color.scheme._onPrimary,
        }

        readonly property var filled: {
            "outlineColor": "transparent",
            "containerColor": Color.scheme.primary,
            "containerColorToggleUnselected": Color.scheme.surfaceContainer,
            "containerColorToggleSelected": Color.scheme.primary,
            "labelIconColor": Color.scheme._onPrimary,
            "labelIconColorToggleUnselected": Color.scheme._onSurfaceVariant,
            "labelIconColorToggleSelected": Color.scheme._onPrimary,
        }

        readonly property var tonal: {
            "outlineColor": "transparent",
            "containerColor": Color.scheme.secondaryContainer,
            "containerColorToggleUnselected": Color.scheme.secondaryContainer,
            "containerColorToggleSelected": Color.scheme.secondary,
            "labelIconColor": Color.scheme._onSecondaryContainer,
            "labelIconColorToggleUnselected": Color.scheme._onSecondaryContainer,
            "labelIconColorToggleSelected": Color.scheme._onSecondary,
        }

        readonly property var outlined: {
            "outlineColor": Color.scheme.outlineVariant,
            "containerColor": "transparent",
            "containerColorToggleUnselected": "transparent",
            "containerColorToggleSelected": Color.scheme.inverseSurface,
            "labelIconColor": Color.scheme._onSurfaceVariant,
            "labelIconColorToggleUnselected": Color.scheme._onSurfaceVariant,
            "labelIconColorToggleSelected": Color.scheme.inverseOnSurface,
        }

        readonly property var text: {
            "outlineColor": "transparent",
            "containerColor": "transparent",
            "containerColorToggleUnselected": "transparent",
            "containerColorToggleSelected": "transparent",
            "labelIconColor": Color.scheme.primary,
            "labelIconColorToggleUnselected": Color.scheme.primary,
            "labelIconColorToggleSelected": Color.scheme.primary,
        }
    }

    readonly property QtObject sizes: QtObject {
        readonly property var xsmall: {
            "containerHeight": 32,
            "outlineWidth": 1,
            "iconSize": 20,
            "leadingTrailingSpace": 12,
            "betweenIconLabelSpace": 8,
            "shapePressedMorph": 8,
            "selectedContainerShapeRound": 12,
        }

        readonly property var small: {
            "containerHeight": 40,
            "outlineWidth": 1,
            "iconSize": 20,
            "leadingTrailingSpace": 16,
            "betweenIconLabelSpace": 8,
            "shapePressedMorph": 8,
            "selectedContainerShapeRound": 12,
        }

        readonly property var medium: {
            "containerHeight": 56,
            "outlineWidth": 1,
            "iconSize": 24,
            "leadingTrailingSpace": 24,
            "betweenIconLabelSpace": 8,
            "shapePressedMorph": 12,
            "selectedContainerShapeRound": 16,
        }

        readonly property var large: {
            "containerHeight": 96,
            "outlineWidth": 2,
            "iconSize": 32,
            "leadingTrailingSpace": 48,
            "betweenIconLabelSpace": 12,
            "shapePressedMorph": 16,
            "selectedContainerShapeRound": 28,
        }

        readonly property var xlarge: {
            "containerHeight": 136,
            "outlineWidth": 3,
            "iconSize": 40,
            "leadingTrailingSpace": 64,
            "betweenIconLabelSpace": 16,
            "shapePressedMorph": 16,
            "selectedContainerShapeRound": 28,
        }
    }

    property var _color: colors.filled
    property var size: sizes.small

    property string _icon

    background: Rectangle {
        border.color: root._color.outlineColor
        border.width: root.size.outlineWidth
        color: (root.checkable && root.checked) ? root._color.containerColorToggleSelected : (root.checkable && !root.checked) ? root._color.containerColorToggleUnselected : (root.enabled) ? root._color.containerColor : Qt.alpha(Color.scheme._onSurface, 0.1)
        implicitHeight: root.size.containerHeight
        implicitWidth: layout.width + (root.size.leadingTrailingSpace * 2)
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

    contentItem: Item {} // HACK anchors.centerIn doesn't work with contentItem

    RowLayout {
        id: layout
        anchors.centerIn: root.background
        spacing: 8

        M3Icon {
            color: (root.checkable && root.checked) ? root._color.labelIconColorToggleSelected : (root.checkable && !root.checked) ? root._color.labelIconColorToggleUnselected : (root.enabled) ? root._color.labelIconColor : Qt.alpha(Color.scheme._onSurface, 0.38)
            filled: (root.checkable && root.checked) ? true : (root.enabled) ? root.hovered : false
            icon: root._icon
            pixelSize: root.size.iconSize
            visible: root._icon
        }

        M3Text {
            color: (root.checkable && root.checked) ? root._color.labelIconColorToggleSelected : (root.checkable && !root.checked) ? root._color.labelIconColorToggleUnselected : (root.enabled) ? root._color.labelIconColor : Qt.alpha(Color.scheme._onSurface, 0.38)
            text: root.text
            typescale: root.size == root.sizes.xlarge ? typescales.headlineLarge : root.size == root.sizes.large ? typescales.headlineSmall : root.size == root.sizes.medium ? typescales.titleMedium : typescales.labelLarge
        }
    }

    Rectangle {
        anchors.fill: root.background
        color: (root.checkable && root.checked) ? root._color.labelIconColorToggleSelected : root._color.labelIconColor
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
