
import QtQuick 2.0

Item {

    signal start


    function startTimer() {

        gameTimer.running = true

    }


    Repeater{

        id: repeat
        model: 60

        MovingBall {size: 50+index; colour: "blue";repeatTime: 1 + index / 12;rad: index/5; rot:index/40}


    }

    function activeBalls() {

        for(var a = 0; a < repeat.model ; a++) {

            repeat.itemAt(a).launch()
            repeat.itemAt(a).current.visible = true

        }

    }

    Rectangle {

        visible: false
        width: 80
        height: 30

        Text {
            id: name
            text: qsTr(gameTimer.minutes+" : "+gameTimer.seconds)
        }
    }

    Timer {

        id: gameTimer

        property int minutes : 0
        property int seconds : 0
        property int pointer : 0
        property int pointerColor : 0

        interval: 50
        repeat : true

        onTriggered: {

            var colors = ["red","green","purple","yellow","blue","orange","pink","gray","black"]

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




        }
    }



}
