import QtQuick 2.0
import QtQuick.Controls 1.2
import Cellulo 1.0
import QMLCache 1.0
import QMLBluetoothExtras 1.0


Item {

    // Warning : the code uses Cellulo 1.0 library
    //To stay with keyboard input use the code committed at the bottom instead

    property Rectangle body : playerBody
    property Text info : infos
    property CelluloRobot robot : robot
    property int size : 60
    property double angle : 90
    property double speed : 0.25

    property int sheetSize : 250
    property double coeff : window.width / sheetSize

    focus: true

    Rectangle {

        visible : false
        id: playerBody

        color: "black"

        width: size
        height: size
        radius: 15
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
            y : window.height / 2 - 40
        }

        Text {

            id: infos
            visible: true
            text: qsTr("To start a game: connect your robot, place it wherever you want and click play\n"
                        +"                  You'll be informed here when a new event occur")

            font.bold: true
            font.pointSize: 15

            color: "green"

            x : window.width / 2 - width / 2
            y : window.height / 2 + 20
        }

        GroupBox {
            title: "Robot Address"
            width: 940

            Column{
                spacing: 5

                MacAddrSelector{
                    id: macAddrSelector
                    addresses: QMLCache.read("addresses").split(",")
                    onConnectRequested: {
                        robot.localAdapterMacAddr = selectedLocalAdapterAddress;
                        robot.macAddr = selectedAddress;
                    }
                    onDisconnectRequested: robot.disconnectFromServer()
                    connectionStatus: robot.connectionStatus
                }

                Row{
                    spacing: 5

                    BusyIndicator{
                        running: scanner.scanning
                        height: scanButton.height
                    }

                    Button{
                        id: scanButton
                        text: "Scan"
                        onClicked: scanner.start()
                    }

                    Button{
                        text: "Clear List"
                        onClicked: {
                            macAddrSelector.addresses = [];
                            QMLCache.write("addresses","");
                        }
                    }
                }
            }
        }

        CelluloBluetoothScanner{
            id: scanner
            onRobotDiscovered: {
                var newAddresses = macAddrSelector.addresses;
                if(newAddresses.indexOf(macAddr) < 0){
                    toast.show(macAddr + " discovered.");
                    newAddresses.push(macAddr);
                    newAddresses.sort();
                }
                macAddrSelector.addresses = newAddresses;
                QMLCache.write("addresses", macAddrSelector.addresses.join(','));
            }
        }

        ToastManager{ id: toast }

        CelluloRobot {

            // connectionStatus is a variable from CelluloRobot file -> enum { Disconnected, TryingToConnect, Connected
            id: robot

            onConnectionStatusChanged: {

                robot.reset()
                //Compare to test if the robot is connected
                if(connectionStatus === CelluloBluetoothEnums.ConnectionStatusConnected) {
                    // If yes, make the title green
                    setVisualEffect(CelluloBluetoothEnums.VisualEffectConstAll, "green", 0);

                }

                console.log("Info : Attempt to change robot's statut");
            }

            onPoseChanged: {

                body.x = robot.x * coeff
                body.y = robot.y * coeff

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
