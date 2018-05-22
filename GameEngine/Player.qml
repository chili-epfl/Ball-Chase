import QtQuick 2.0
import QtQuick.Controls 1.2
import Cellulo 1.0
import QMLCache 1.0
import QMLBluetoothExtras 1.0


Item {

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
}
