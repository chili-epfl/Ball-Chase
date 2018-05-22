import QtQuick 2.0

Item {

    property int pointer : 0

    function initPlayer(player) {

        player.size = 60
        player.body.x = window.width / 2 - player.body.width / 2
        player.body.y = window.height / 2 - player.body.height / 2

    }

    function addBall() {

        waitBall.running = true

    }

    MovingBall {id:one; size: 65; colour: "blue"; repeatTime: 7; rad: 100}
    MovingBall {id:two; size: 70; colour: "blue"; repeatTime: 7; rad: 100}
    MovingBall {id:three; size: 75; colour: "blue"; repeatTime: 6; rad: 100}
    MovingBall {id:four; size: 80; colour: "blue"; repeatTime: 6; rad: 100}
    MovingBall {id:five; size: 85; colour: "blue"; repeatTime: 5; rad: 100}
    MovingBall {id:six; size: 90; colour: "blue"; repeatTime: 5; rad: 100}
    MovingBall {id:seven; size: 100; colour: "blue"; repeatTime: 3; rad: 100}

    function multiBall() {

        waitMulti.running = true

    }

    MovingBall {id:extraOne; size: 80; colour: "red"; repeatTime: 5; rad: 140}
    MovingBall {id:extraTwo; size: 80; colour: "red"; repeatTime: 5; rad: 140}
    MovingBall {id:extraThree; size: 80; colour: "red"; repeatTime: 5; rad: 140}


    function fatBalls() {

        waitFat.running = true
    }

    function moon() {

        waitMoon.running = true
    }

    MovingBall {id:moon; size: 300; colour: "gray"; repeatTime: 10; rad: 500}

    Timer {

        id: waitMulti
        repeat: false
        interval: 3000

        onTriggered: {

            var event = 1


            extraOne.current.x = window.width / 2 - extraOne.current.width
            extraTwo.current.x = window.width / 2 - extraTwo.current.width
            extraThree.current.x = window.width / 2 - extraThree.current.width

            extraOne.current.y = window.height / 2 - extraOne.current.height
            extraTwo.current.y = window.height / 2 - extraTwo.current.height
            extraThree.current.y = window.height / 2 - extraThree.current.height


            timerEvent.running = true
            timerEvent.event = event

            extraOne.current.visible = true
            extraTwo.current.visible = true
            extraThree.current.visible = true

            ballManage.launch(extraOne)
            ballManage.launch(extraTwo)
            ballManage.launch(extraThree)
        }
    }

    Timer {

        id: waitBall
        repeat: false
        interval: 3000

        onTriggered:  {

            timerEvent.running = true
            timerEvent.event = 0

            switch(pointer) {

            // this code has been done like this because of a problem when using Qt.createComponent
            case 0:

                one.current.visible = true
                ballManage.launch(one)
                break

            case 1:

                two.current.visible = true
                ballManage.launch(two)
                break

            case 2:

                three.current.visible = true
                ballManage.launch(three)
                break

            case 3:

                four.current.visible = true
                ballManage.launch(four)
                break

            case 4:

                five.current.visible = true
                ballManage.launch(five)
                break

            case 5:

                six.current.visible = true
                ballManage.launch(six)
                break

            case 6:

                seven.current.visible = true
                ballManage.launch(seven)
                break

            default:
                break

            }

            pointer++
        }

    }

    Timer {

        id: waitFat
        repeat: false
        interval: 3000

        onTriggered: {

            var event = 2

            timerEvent.running = true
            timerEvent.event = event

            for(var a = 0; a<game.balls.length; a++) {

                game.balls[a].size += 40
            }
        }

    }

    Timer {

        id: waitMoon
        repeat: false
        interval: 3000
        onTriggered: {

            var event = 3

            moon.current.x = window.width / 2 - moon.current.width
            moon.current.y = window.height / 2 - moon.current.height

            timerEvent.running = true
            timerEvent.event = event

            ballManage.launch(moon)
            moon.current.visible = true
        }

    }

    Timer {

        id: timerEvent

        property int event : 0
        property int current : 20

        repeat: true
        interval: 1000

        onTriggered: {

            current--

            if(current == 0) {

                switch(event) {

                case 0: break

                case 1:
                    finishMultiBalls()
                    break

                case 2:
                    finishFatBalls()
                    break

                case 3:
                    finishMoon()
                    break
                }

                running = false

                current = 20

                player.info.color = "orange"
                player.info.text = "Waiting for an other super fun event...."
            }
        }
    }

    Rectangle {

        id: rec
    }

    function finishMultiBalls() {

        console.log("Successfully finished MultiBall event")

        extraOne.current.x = 900000
        extraTwo.current.x = 900000
        extraThree.current.x = 900000


    }

    function finishFatBalls() {

        console.log("Successfully finished FatBall event")

        for(var a = 0; a<game.balls.length; a++) {

            game.balls[a].size -= 40
        }

    }

    function finishMoon() {

        moon.current.x = 900000
    }

    BallManager {

        id: ballManage
    }
}
