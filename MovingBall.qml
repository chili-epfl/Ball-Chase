
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
    }

    function launch() {

        var angle = Math.random(10) * 360
        xCoords = Math.cos(Math.PI*angle/180)
        yCoords = -Math.sin(Math.PI*angle/180)

        launchTimer.x = xCoords;
        launchTimer.y = yCoords;
        launchTimer.lastAngle = angle
        launchTimer.running = true
        launchTimer.repeat = true

    }

    Timer {

        property double x : 0
        property double y : 0
        property double lastAngle : 0

        id: launchTimer
        interval: repeatTime

        onTriggered: {

            coeff += 0.00003

            currentBall.x += x * coeff
            currentBall.y += y * coeff
            currentBall.rotation += rot

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

            //            if(coll.isCollisionBetween(player.body, currentBall))
            //                console.log("Collision")

        }
    }

    WallDetector {

        id: wall
    }

    CollisionDetector {

        id: coll
    }


}
