import QtQuick 2.0
import "screens"
import QtGraphicalEffects 1.0

ScreenItem {
    id: clusterSelection
    property var clusterLogic

    Text {
        id: headerText

        anchors{
            top: parent.top
            topMargin: parent.height * 0.025
            horizontalCenter: parent.horizontalCenter
        }

        font.pixelSize: parent.height * 0.05
        text: "Select a cluster"
        color: "white"
    }

    Column {
        id: clustersList
        anchors {
            top: headerText.bottom
            topMargin: parent.height * 0.05
            bottom: parent.bottom
            horizontalCenter: parent.horizontalCenter
        }
        width: parent.width * 0.75
        spacing: parent.height * 0.025

        Repeater {
            model: clusterSelection.clusterLogic.models
            delegate: Rectangle {
                property var clusterModel: modelData

                width: clustersList.width
                height: clustersList.height * 0.1
                color: clickArea.pressed ? "#1594D8" : "#0570B8"
                border.width: height * 0.05
                border.color: "#09A4F8"
                radius: height * 0.25


                Behavior on color {
                    ColorAnimation {
                        duration: 200
                    }
                }

                Text {
                    anchors.centerIn: parent
                    text: clusterModel.name
                    font.pixelSize: parent.height * 0.5
                    font.weight: Font.Bold
                    color: "white"
                }

                MouseArea {
                    id: clickArea
                    anchors.fill: parent
                    onClicked: clusterModel.qmlConnectToCluster(clusterModel.address)
                }
            }
        }
    }

    Image {
        id: loadingSpinner
        source: "../assets/loading_icon.png"
        anchors.centerIn: parent
        visible: clusterSelection.clusterLogic.requestPending;
        RotationAnimation {
            running: loadingSpinner.visible
            target: loadingSpinner
            from: 0
            to: 360
            duration: 300
            loops: Animation.Infinite
        }
    }

    Image {
        id: armadaLogo
        source: "../assets/armada.png"
        width: parent.width * 0.9
        height: width * 0.25
        anchors.bottom: parent.bottom
        anchors.bottomMargin: parent.height * 0.025
        anchors.horizontalCenter: parent.horizontalCenter
    }

    RadialGradient {
        anchors.fill: armadaLogo
        source: armadaLogo
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#BBB" }
            GradientStop { position: 1.0; color: "#0570B8" }
        }

    }


}
