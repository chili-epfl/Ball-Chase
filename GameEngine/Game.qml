
import QtQuick 2.0

Item {

    signal start
    property int lifeAmount : 2
    property Repeater repeater: ballSpawner
    property Rectangle chrono : chronoRectangle
    property Rectangle lifesRec : lifesRectangle
    property Rectangle respawnTitle : respawnTitle
    property Rectangle endTitle : endTitle
    property Timer gameTimer : gameTimer
    property Timer restart : restart
    property int next : 0
    property list<MovingBall> balls

    Repeater{

        id: ballSpawner
        model: 4

        MovingBall {size: 80+index; colour: "blue";repeatTime: 5 + index / 10;rad: 100}

    }

    function activeBalls() {

        for(var a = 0; a < ballSpawner.model ; a++) {

            ballManage.launch(ballSpawner.itemAt(a))
            ballSpawner.itemAt(a).current.visible = true
        }
    }

    function startTimer() {

        gameTimer.running = true
    }

    Rectangle {

        property Text text : chronoText

        id: chronoRectangle
        visible: true
        width: 80
        height: 30

        Text {
            id: chronoText
            font.bold: true
            font.pointSize: 20
            color: "purple"
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
            pointerColor++

            if(seconds == 59) {
                seconds = 0
                minutes++
            }

            else
                seconds++

            if(pointer > ballSpawner.model -1)
                pointer = 0

            if(pointerColor == colors.length)
                pointerColor = 0

            if(minutes == 0 && seconds == 1)
                event.initPlayer(player)

            ballSpawner.itemAt(pointer).current.color = colors[pointerColor]



            var eventNumber;

            if((seconds + 3) % 30 == 0) {

                chooseNewEvent()
            }
        }
    }

    function chooseNewEvent() {

        eventNumber = Math.floor(Math.random() * 4);
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

    Rectangle {

        id: respawnTitle
        visible: false
        x: window.width / 2

        Text {

            color: "green"
            anchors.horizontalCenter: parent.horizontalCenter
            font.bold: true
            y: window.height / 2 -50

            font.pointSize: 40

            text: qsTr("Respawn in "+restart.current)
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
            anchors.horizontalCenter: parent.horizontalCenter
            font.bold: true
            y: window.height / 2 - height

            font.pointSize: 60

            color: "red"
            text: qsTr("Game Over !")
        }

        Text {

            id: endNameScore
            visible: true

            anchors.horizontalCenter: parent.horizontalCenter
            font.bold: true
            y: window.height / 2 + height / 2

            font.pointSize: 20
            color: "green"
            text: qsTr("Your score is "+game.gameTimer.minutes+" : "+game.gameTimer.seconds)
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

                ballManage.allowMoves()

                respawnTitle.visible = false
            }

            else
                current--
        }
    }

    EventManager {

        id:event
    }

    BallManager {

        id: ballManage
    }
}
