import QtQuick 2.0
import QtQuick.Controls 2.0
import "screens"
import "popups"

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

    ErrorPopup {
        id: errorPopup
    }
}
