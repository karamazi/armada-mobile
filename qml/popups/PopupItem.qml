import QtQuick 2.0

Rectangle {
    id: popupItem
    width: parent.width
    height: parent.height
    color: "transparent"
    visible: false

    signal opened
    signal closed

    property alias contentItem: contentLoader.sourceComponent
    property bool closeOnClick: true

    function open(){
        popupItem.opened()
        openAnimation.start();
    }
    function close(){
        closeAnimation.start();
        popupItem.closed()
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            if(closeOnClick)
                popupItem.close()
        }
    }

    Rectangle {
        id: popupContentRect
        anchors.centerIn: parent
        width: parent.width * 0.8
        height: parent.height * 0.4
        radius: width * 0.1
        scale: 0

        color: "#0570B8"
        border.color: "#09A4F8"
        border.width: 2

        Loader {
            id: contentLoader
            anchors.fill: parent
        }
    }



    SequentialAnimation {
        id: openAnimation
        ScriptAction { script: popupItem.visible = true }
        ColorAnimation {
            target: popupItem
            property: "color"
            to: Qt.rgba(0, 0, 0, 0.5)
            duration: 200
        }
        NumberAnimation {
            target: popupContentRect
            property: "scale"
            to: 1
            duration: 200
            easing.type: Easing.InOutQuad
            easing.overshoot: 1
        }
    }

    SequentialAnimation {
        id: closeAnimation
        NumberAnimation {
            target: popupContentRect
            property: "scale"
            to: 0
            duration: 200
            easing.type: Easing.InOutQuad
            easing.overshoot: 1
        }
        ColorAnimation {
            target: popupItem
            property: "color"
            to: "transparent"
            duration: 200
        }
        ScriptAction { script: popupItem.visible = false }
    }
}
