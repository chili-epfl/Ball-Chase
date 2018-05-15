import QtQuick 2.0

Item {

    // TODO : FIND A SMOOTHIER WAY OF MOVEMENT

    property Rectangle body : playerBody
    property int size : 0

    focus: true

    Keys.onReleased: {


        if (event.key === Qt.Key_W && playerBody.y >= 25) {
            playerBody.y -= 25
            event.accepted = true;
        }
        if (event.key === Qt.Key_A && playerBody.x >= 25) {
            playerBody.x -= 25
            event.accepted = true;
        }  if (event.key === Qt.Key_D && playerBody.x <= window.width - playerBody.width -25) {
            playerBody.x += 25
            event.accepted = true;
        }  if (event.key === Qt.Key_S && playerBody.y <= window.height - playerBody.height -25) {
            console.log(playerBody.y)
            playerBody.y += 25
            event.accepted = true;
        }

    }

    Rectangle {

        id: playerBody

        color: "black"

        width: size
        height: size
        radius: 15



    }

}
