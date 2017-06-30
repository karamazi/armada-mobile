import QtQuick 2.0
import QtQuick.Controls 2.0

Item {
    id: mainScreen
    property QtObject rootLogic: _root_logic

    ClusterSelectionScreen {
        id: clusterSelectionScreen
        anchors.fill: parent
        clusterLogic: mainScreen.rootLogic.clusterLogic
    }

    ClusterInstancesScreen {
        id: clusterInstancesScreen
        anchors.fill: parent
        opacity: 0
        visible: false
        instancesLogic: mainScreen.rootLogic.clusterLogic
        onBackPressed: switchScreens.fromTo(clusterInstancesScreen, clusterSelectionScreen)
    }


    Connections {
        target: mainScreen.rootLogic.clusterLogic
        onQmlInstancesLoaded: switchScreens.fromTo(clusterSelectionScreen, clusterInstancesScreen)
    }


    SequentialAnimation {
        id: switchScreens
        property var hidingScreen
        property var showingScreen

        ScriptAction {
            script: switchScreens.showingScreen.visible = true;
        }

        NumberAnimation {
            id: hideAnim
            target: switchScreens.hidingScreen ? switchScreens.hidingScreen : null
            property: "opacity"
            duration: 200
            from: 1
            to: 0
            easing.type: Easing.InOutQuad
        }

        NumberAnimation {
            id: showAnim
            target: switchScreens.showingScreen ? switchScreens.showingScreen : null
            property: "opacity"
            duration: 200
            from: 0
            to: 1
            easing.type: Easing.InOutQuad
        }

        ScriptAction {
            script: {
                switchScreens.hidingScreen.visible = false;
            }
        }

        function fromTo(screen1, screen2){
            hidingScreen = screen1;
            showingScreen = screen2;
            start();
        }

    }

}
