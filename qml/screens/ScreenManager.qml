import QtQuick 2.0

Item {
    id: screenManager
    anchors.fill: parent

    property var currentScreen
    property var nextScreen

    function initWithScreen(screen){
        screenManager.currentScreen = screen;
        screen.opacity = 1;
        screen.visible = true;
    }
    function switchTo(screen){
        console.log("Switching to screen", screen)
        nextScreen = screen;
        switchScreens.start();
    }

    SequentialAnimation {
        id: switchScreens

        property var hidingScreen
        property var showingScreen

        ScriptAction {
            script: screenManager.nextScreen.visible = true;
        }

        NumberAnimation {
            id: hideAnim
            target: screenManager.currentScreen ? screenManager.currentScreen : null
            property: "opacity"
            duration: 200
            from: 1
            to: 0
            easing.type: Easing.InOutQuad
        }

        NumberAnimation {
            id: showAnim
            target: screenManager.nextScreen ? screenManager.nextScreen : null
            property: "opacity"
            duration: 200
            from: 0
            to: 1
            easing.type: Easing.InOutQuad
        }

        ScriptAction {
            script: {
                screenManager.currentScreen.visible = false;
                screenManager.currentScreen = nextScreen;
                screenManager.nextScreen = null;
            }
        }



    }
}
