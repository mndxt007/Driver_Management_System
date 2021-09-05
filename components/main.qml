import QtQuick 2.15
import QtQuick.Controls 2.5
import QtQuick.Controls.Styles 1.4
import QtQuick.Window 2.0
import QtLocation 5.15
import QtPositioning 5.15




Window {
    id : window
    width: 512
    height: 512
    visible: true
    color: "#1c1a1a"
    
    CustomButton{
        id : b1
        width: 100
        height: 40
        text: "Route2"
        anchors.right: frame.left
        anchors.bottom: frame.bottom
        anchors.bottomMargin: frame.height * 0.25
        colorPressed: "#075db4"
        colorDefault: "#0c0c0c"
        colorMouseOver: "#5a5a5c"
        anchors.rightMargin: ((window.width - frame.width) - b1.width)/2

        onClicked:
        {
            mapview.visible = true
            mapview1.visible = false
        }

    }

    CustomButton{
        id : b2
        width: 100
        height: 40
        text: "Route1"
        anchors.right: frame.left
        anchors.bottom: frame.bottom
        anchors.bottomMargin: frame.height * 0.75
        colorPressed: "#075db4"
        colorDefault: "#0c0c0c"
        colorMouseOver: "#5a5a5c"
        anchors.rightMargin: ((window.width - frame.width) - b1.width)/2

        onClicked:
        {
            mapview.visible= false
            mapview1.visible = true
        }

    }


    Frame {
        id: frame
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.leftMargin: window.width * 0.25
        anchors.topMargin: window.height * 0.15
        anchors.bottomMargin: 0
        anchors.rightMargin: 0

        Loader
        {
            id : mapview
            anchors.fill: parent
            source: Qt.resolvedUrl(".")+"/mapview1.qml"
            onLoaded: item.calculateCoordinateRoute()
        }
        Loader
        {
            id : mapview1
            anchors.fill: parent
            source: Qt.resolvedUrl(".")+"/mapview2.qml"
            visible: false
            onLoaded: item.calculateCoordinateRoute()
        }
    }

    Label {
        id: label
        x: 226
        y: 21
        color: "#d9dce0"
        text: qsTr("Driver Management System")
        font.family: "Verdana"
        font.pointSize: 17
        anchors.horizontalCenter: parent.horizontalCenter
    }


    

}





