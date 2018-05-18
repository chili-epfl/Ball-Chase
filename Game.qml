
import QtQuick 2.0

Item {

    signal start
    property int lifeAmount : 500
    property Repeater repeater: repeat
    property Rectangle chrono : chrono
    property Rectangle lifesRec : lifesRectangle
    property Timer gameTimer : gameTimer
    property int next : 0
    property list<MovingBall> balls

    function startTimer() {

        gameTimer.running = true

    }

    Repeater{

        id: repeat
        model: 4

        MovingBall {size: 80+index; colour: "blue";repeatTime: 5 + index / 12;rad: 100}

    }

    function activeBalls() {

        for(var a = 0; a < repeat.model ; a++) {

            repeat.itemAt(a).launch(balls, repeat.itemAt(a))
            repeat.itemAt(a).current.visible = true

        }

    }


    Rectangle {

        property Text text : name

        id: chrono
        visible: true
        width: 80
        height: 30

        Text {
            font.bold: true
            font.pointSize: 20
            color: "purple"
            id: name
            text: qsTr(gameTimer.minutes+" : "+gameTimer.seconds)
        }
    }

    Rectangle {

        id: lifesRectangle

        visible: true
        width: 150
        height: 30

        x: window.width - width * 1.23
        Text {
            id: lifes
            color: "orange"
            font.bold: true
            font.pointSize: 20
            text: qsTr("Lifes left : "+lifeAmount)
        }
    }




    Timer {

        id: gameTimer

        property int minutes : 0
        property int seconds : 0
        property int pointer : 0
        property int pointerColor : 0

        interval: 1000
        repeat : true

        onTriggered: {

            var colors = ["red","green","purple","yellow","blue","orange","pink","gray"]

            pointer++

            if(seconds == 59) {
                seconds = 0
                minutes++
            }

            else seconds++

            if(pointer > repeat.model -1) {
                pointer = 0

            }

            pointerColor++

            if(pointerColor == colors.length)
                pointerColor = 0

            repeat.itemAt(pointer).current.color = colors[pointerColor]

            if(minutes == 0 && seconds == 1)

                event.initPlayer(player)


            var eventNumber;

            if((seconds + 3) % 30 == 0) {

                console.log("New Event")
                eventNumber = 0//Math.floor(Math.random() * 4);
                player.info.color = "blue"

                switch(eventNumber) {                  

                case 0:

                    player.info.text = "Of course this game is easy. Want more difficulty ? Sure. One ball more !"

                    event.addBall()
                    break

                case 1:

                    player.info.text = "Don't touch them, red balls are hot. Multi Balls !"

                    event.multiBall()
                    break

                case 2:

                    player.info.text = "I hope you don't usually eat what these balls do. Fat baaaaaaalls !"
                    event.fatBalls()
                    break

                case 3:
                    player.info.text = "Want to be an astronaut ? Just ask. Here is a moon"
                    event.moon()
                    break;
                }

            }


        }
    }

    EventManager {

        id:event
    }



}
