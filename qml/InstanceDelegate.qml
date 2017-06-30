import QtQuick 2.0

Rectangle {
    id: instanceDelegate
    property var model
    property string textColor: "#EEC"

   color: {
       if(model.status === "passing"){
           return index % 2 ? "#1580C8" : "#0570B8"
       }else if(model.status === "warning"){
           return index % 2 ? "#6b6d00" : "#7b7d00"
       }else if(model.status === "critical"){
           return index % 2 ? "#7d0000" : "#6d0000"
       }
       return "gray";
   }

   Rectangle {
        id: clickOverlay
        anchors.centerIn: parent
        height: parent.height
        width: parent.width
        color: Qt.rgba(1, 1, 1, 0.2);
        opacity: clickArea.pressed ? 1 : 0
        Behavior on opacity {
            NumberAnimation { duration: 350 }
        }
   }

   Item {
       id: basicInfoTextContainer
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
           color: instanceDelegate.textColor
       }

       Text {
           id: containerIdAndStatusText
           text: "%1 - (%2)".arg(model.id).arg(model.status)
           font.pixelSize: parent.height * 0.2
           anchors {
               left: parent.left
               top: nameText.bottom
               topMargin: parent.height * 0.1
           }
           color: instanceDelegate.textColor
       }
   }

   Item {
       id: tagsTextContainer
       anchors {
           right: parent.right
           rightMargin: parent.width * 0.05
       }
       height: parent.height


       Text {
           id: envText
           text: model.env
           font.pixelSize: parent.height * 0.25
           anchors{
               right: parent.right
               bottom: parent.verticalCenter
           }
           color: instanceDelegate.textColor
       }
       Text {
           id: appIdText
           text: model.appId
           font.pixelSize: parent.height * 0.25
           anchors{
               right: parent.right
               top: parent.verticalCenter
           }
           color: instanceDelegate.textColor
       }
   }


   MouseArea {
       id: clickArea
       anchors.fill: parent
   }


}
