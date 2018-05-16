import QtQuick 2.0

Item {

    property int pointer : 0

    function initPlayer(player) {

        player.size = 60
        player.body.x = window.width / 2 - player.body.width / 2
        player.body.y = window.height / 2 - player.body.height / 2

    }

    function addBall() {

        switch(pointer) {

        case 0:

            one.current.visible = true
            one.launch(game.balls, one)
            break

        case 1:

            two.current.visible = true
            two.launch(game.balls, two)
            break

        case 2:

            three.current.visible = true
            three.launch(game.balls, three)
            break

        case 3:

            four.current.visible = true
            four.launch(game.balls, four)
            break

        case 4:

            five.current.visible = true
            five.launch(game.balls, five)
            break

        case 5:

            six.current.visible = true
            six.launch(game.balls, six)
            break

        case 6:

            seven.current.visible = true
            seven.launch(game.balls, seven)
            break

        default:
            break

        }

        pointer++

    }

    MovingBall {id:one; size: 65; colour: "blue"; repeatTime: 7; rad: 100}
    MovingBall {id:two; size: 70; colour: "blue"; repeatTime: 7; rad: 100}
    MovingBall {id:three; size: 75; colour: "blue"; repeatTime: 6; rad: 100}
    MovingBall {id:four; size: 80; colour: "blue"; repeatTime: 6; rad: 100}
    MovingBall {id:five; size: 85; colour: "blue"; repeatTime: 5; rad: 100}
    MovingBall {id:six; size: 90; colour: "blue"; repeatTime: 5; rad: 100}
    MovingBall {id:seven; size: 100; colour: "blue"; repeatTime: 3; rad: 100}

    function multiBall() {

        // TODO : RESET POSITION AND SIZE AT THE BEGINNING
        var event = 1

        timerEvent.running = true
        timerEvent.event = event

        extraOne.current.visible = true
        extraTwo.current.visible = true

        extraOne.launch(game.balls, extraOne)
        extraTwo.launch(game.balls, extraTwo)

    }

    MovingBall {id:extraOne; size: 80; colour: "red"; repeatTime: 5; rad: 140}
    MovingBall {id:extraTwo; size: 80; colour: "red"; repeatTime: 5; rad: 140}

    function fatBalls() {

        var event = 2

        timerEvent.running = true
        timerEvent.event = event

        for(var a = 0; a<game.balls.length; a++) {

            game.balls[a].size += 40
        }

    }

    function moon() {

        var event = 3

        timerEvent.running = true
        timerEvent.event = event

        moon.launch(game.balls, moon)
        moon.current.visible = true
    }

    MovingBall {id:moon; size: 350; colour: "gray"; repeatTime: 5; rad: 1000}


    Timer {

        id: timerEvent

        property int event : 0
        property int current : 10

        repeat: true
        interval: 1000

        onTriggered: {

            current--

            if(current == 0) {

                switch(event) {

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

                current = 10
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








}
