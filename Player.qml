import QtQuick 2.0
import QtQuick.Controls 1.2
import Cellulo 1.0

Item {

    // Warning : the code uses Cellulo 1.0 library
    //To stay with keyboard input use the code committed at the bottom instead

    property Rectangle body : playerBody
    property CelluloRobot robot : robot
    property int size : 60
    property double angle : 90
    property double speed : 0.25

    property int sheetSize : 250
    property double coeff : window.width / sheetSize

    focus: true

    Rectangle {

        visible: true
        id: playerBody

        color: "black"

        width: size
        height: size
        radius: 15

        x: robot.x * coeff
        y: robot.y * coeff

        onXChanged: {
            console.log(coeff)
            console.log(x+"/"+y)
        }
    }


    ApplicationWindow {

        id: window

        visible: true
        width: 940
        height: 300
        title: qsTr("Robot Connecting Pannel")


        Text {
            id: name
            visible: true
            text: qsTr("Welcome to the robot interface !")
            font.bold: true
            font.pointSize: 20
            x : window.width / 2 - width / 2
            y : window.height / 2 - 60
        }
        MacAddrSelector {
            addresses: [
                // 17 adresses
                "00:06:66:74:3E:7E",
                "00:06:66:74:48:A7",
                "00:06:66:74:40:D2",
                "00:06:66:74:40:D4",
                "00:06:66:74:40:D5",
                "00:06:66:74:40:DB",
                "00:06:66:74:40:DC",
                "00:06:66:74:40:E4",
                "00:06:66:74:40:EC",
                "00:06:66:74:40:EE",
                "00:06:66:74:41:03",
                "00:06:66:74:41:04",
                "00:06:66:74:41:14",
                "00:06:66:74:41:4C",
                "00:06:66:74:43:00",
                "00:06:66:74:43:01",
                "00:06:66:74:46:58",
                "00:06:66:74:46:60"
            ]

            onConnectRequested: robot.macAddr = selectedAddress
            onDisconnectRequested: robot.disconnectFromServer()
            connectionStatus: robot.connectionStatus

        }

        CelluloRobot {

            // connectionStatus is a variable from CelluloRobot file -> enum { Disconnected, TryingToConnect, Connected
            id: robot

            onConnectionStatusChanged: {

                //Compare to test if the robot is connected
                if(connectionStatus === CelluloBluetoothEnums.ConnectionStatusConnected) {
                    // If yes, make the title green
                    setVisualEffect(CelluloBluetoothEnums.VisualEffectConstAll, "green", 0);

                }

                console.log("Info : Attempt to change robot's statut");
            }


        }

    }



    /*
    property Rectangle body : playerBody
    property int size : 0
    property double angle : 90
    property double speed : 0.25

    Timer {

        interval: 1
        running: true
        repeat: true

        onTriggered: {

            var x = Math.cos(Math.PI/180*angle)
            var y = -Math.sin(Math.PI/180*angle)

            if(x < 0 && body.x >= 0.1)
                body.x += speed * x

            if(x > 0 && body.x <= window.width-body.height)
                body.x += speed * x

            if(y < 0 && body.y >= 0.1)
                body.y += speed * y

            if(y > 0 && body.y <= window.width-body.height)
                body.y += speed * y


        }
    }

    focus: true

    Keys.onReleased: {


        if (event.key === Qt.Key_W) {

            speed += 0.05
            event.accepted = true;
        }

        if (event.key === Qt.Key_A) {

            angle += 30
            event.accepted = true;

        }

        if (event.key === Qt.Key_D) {

            angle -= 30
            event.accepted = true;
        }

        if (event.key === Qt.Key_S) {

            speed -= 0.05
            event.accepted = true;
        }

        if(event.key === Qt.Key_Space) {

            body.x = window.width / 2 - player.body.width / 2
            body.y = window.height / 2 - player.body.height / 2
        }


    }

    Rectangle {

        id: playerBody

        color: "black"

        width: size
        height: size
        radius: 15



    }*/

}
