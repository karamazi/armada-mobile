import QtQuick 2.0
import QtQuick.Controls 2.0
import "screens"

Item {
    id: mainScreen
    property QtObject rootLogic: _root_logic

    Rectangle {
        id: background
        anchors.fill: parent
        color: "#0570B8"
    }

    ScreenManager {
        id: screenManager

        ClusterSelectionScreen {
            id: clusterSelectionScreen
            clusterLogic: mainScreen.rootLogic.clusterLogic

            Connections {
                target: mainScreen.rootLogic.clusterLogic
                onQmlInstancesLoaded: screenManager.switchTo(clusterInstancesScreen)
                onQmlError: errorPopup.error = error;
            }
        }

        ClusterInstancesScreen {
            id: clusterInstancesScreen
            instancesLogic: mainScreen.rootLogic.clusterLogic
            onBackPressed: screenManager.switchTo(clusterSelectionScreen)
        }

        Component.onCompleted: initWithScreen(clusterSelectionScreen);
    }
    Rectangle {
        id: errorPopup
        property alias error: errorText.text
        width: parent.width
        height: parent.height
        color: "transparent"
        visible: false
        onErrorChanged: error ? openAnimation.start() : closeAnimation.start()

        Rectangle {
            id: errorContent
            anchors.centerIn: parent
            width: parent.width * 0.8
            height: parent.height * 0.4
            radius: width * 0.1
            scale: 0

            color: "#0570B8"
            border.color: "#09A4F8"
            border.width: 2

            Text {
                anchors {
                    top: parent.top
                    topMargin: parent.height * 0.05
                    horizontalCenter: parent.horizontalCenter
                }
                text: "Error occured :("
                font.pixelSize: parent.height * 0.1
                color: "white"
            }

            Text {
                id: errorText
                anchors.centerIn: parent
                width: parent.width * 0.9
                wrapMode: Text.Wrap
                font.pixelSize: parent.height * 0.075
                horizontalAlignment: Text.AlignHCenter
                text: "Unable to connect"
                color: "white"
            }
        }

        MouseArea {
            anchors.fill: parent
            onClicked: errorPopup.error = "";
        }

        SequentialAnimation {
            id: openAnimation
            ScriptAction { script: errorPopup.visible = true }
            ColorAnimation {
                target: errorPopup
                property: "color"
                to: Qt.rgba(0, 0, 0, 0.5)
                duration: 200
            }
            NumberAnimation {
                target: errorContent
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
                target: errorContent
                property: "scale"
                to: 0
                duration: 200
                easing.type: Easing.InOutQuad
                easing.overshoot: 1
            }
            ColorAnimation {
                target: errorPopup
                property: "color"
                to: "transparent"
                duration: 200
            }
            ScriptAction { script: errorPopup.visible = false }
        }
    }
}
