import QtQuick 2.0
import QtQuick.Controls 2.1

import "../common"

PopupItem {
    id: editClusterPopup
    property var clusterLogic
    property var clusterModel
    property bool addingNew: true

    closeOnClick: false

    contentItem: Item {
        Text {
            id: headerText
            anchors {
                horizontalCenter: parent.horizontalCenter
                top: parent.top
                topMargin: parent.height * 0.05
            }
            font.pixelSize: parent.height * 0.05
            color: "white"
            text: editClusterPopup.addingNew ? "Add cluster" : "Edit cluster"
        }

        Column {
            id: inputs
            anchors {
                top: headerText.bottom
                topMargin: parent.height * 0.05
                horizontalCenter: parent.horizontalCenter
            }
            width: parent.width * 0.9
            spacing: 5

            TextField {
                id: name
                placeholderText: "Name"
                text: clusterModel ? clusterModel.name : ""
                width: parent.width
                validator: RegExpValidator { regExp: /^.{3,}$/ }
            }

            TextField {
                id: address
                placeholderText: "Address"
                text: clusterModel ? clusterModel.address : ""
                validator: RegExpValidator { regExp: /^https?:\/\/.{3,}/}
                width: parent.width
            }
        }

        Text {
            id: wrongInputText
            anchors {
                top: inputs.bottom
                horizontalCenter: inputs.horizontalCenter
            }
            color: "#ff7070"
            text: "Wrong input! Addres has to start with http:// or https://. Name has to have 3 chars or more"
            font.pixelSize: parent.height * 0.05
            width: parent.width * 0.9
            wrapMode: Text.Wrap
            visible: false
        }

        Row {
            width: parent.width * 0.9
            height: parent.height * 0.15
            anchors {
                bottom: parent.bottom
                bottomMargin: parent.height * 0.075
                horizontalCenter: parent.horizontalCenter
            }
            spacing: width * 0.05

            ClickableRect {
                id: deleteButton
                width: parent.width * 0.3
                height: parent.height
                borderColor: "#F00"
                normalColor: "#EE3333"
                pressedColor: "#FF4444"
                enabled: !editClusterPopup.addingNew

                Text {
                    text: "Delete"
                    color: "white"
                    font.pixelSize: parent.height * 0.6
                    anchors.centerIn: parent
                }

                onClicked: {
                    clusterModel.qmlDelete();
                    editClusterPopup.close()
                }
            }

            ClickableRect {
                id: closeButton
                width: parent.width * 0.3
                height: parent.height
                borderColor: "#FAA"

                Text {
                    text: "Cancel"
                    color: closeButton.borderColor
                    font.pixelSize: parent.height * 0.6
                    anchors.centerIn: parent
                }

                onClicked: editClusterPopup.close()
            }

            ClickableRect {
                id: acceptButton
                width: parent.width * 0.3
                height: parent.height
                borderColor: "#AFA"

                Text {
                    text: "Accept"
                    color: acceptButton.borderColor
                    font.pixelSize: parent.height * 0.6
                    anchors.centerIn: parent
                }

                onClicked: {
                    if(name.acceptableInput && address.acceptableInput){
                        console.log("OK")
                        wrongInputText.visible = false;
                        if(editClusterPopup.addingNew){
                            editClusterPopup.clusterLogic.qmlAddCluster(name.text, address.text)
                        }else {
                            editClusterPopup.clusterModel.name = name.text
                            editClusterPopup.clusterModel.address = address.text
                            editClusterPopup.clusterModel.qmlSave();
                        }

                        editClusterPopup.close()
                    }
                    else {
                        wrongInputText.visible = true;
                        console.log("nope")
                    }
                }
            }
        }
    }
}
