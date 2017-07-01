import QtQuick 2.0

PopupItem {
    id: errorPopup
    property string error
    onErrorChanged: error ? open() : close()
    onClosed: error = ""

    contentItem: Item {
        Text {
            id: headerText
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
            anchors {
                horizontalCenter: parent.horizontalCenter
                top: headerText.bottom
                topMargin: parent.height * 0.1
            }

            width: parent.width * 0.9
            wrapMode: Text.Wrap
            font.pixelSize: parent.height * 0.075
            horizontalAlignment: Text.AlignHCenter
            text: errorPopup.error
            color: "white"
        }

        Image {
            source: "../../assets/error_icon.png"
            anchors {
                bottom: parent.bottom
                bottomMargin: parent.height * 0.025
                horizontalCenter: parent.horizontalCenter
            }
            opacity: 0.8
        }
    }
}
