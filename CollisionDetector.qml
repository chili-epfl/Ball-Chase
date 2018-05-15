import QtQuick 2.0

Item {

    // NON WORKING FILE - TODO : FIND OTHER WAY OF DOING COLLISION

    function isCollisionBetween(rec1, rec2){

        var edges1 = new Array(360);
        var edges2 = new Array(360);



        var r1 = rec1.width / 2
        var r2 = rec2.width / 2

        for(var a = 1; a <= 360; a++) {

            edges1[a] = new Array(2)
            edges2[a] = new Array(2)


            edges1[a-1][0] = r1 * Math.cos(Math.PI/180*a)
            edges1[a-1][1] = r1 * Math.sin(Math.PI/180*a)

            edges2[a-1][0] = r2 * Math.cos(Math.PI/180*a)
            edges2[a-1][1] = r2 * Math.sin(Math.PI/180*a)

        }

        for(var i = 1; i <= 360; i++) {

            for(var j = 1; j <= 360; j++) {

                if(edges1[i][0] === edges2[j][0] && edges1[i][1] === edges2[j][1])
                    return true
            }

        }

        return false

    }

}
