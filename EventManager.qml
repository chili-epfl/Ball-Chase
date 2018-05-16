import QtQuick 2.0

Item {

    function initPlayer(player) {

        player.size = 60
        player.body.x = window.width / 2 - player.body.width / 2
        player.body.y = window.height / 2 - player.body.height / 2

    }

    function addBall(game) {

    }

}
