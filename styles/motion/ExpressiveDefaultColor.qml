import QtQuick

ColorAnimation {
    duration: 200
    easing.bezierCurve: [0.34, 0.8, 0.34, 1]
    easing.type: Easing.BezierSpline
}
