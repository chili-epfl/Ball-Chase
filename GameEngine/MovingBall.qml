
import QtQuick 2.0

Item {

    property int size
    property string colour
    property Rectangle current : currentBall
    property double xCoords : 0
    property double yCoords : 0
    property int repeatTime : 1
    property int rad : 100
    property int rot : 0
    property Timer ballMovement : ballMovement
    property bool allowMovement : false
    signal change

    onChange: {

        if(coll.isCollisionBetween(player.body, currentBall) && !(game.gameTimer.minutes === 0 && game.gameTimer.seconds < 2) && !restart.running) {

            console.log("You are dead !")

            ballManage.stopMoves()

            game.lifeAmount--

            if(lifeAmount == 0) {

                game.gameTimer.running = false
                game.chrono.visible = false
                game.lifesRec.visible = false
                game.endTitle.visible = true
                player.body.visible = false

                ballManage.hideAll()

            }

            else
                restart.running = true
        }
    }

    Rectangle {

        id: currentBall
        radius: rad
        width: size
        height: size
        color : colour
        visible: false
        rotation: 0

        x: window.width / 2 - width / 2
        y: window.height / 2 - height / 2

        onXChanged: change()
        onYChanged: change()
    }

    Timer {

        property double bonus : 0
        property double x : 0
        property double y : 0
        property double lastAngle : 0

        id: ballMovement
        interval: repeatTime

        // Wall collision detection each frame
        onTriggered: {

            bonus+= 0.000008

            if(allowMovement) {

                currentBall.x += x * (1 + bonus)
                currentBall.y += y * (1 + bonus)
                currentBall.rotation += 0.1
            }

            var xCenter = window.width / 2

            if(currentBall.x <= 0){

                var newAngle1 = wall.findFromLeft(lastAngle)

                x = Math.cos(Math.PI/180*newAngle1)
                y = -Math.sin(Math.PI/180*newAngle1)

                lastAngle = newAngle1
            }

            else if(currentBall.y <= 0) {

                var newAngle2 =  wall.findFromTop(lastAngle)

                x = Math.cos(Math.PI/180*newAngle2)
                y = -Math.sin(Math.PI/180*newAngle2)


                lastAngle = newAngle2
            }

            else if(currentBall.x >= window.width-currentBall.width) {

                var newAngle3 = wall.findFromRight(lastAngle)

                x = Math.cos(Math.PI/180*newAngle3)
                y = -Math.sin(Math.PI/180*newAngle3)

                lastAngle = newAngle3
            }

            else if(currentBall.y >= window.height-currentBall.height) {

                var newAngle4 = wall.findFromBottom(lastAngle)

                x = Math.cos(Math.PI/180*newAngle4)
                y = -Math.sin(Math.PI/180*newAngle4)

                lastAngle = newAngle4
            }

        }
    }


    WallDetector {

        id: wall
    }

    CollisionDetector {

        id: coll
    }

    BallManager {

        id: ballManage
    }
}
