import QtQuick 2.0

Item {


    function isCollisionBetween(rec1, rec2){

        var distanceX = rec1.x - rec2.x
        var distanceY = rec1.y - rec2.y

        var distanceSquared = distanceX * distanceX + distanceY * distanceY

        var radius = rec1.width / 2 + rec2.width / 2
        var radiusSquared = radius * radius

        return radiusSquared > distanceSquared



    }

}
