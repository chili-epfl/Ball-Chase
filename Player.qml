import QtQuick 2.0

Item {

    // NON USED FILE - TODO : FINISH MOVEMENT SYSTEM AND ADD COLLISION

    property Rectangle body : playerBody

    focus: true

    Keys.onReleased: {

        if (event.key === Qt.Key_W) {
            playerBody.y -= 17
            event.accepted = true;
        }
        if (event.key === Qt.Key_A) {
            playerBody.x -= 17
            event.accepted = true;
        }  if (event.key === Qt.Key_D) {
            playerBody.x += 17
            event.accepted = true;
        }  if (event.key === Qt.Key_S) {
            playerBody.y += 17
            event.accepted = true;
        }
    }

    Rectangle {

        property int size : 0

        id: playerBody

        color: "black"

        width: size
        height: size


        x: window.width / 2 - width / 2
        y: window.height / 2 - height / 2
    }

}
