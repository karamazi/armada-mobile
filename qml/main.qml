import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0

ApplicationWindow {
    visible: true
    width: 540
    height: 860
    title: qsTr("Armada Mobile")

    MainScreen {
        id: mainScreen
        anchors.fill: parent
    }
}
