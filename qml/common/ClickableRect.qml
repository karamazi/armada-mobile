import QtQuick 2.0

Rectangle {
    id: clickableRect

    signal clicked;

    property color normalColor: "#0570B8"
    property color pressedColor: "#1594D8"
    property color borderColor: "#09A4F8"

    color: clickArea.pressed ? pressedColor : normalColor
    border.color: borderColor
    border.width: 3
    radius: height * 0.25
    opacity: enabled ? 1 : 0.3

    Behavior on color {
        ColorAnimation {
            duration: 200
        }
    }

    MouseArea {
        id: clickArea
        anchors.fill: parent
        onClicked: clickableRect.clicked()
    }
}
