import QtQuick 2.0

Item {

    function hideAll() {

        for(var b = 0; b<game.balls.length; b++)
            game.balls[b].current.visible = false
    }

    function stopMoves() {

        for(var a = 0; a<game.balls.length; a++)
            game.balls[a].allowMovement = false
    }

    function allowMoves() {

        for(var a = 0; a<game.balls.length; a++)
            game.balls[a].allowMovement = true
    }

    function launch(ball) {

        if(restart.running == false)
            allowMovement = true

        var angle = Math.random(10) * 360
        xCoords = Math.cos(Math.PI*angle/180)
        yCoords = -Math.sin(Math.PI*angle/180)

        ball.ballMovement.x = xCoords;
        ball.ballMovement.y = yCoords;
        ball.ballMovement.lastAngle = angle
        ball.ballMovement.running = true
        ball.ballMovement.repeat = true

        game.balls.push(ball)
    }
}
