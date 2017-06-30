import QtQuick 2.0
import QtGraphicalEffects 1.0

Item {
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
                GradientStop { position: 0.0; color: "white" }
                GradientStop { position: 0.9; color: "white" }
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

        model: instancesLogic.instances
        delegate: Rectangle {
            property var model: modelData
            Rectangle {
                width: parent.width
                height: 1
                color: "black"
            }

            width: instancesScreen.width
            height: instancesScreen.height * 0.075
            color: {
                if(model.status === "passing"){
                    return "lightgreen"
                }else if(model.status === "warning"){
                    return "khaki"
                }else if(model.status === "critical"){
                    return "red"
                }
                return "gray";
            }
            Item {
                id: textContainer
                width: parent.width * 0.95
                height: parent.height
                anchors.horizontalCenter: parent.horizontalCenter

                Text {
                    id: nameText
                    text: model.name
                    font.pixelSize: parent.height * 0.4
                    anchors {
                        left: parent.left
                        bottom: parent.verticalCenter
                    }
                }

                Text {
                    text: model.id
                    font.pixelSize: parent.height * 0.2
                    anchors {
                        left: parent.left
                        top: nameText.bottom
                    }
                }
            }

        }
    }
}
