import QtQuick 2.0

Item {

    function initPlayer(player) {

        player.size = 60
        player.body.x = window.width / 2 - player.body.width / 2
        player.body.y = window.height / 2 - player.body.height / 2

    }

    function addBall() {

        var component = Qt.createComponent("MovingBall.qml");

        if (component.status === Component.Ready)
            component.createObject(null, {"size" : 80,"colour":"blue","repeatTime":5,"rad":5});

        component.launch()
        component.current.visible = true


    }

}
