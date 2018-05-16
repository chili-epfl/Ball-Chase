import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.2

ApplicationWindow {

    id: window
    visible: true
    width: 850
    height: 850
    title: qsTr("Ball Chase")

    Button {

        id: playButton
        property Rectangle playColor : playColor

        Rectangle{id:playColor;anchors.fill:parent; visible:true}

        width: 150
        height: 100
        visible: true
        text: "Play"
        font.pointSize: 20
        font.bold: true

        x: window.width / 2 - width/2- width * 1.5
        y: window.height / 2 - height / 2

        onClicked: game.start()
    }

    Button {

        id: options
        property Rectangle optionsColor : optionsColor

        Rectangle{id:optionsColor;anchors.fill:parent; visible:true}

        width: 150
        height: 100
        visible: true
        text: "Options"
        font.pointSize: 20
        font.bold: true

        x: window.width / 2 - width/2 + width * 1.5
        y: window.height / 2 - height / 2

        onClicked: {

            optionsMenu.visible = true
            visible = false
            playButton.visible = false
        }
    }

    Rectangle {

        property Text text : name
        id: optionsMenu
        visible: false
        x: window.width /2 - width/2
        y: window.height /2 - height/2

        width: 300
        height: 200

        Text {
            x: optionsMenu.width / 2 - width / 2
            id: name
            text: qsTr("Themes")

            font.pointSize: 30
            font.bold: true
        }

        Button {

            x: optionsMenu.width / 2 - width / 2 - width
            y: 100
            text: "Dark"

            onClicked: {

                window.color = "black"
                optionsMenu.visible = false
                playButton.visible = true
                options.visible = true

                optionsMenu.color = "black"
                optionsMenu.text.color = "blue"

                game.chrono.color = "black"
                game.lifesRec.color = "black"

                player.body.color = "white"

                options.optionsColor.color = "blue"
                playButton.playColor.color = "blue"


            }

        }

        Button {

            x: optionsMenu.width / 2 - width / 2 + width
            y: 100
            text : "White"
            onClicked: {

                window.color = "white"
                optionsMenu.visible = false
                playButton.visible = true
                options.visible = true

                optionsMenu.color = "white"
                optionsMenu.text.color = "black"

                game.chrono.color = "white"
                game.lifesRec.color = "white"

                player.body.color = "black"

                options.optionsColor.color = "black"
                playButton.playColor.color = "black"

            }

        }
    }

    Game {

        id: game

        onStart: {

            startTimer()
            activeBalls()

            playButton.width = 0
            options.width = 0

            window.update()


            player.focus = true

            // player.body.visible = false


        }


    }

    Player {

        id: player

        enabled: true

    }

}
