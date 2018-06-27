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

    /**
      *@param ball : The MovingBall that has to be launched
      */

    function launch(ball) {

        if(restart.running == false)
            ball.allowMovement = true;

        var angle = Math.random(10) * 360
        ball.xCoords = Math.cos(Math.PI*angle/180)
        ball.yCoords = -Math.sin(Math.PI*angle/180)

        ball.ballMovement.x = ball.xCoords;
        ball.ballMovement.y = ball.yCoords;
        ball.ballMovement.lastAngle = angle
        ball.ballMovement.running = true
        ball.ballMovement.repeat = true

        game.balls.push(ball)
    }
}
