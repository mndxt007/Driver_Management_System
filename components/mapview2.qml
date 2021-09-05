import QtQuick 2.15
import QtQuick.Controls 2.5
import QtQuick.Window 2.0
import QtLocation 5.15
import QtPositioning 5.15

Map {
    Plugin {
        id: mapPlugin
        name: "osm" // "mapboxgl", "esri", ...
    }
    property alias routeQuery: routeQuery
    property alias routeModel: routeModel
    property double p1latt :12.3106368
    property double p1long : 76.5656493
    property double p2latt : 15.1357583
    property double p2long : 76.8365523

    id : map
    color: "#1a1818"
    anchors.fill: parent
    tilt: 45
    //anchors.leftMargin: 147
    //anchors.topMargin: 53
    plugin: mapPlugin
    center: QtPositioning.coordinate(map.p1latt,map.p1long) // start point
    //zoomLevel: 15
    copyrightsVisible : false
    //activeMapType: supportedMapTypes[0]



RouteModel {
    id: routeModel
    plugin : map.plugin
    //autoUpdate: true
    query:  RouteQuery {
        id: routeQuery
    }
    onStatusChanged: {
        console.log("current route model status", status, count, errorString)

    }

}





MapItemView {
    id : mapview1
    model: routeModel
    delegate: routeDelegate
//! [routeview0]
    autoFitViewport: true
//! [routeview1]
}




Component {
    id: routeDelegate

    MapRoute {
        id: route
        route: routeData
        line.color: "green"
        line.width: 5
        smooth: true
        opacity: 0.8
    }

}



MapQuickItem {
    id: p1
    sourceItem: Rectangle { width: 14; height: 14; color: "#e41e25"; border.width: 2; border.color: "white"; smooth: true; radius: 7 }
    coordinate {
        latitude: map.p1latt
        longitude: map.p1long
    }
    opacity: 1.0
    anchorPoint: Qt.point(sourceItem.width/2, sourceItem.height/2)
}

MapQuickItem {
    id: p2
    sourceItem: Rectangle { width: 14; height: 14; color: "#e41e25"; border.width: 2; border.color: "white"; smooth: true; radius: 7 }
    coordinate {
        latitude: map.p2latt
        longitude: map.p2long
    }
    opacity: 1.0
    anchorPoint: Qt.point(sourceItem.width/2, sourceItem.height/2)
}

MapQuickItem {
    sourceItem: Text{
        text: "P1"
        color:"red"
        font.bold: true
        styleColor: "#ECECEC"
        style: Text.Outline
    }
    coordinate: p1.coordinate
    anchorPoint: Qt.point(-p1.sourceItem.width * 0.5,p1.sourceItem.height * 1.5)
}

MapQuickItem {
    sourceItem: Text{
        text: "P2"
        color:"green"
        font.bold: true
        styleColor: "#ECECEC"
        style: Text.Outline
    }
    coordinate: p2.coordinate
    anchorPoint: Qt.point(-p2.sourceItem.width * 0.5,p2.sourceItem.height * 1.5)
}
function calculateCoordinateRoute()
    {
        //! [routerequest0]
        // clear away any old data in the query
        routeQuery.clearWaypoints();

        // add the start and end coords as waypoints on the route
        routeQuery.addWaypoint(QtPositioning.coordinate(map.p1latt,map.p1long))
        routeQuery.addWaypoint(QtPositioning.coordinate(map.p2latt,map.p2long))
        routeQuery.travelModes = RouteQuery.CarTravel
        routeQuery.routeOptimizations = RouteQuery.FastestRoute

        //! [routerequest0]

        //! [routerequest0 feature weight]
        for (var i=0; i<9; i++) {
            routeQuery.setFeatureWeight(i, 0)
        }
        //for (var i=0; i<routeDialog.features.length; i++) {
        //    map.routeQuery.setFeatureWeight(routeDialog.features[i], RouteQuery.AvoidFeatureWeight)
        //}
        //! [routerequest0 feature weight]

        //! [routerequest1]
        routeModel.update();

        //! [routerequest1]
        //! [routerequest2]
        // center the map on the start coord
        map.center = QtPositioning.coordinate(map.p1latt,map.p1long);
        //! [routerequest2]
    }




}

