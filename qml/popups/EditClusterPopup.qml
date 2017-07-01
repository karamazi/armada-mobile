import QtQuick 2.0
import QtQuick.Controls 2.1

import "../common"

PopupItem {
    id: editClusterPopup
    property var clusterLogic
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
            text: "Edit cluster"
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
                width: parent.width
                validator: RegExpValidator { regExp: /^.{3,}$/ }
            }

            TextField {
                id: address
                placeholderText: "Address"
                text: "http://"
                validator: RegExpValidator { regExp: /^https?:\/\/.*/}
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

        ClickableRect {
            id: acceptButton
            width: parent.width * 0.4
            height: parent.height * 0.15

            Text {
                text: "Accept"
                color: "#AFA"
                font.pixelSize: parent.height * 0.6
                anchors.centerIn: parent
            }

            anchors {
                bottom: parent.bottom
                bottomMargin: parent.height * 0.075
                left: parent.left
                leftMargin: parent.width * 0.05
            }
            onClicked: {
                if(name.acceptableInput && address.acceptableInput){
                    console.log("OK")
                    wrongInputText.visible = false;
                    editClusterPopup.clusterLogic.qmlAddCluster(name.text, address.text)
                    editClusterPopup.close()
                }
                else {
                    wrongInputText.visible = true;
                    console.log("nope")
                }


            }

        }

        ClickableRect {
            id: closeButton
            width: parent.width * 0.4
            height: parent.height * 0.15

            Text {
                text: "Cancel"
                color: "#FAA"
                font.pixelSize: parent.height * 0.6
                anchors.centerIn: parent
            }

            anchors {
                bottom: parent.bottom
                bottomMargin: parent.height * 0.075
                right: parent.right
                rightMargin: parent.width * 0.05
            }
            onClicked: editClusterPopup.close()
        }
    }
}
