import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.2

ApplicationWindow {

    id: window
    visible: true
    width: 860
    height: 860
    title: qsTr("Ball escape")
    color: "black"

    Button {

        id: mainButton

        width: 100
        height: 100
        visible: true
        text: "Play"

        x: window.width / 2 - width / 2
        y: window.height / 2 - height / 2

        onClicked: game.start()
    }

    Game {

        id: game

        onStart: {

            startTimer()
            activeBalls()

            mainButton.width = 0

            window.update()


            player.focus = true

            player.body.size = 60

            player.body.visible = false


        }


    }

    Player {

        id: player

        enabled: true

    }

}
