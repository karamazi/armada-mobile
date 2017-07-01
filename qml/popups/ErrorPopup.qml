import QtQuick 2.0

PopupItem {
    id: errorPopup
    property string error
    onErrorChanged: error ? open() : close()
    onClosed: error = ""

    contentItem: Item {
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
            text: errorPopup.error
            color: "white"
        }
    }
}
