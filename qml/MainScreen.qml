import QtQuick 2.0
import QtQuick.Controls 2.0
import "screens"

Item {
    id: mainScreen
    property QtObject rootLogic: _root_logic

    Rectangle {
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
            }
        }

        ClusterInstancesScreen {
            id: clusterInstancesScreen
            instancesLogic: mainScreen.rootLogic.clusterLogic
            onBackPressed: screenManager.switchTo(clusterSelectionScreen)
        }

        Component.onCompleted: initWithScreen(clusterSelectionScreen);

    }









}
