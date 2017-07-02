import QtQuick 2.0
import QtGraphicalEffects 1.0

import "screens"
import "popups"
import "common"

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
        property real itemHeight: clusterSelection.height * 0.075
        property real itemWidth: clusterSelection.width * 0.75
        anchors {
            top: headerText.bottom
            topMargin: parent.height * 0.05
            horizontalCenter: parent.horizontalCenter
        }
        width: parent.width * 0.75
        spacing: parent.height * 0.025
        height: clusterSelection.clusterLogic.models.length * (itemHeight + spacing)

        Repeater {
            model: clusterSelection.clusterLogic.models
            delegate: Item {
                id: clusterItem
                property var clusterModel: modelData
                width: clustersList.itemWidth
                height: clustersList.itemHeight

                ClickableRect {
                    width: parent.width * 0.7
                    height: parent.height

                    Text {
                        anchors.centerIn: parent
                        text: clusterItem.clusterModel.name
                        font.pixelSize: parent.height * 0.5
                        font.weight: Font.Bold
                        color: "white"
                    }

                    onClicked: clusterModel.qmlConnectToCluster(clusterItem.clusterModel.address)
                }

                ClickableRect {
                    width: parent.width * 0.25
                    height: parent.height
                    anchors.right: parent.right

                    Text {
                        anchors.centerIn: parent
                        text: "Edit"
                        font.weight: Font.Black
                        color: "white"
                        font.pixelSize: parent.height * 0.4
                    }
                    onClicked: {
                        editClusterPopup.clusterModel = clusterItem.clusterModel
                        editClusterPopup.addingNew = false;
                        editClusterPopup.open()
                    }
                }
            }
        }
    }

    ClickableRect {
        id: addNewButton
        anchors {
            top: clustersList.bottom
            topMargin: parent.height * 0.05
            horizontalCenter: parent.horizontalCenter
        }
        width: parent.width * 0.5
        height: parent.height * 0.075
        borderColor: "#09D498"

        Text {
            anchors.centerIn: parent
            text: "+ New"
            font.pixelSize: parent.height * 0.5
            font.weight: Font.Bold
            color: "#AFA"
        }
        onClicked: {
            editClusterPopup.clusterModel = clusterSelection.clusterLogic.editModel;
            editClusterPopup.addingNew = true;
            editClusterPopup.open();
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

    EditClusterPopup {
        id: editClusterPopup
        clusterLogic: clusterSelection.clusterLogic
        clusterModel: clusterSelection.clusterLogic.editModel
    }
}
