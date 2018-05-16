import QtQuick 2.0

Item {

    // TODO : FIND A SMOOTHIER WAY OF MOVEMENT

    property Rectangle body : playerBody
    property int size : 0
    property double angle : 90
    property double speed : 0.25

    Timer {

        interval: 1
        running: true
        repeat: true

        onTriggered: {

            var x = Math.cos(Math.PI/180*angle)
            var y = -Math.sin(Math.PI/180*angle)

            if(x < 0 && body.x >= 0.1)
                body.x += speed * x

            if(x > 0 && body.x <= window.width-body.height)
                body.x += speed * x

            if(y < 0 && body.y >= 0.1)
                body.y += speed * y

            if(y > 0 && body.y <= window.width-body.height)
                body.y += speed * y


        }
    }

    focus: true

    Keys.onReleased: {


        if (event.key === Qt.Key_W) {

            speed += 0.05
            event.accepted = true;
        }

        if (event.key === Qt.Key_A) {

            angle += 30
            event.accepted = true;

        }

        if (event.key === Qt.Key_D) {

            angle -= 30
            event.accepted = true;
        }

        if (event.key === Qt.Key_S) {

            speed -= 0.05
            event.accepted = true;
        }

        if(event.key === Qt.Key_Space) {

            body.x = window.width / 2 - player.body.width / 2
            body.y = window.height / 2 - player.body.height / 2
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
