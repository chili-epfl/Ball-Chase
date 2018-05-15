
import QtQuick 2.0

Item {

    function findFromLeft(angle) {

        if(angle >= 90 && angle <= 180)
            return Math.random() * 90

        else if(angle > 180 && angle <= 270)
            return Math.random() * 90 + 270

        else return angle

    }

    function findFromRight(angle) {

        if(angle > 270)
            return Math.random() * 90 + 180

        else if(angle < 90)
            return Math.random() * 90 + 90


        else return angle


    }

    function findFromTop(angle) {

        if(angle >= 90 && angle <= 180)
            return Math.random() * 90 + 180

        else if(angle > 0 && angle <= 90)
            return Math.random() * 90 + 270

        else return angle

    }

    function findFromBottom(angle) {

        if(angle > 180 && angle <= 270)
            return Math.random() * 90 + 90

        else if(angle > 270)
            return Math.random() * 90

        else return angle

    }

}
