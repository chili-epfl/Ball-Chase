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

        Text {

            id: playText
            anchors.horizontalCenter: playButton.horizontalCenter
            font.pointSize: 40
            font.bold: true
            text: "Play"
            color: "black"

        }


        x: window.width / 2 - width/2
        y: window.height / 2 - height

        onClicked: game.start()
    }

    Button {

        id: options
        property Rectangle optionsColor : optionsColor

        Rectangle{id:optionsColor;anchors.fill:parent; visible:true}

        width: 200
        height: 50
        visible: true

        Text {
            id: optionText
            anchors.horizontalCenter: options.horizontalCenter
            font.pointSize: 30
            text: "Options"
            color: "black"

        }

        x: window.width / 2 - width/2
        y: window.height / 2

        onClicked: {

            optionsMenu.visible = true
            visible = false
            playButton.visible = false
        }
    }

    Rectangle {

        id: optionsMenu

        property Text text : name
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
                playText.color = "white"
                options.visible = true

                optionsMenu.color = "black"
                optionsMenu.text.color = "white"

                game.chrono.color = "black"
                game.lifesRec.color = "black"

                player.body.color = "white"

                optionText.color = "white"
                playText.color = "white"

                optionsColor.color = "black"
                playColor.color = "black"


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

                optionText.color = "black"
                playText.color = "black"

                optionsColor.color = "white"
                playColor.color = "white"


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
            optionText.visible = false
            playText.visible = false

            player.focus = true

        }


    }

    Player {

        id: player
        visible: true
        focus: true

    }

}
