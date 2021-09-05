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
    property alias routeQuery1: routeQuery1
    property alias routeModel: routeModel

    id : map
    color: "#1a1818"
    anchors.fill: parent
    tilt: 45
    //anchors.leftMargin: 147
    //anchors.topMargin: 53
    plugin: mapPlugin
    center: QtPositioning.coordinate(15.44, 75.00) // Dharwad
    //zoomLevel: 15
    copyrightsVisible : false
    //activeMapType: supportedMapTypes[0]
    function createMenu()
    {
        for (var i = 0; i<supportedMapTypes.length; i++) {
            console.log(supportedMapTypes[i].name);
            if (supportedMapTypes[i].name==="Night Transit Map")
                map.activeMapType = supportedMapTypes[i]
        }

    }



RouteModel {
    id: routeModel
    plugin : map.plugin
    //autoUpdate: true
    query:  RouteQuery {
        id: routeQuery
    }
    onStatusChanged: {
        console.log("current route model status", status, count, errorString)
        if (status===1)
            mapview1.update()
    }

}

RouteModel {
    id: routeModel1
    plugin : map.plugin
    //autoUpdate: true
    query:  RouteQuery {
        id: routeQuery1
    }
    onStatusChanged: {
        console.log("current route model status_", status, count, errorString)
        if (status===1)
            console.log(routeQuery1.waypoints)
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

MapItemView {
    model: routeModel1
    delegate: routeDelegate2
//! [routeview0]
    autoFitViewport: true
//! [routeview1]
}


Component {
    id: routeDelegate

    MapRoute {
        id: route
        route: routeQuery.waypoints
        line.color: "#DC143C"
        line.width: 5
        smooth: true
        opacity: 0.8
    }

}

Component {
    id: routeDelegate2

    MapRoute {
        id: route1
        route: routeData
        line.color: "green"
        line.width: 5
        smooth: true
        opacity: 0.8
    }

}

MapQuickItem {
    id: poiTheQtComapny
    sourceItem: Rectangle { width: 14; height: 14; color: "#e41e25"; border.width: 2; border.color: "white"; smooth: true; radius: 7 }
    coordinate {
        latitude: 15.4630841
        longitude: 74.9626463
    }
    opacity: 1.0
    anchorPoint: Qt.point(sourceItem.width/2, sourceItem.height/2)
}

MapQuickItem {
    sourceItem: Text{
        text: "Dharwad"
        color:"#242424"
        font.bold: true
        styleColor: "#ECECEC"
        style: Text.Outline
    }
    coordinate: poiTheQtComapny.coordinate
    anchorPoint: Qt.point(-poiTheQtComapny.sourceItem.width * 0.5,poiTheQtComapny.sourceItem.height * 1.5)
}
function calculateCoordinateRoute()
    {
        //! [routerequest0]
        // clear away any old data in the query
        routeQuery.clearWaypoints();

        // add the start and end coords as waypoints on the route
        routeQuery.addWaypoint(QtPositioning.coordinate(12.95396,77.4908542))
        routeQuery.addWaypoint(QtPositioning.coordinate(15.4630841,74.9626463))
        routeQuery.addWaypoint(QtPositioning.coordinate(12.3106368,76.5656493))
        routeQuery.addWaypoint(QtPositioning.coordinate(15.1357583,76.8365523))
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
        map.center = QtPositioning.coordinate(12.95396,77.4908542);
        //! [routerequest2]
    }


function calculateCoordinateRoute1()
    {
        //! [routerequest0]
        // clear away any old data in the query
        routeQuery1.clearWaypoints();

        // add the start and end coords as waypoints on the route
        routeQuery1.addWaypoint(QtPositioning.coordinate(12.95396,77.4908542))
        routeQuery1.addWaypoint(QtPositioning.coordinate(12.3106368,76.5656493))
        routeQuery1.travelModes = RouteQuery.CarTravel
        routeQuery1.routeOptimizations = RouteQuery.FastestRoute

        //! [routerequest0]

        //! [routerequest0 feature weight]
        for (var i=0; i<9; i++) {
            routeQuery1.setFeatureWeight(i, 0)
        }
        //for (var i=0; i<routeDialog.features.length; i++) {
        //    map.routeQuery.setFeatureWeight(routeDialog.features[i], RouteQuery.AvoidFeatureWeight)
        //}
        //! [routerequest0 feature weight]

        //! [routerequest1]
        routeModel1.update();

        //! [routerequest1]
        //! [routerequest2]
        // center the map on the start coord
        map.center = QtPositioning.coordinate(12.95396,77.4908542);
        //! [routerequest2]
    }

}

