
import QtQuick 2.0

Item {

    property int size
    property string colour
    property Rectangle current : currentBall
    property double coeff : 1
    property double xCoords : 0
    property double yCoords : 0
    property int repeatTime : 1
    property int rad : 0
    property int rot : 0
    property Timer ballMovement : ballMovement

    Rectangle {

        id: currentBall
        radius: 100
        width: size
        height: size
        color : colour
        visible: false
        rotation: 0

        x: window.width / 2 - width / 2
        y: window.height / 2 - height / 2
    }

    function launch() {

        var angle = Math.random(10) * 360
        xCoords = Math.cos(Math.PI*angle/180)
        yCoords = -Math.sin(Math.PI*angle/180)

        ballMovement.x = xCoords;
        ballMovement.y = yCoords;
        ballMovement.lastAngle = angle
        ballMovement.running = true
        ballMovement.repeat = true

    }

    Timer {


        property double x : 0
        property double y : 0
        property double lastAngle : 0

        id: ballMovement
        interval: repeatTime

        onTriggered: {

            coeff += 0.00003

            currentBall.x += x * coeff
            currentBall.y += y * coeff
            currentBall.rotation += 0.1

            var xCenter = window.width / 2


            if(currentBall.x <= 0){

                var newAngle1 = wall.findFromLeft(lastAngle)

                x = Math.cos(Math.PI/180*newAngle1)
                y = -Math.sin(Math.PI/180*newAngle1)

                if(newAngle1 !== lastAngle)
                    console.log("New angle defined : "+lastAngle)

                lastAngle = newAngle1


            }

            else if(currentBall.y <= 0) {

                var newAngle2 =  wall.findFromTop(lastAngle)

                x = Math.cos(Math.PI/180*newAngle2)
                y = -Math.sin(Math.PI/180*newAngle2)

                if(newAngle2 !== lastAngle)
                    console.log("New angle defined : "+lastAngle)

                lastAngle = newAngle2

            }

            else if(currentBall.x >= window.width-currentBall.width) {

                var newAngle3 = wall.findFromRight(lastAngle)

                x = Math.cos(Math.PI/180*newAngle3)
                y = -Math.sin(Math.PI/180*newAngle3)

                if(newAngle3 !== lastAngle)
                    console.log("New angle defined : "+lastAngle)

                lastAngle = newAngle3



            }

            else if(currentBall.y >= window.height-currentBall.height) {

                var newAngle4 = wall.findFromBottom(lastAngle)

                x = Math.cos(Math.PI/180*newAngle4)
                y = -Math.sin(Math.PI/180*newAngle4)

                if(newAngle4 !== lastAngle)
                    console.log("New angle defined : "+lastAngle)

                lastAngle = newAngle4


            }

            if(coll.isCollisionBetween(player.body, currentBall)) {
                console.log("You are dead !")
                lifeAmount--



                player.body.x = window.width / 2 - player.body.width / 2
                player.body.y = window.height / 2 - player.body.height / 2


                for(var a = 0; a<game.repeater.model; a++)
                    game.repeater.itemAt(a).ballMovement.running = false

                if(lifeAmount == 0) {
                    chrono.visible = false
                    lifesRectangle.visible = false
                    endTitle.visible = true

                    for(var b = 0; b<game.repeater.model; b++)
                        game.repeater.itemAt(b).current.visible = false
                }

                else
                    restart.running = true



            }

        }
    }

    Timer {

        property int current: 4

        id: restart
        running: false
        repeat: true
        interval: 10

        onTriggered: {

            respawnTitle.visible = true
            restart.interval = 1000;

            if(current == 1) {


                current = 4
                running = false
                interval = 10

                for(var a = 0; a<game.repeater.model; a++)
                    game.repeater.itemAt(a).ballMovement.running = true

                respawnTitle.visible = false

                player.speed = 0.25
            }

            else     current--

        }
    }

    Rectangle {

        id: respawnTitle
        visible: false
        x: window.width / 2

        Text {
            id: name

            color: "green"
            anchors.horizontalCenter: respawnTitle.horizontalCenter
            font.bold: true
            y: window.height / 2 -50

            font.pointSize: 40

            text: qsTr("Respawn dans "+restart.current)
        }
    }

    Rectangle {

        id: endTitle
        visible: false
        width: window.width
        height: window.height
        color: "black"

        Text {

            id: endName
            visible: true

            anchors.horizontalCenter: endTitle.horizontalCenter
            font.bold: true
            y: window.height / 2 - height

            font.pointSize: 60

            color: "red"
            text: qsTr("Game Over !")

        }
    }

    WallDetector {

        id: wall
    }

    CollisionDetector {

        id: coll
    }


}
