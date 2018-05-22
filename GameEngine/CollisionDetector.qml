import QtQuick 2.0

Item {


    function isCollisionBetween(rec1, rec2){

        var distanceX = (rec1.x + rec1.width/2) - (rec2.x + rec2.width / 2)
        var distanceY = (rec1.y + rec1.height/2) - (rec2.y + rec2.height/2)

        var distanceSquared = distanceX * distanceX + distanceY * distanceY

        var radius = rec1.width / 2 + rec2.width / 2
        var radiusSquared = radius * radius

        return radiusSquared > distanceSquared

    }

}
