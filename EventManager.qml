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
            one.launch()
            break

        case 1:

            two.current.visible = true
            two.launch()
            break

        case 2:

            three.current.visible = true
            three.launch()
            break

        case 3:

            four.current.visible = true
            four.launch()
            break

        case 4:

            five.current.visible = true
            five.launch()
            break

        case 5:

            six.current.visible = true
            six.launch()
            break

        case 6:

            seven.current.visible = true
            seven.launch()
            break

        default:
            break

        }

        pointer++

    }

    MovingBall {id:one; size: 65; colour: "blue"; repeatTime: 7; rad: 1}
    MovingBall {id:two; size: 70; colour: "blue"; repeatTime: 7; rad: 1}
    MovingBall {id:three; size: 75; colour: "blue"; repeatTime: 6; rad: 1}
    MovingBall {id:four; size: 80; colour: "blue"; repeatTime: 6; rad: 1}
    MovingBall {id:five; size: 85; colour: "blue"; repeatTime: 5; rad: 1}
    MovingBall {id:six; size: 90; colour: "blue"; repeatTime: 5; rad: 1}
    MovingBall {id:seven; size: 100; colour: "blue"; repeatTime: 3; rad: 1}

    function multiBall() {

    }






}
