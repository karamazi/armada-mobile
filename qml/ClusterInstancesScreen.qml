import QtQuick 2.0
import QtGraphicalEffects 1.0
import QtQuick.Controls 2.1
import "screens"

ScreenItem {
    id: instancesScreen
    property var instancesLogic

    signal backPressed;

    Item {
        id: headerRect
        width: parent.width
        height: parent.height * 0.075
        z: 1

        LinearGradient {
            anchors.fill: parent
            gradient: Gradient {
                GradientStop { position: 0.0; color: "#0570B8" }
                GradientStop { position: 0.9; color: "#0570B8" }
                GradientStop { position: 1.0; color: "transparent" }
            }
        }

        Text {
            width: parent.width * 0.25
            height: parent.height
            text: "←"
            font.pixelSize: parent.height * 0.85
            color: clickArea.pressed ? "gray" : "black"

            MouseArea {
                id: clickArea
                anchors.fill: parent
                onClicked: instancesScreen.backPressed();
            }
        }
    }

    ListView {
        anchors {
            top: headerRect.bottom
            bottom: parent.bottom
        }
        width: parent.width

        snapMode: ListView.SnapToItem
        boundsBehavior: ListView.StopAtBounds
        ScrollBar.vertical: ScrollBar {
            id: scrollBar
            policy: ScrollBar.AsNeeded
            background: Rectangle {
                color: "transparent"
            }
            contentItem: Rectangle {
                implicitWidth: 10
                implicitHeight: 25
                radius: width / 2
                color: scrollBar.pressed ? "gray" : "#eed"
                opacity: scrollBar.active ? 1 : 0
                Behavior on opacity {
                    NumberAnimation { duration : 250 }
                }
            }
        }

        model: instancesLogic.instances
        delegate: InstanceDelegate {
            model: modelData
            width: instancesScreen.width
            height: instancesScreen.height * 0.075
        }
    }
}
