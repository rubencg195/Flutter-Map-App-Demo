import 'package:flutter/material.dart';
import 'package:map_view/map_view.dart';

var apiKey = "AIzaSyA7dpupje0RCB_Rul-gWoXJ2RPmGpj8rdo";

class MapViewDemoPage extends StatefulWidget {
  @override
  _MapViewDemoPageState createState() => new _MapViewDemoPageState();
}

class _MapViewDemoPageState extends State<MapViewDemoPage> {
  MapView mapView = new MapView();
  CameraPosition cameraPosition;
  var staticMapProvider = new StaticMapProvider(apiKey);
  Uri staticMapUri;

  List<Marker> markers = <Marker>[
    new Marker("1", "BSR Restuarant", 28.421364, 77.333804,
        color: Colors.amber),
    new Marker("2", "Flutter Institute", 28.418684, 77.340417,
        color: Colors.purple),
  ];

  showMap() {
    mapView.show(new MapOptions(
        mapViewType: MapViewType.normal,
        initialCameraPosition:
            new CameraPosition(new Location(28.420035, 77.337628), 15.0),
        showUserLocation: true,
        title: "Recent Location"));
    mapView.setMarkers(markers);
    mapView.zoomToFit(padding: 100);

    mapView.onMapTapped.listen((_) {
      setState(() {
        mapView.setMarkers(markers);
        mapView.zoomToFit(padding: 100);
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    MapView.setApiKey(apiKey);
    cameraPosition =
        new CameraPosition(new Location(28.420035, 77.337628), 2.0);
    staticMapUri = staticMapProvider.getStaticUri(
        new Location(28.420035, 77.337628), 12,
        height: 400, width: 900, mapType: StaticMapViewType.roadmap);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("Flutter Google maps"),
      ),
      body: new Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          new Container(
            height: 300.0,
            child: new Stack(
              children: <Widget>[
                new Center(
                  child: Container(
                    child: new Text(
                      "Map should show here",
                      textAlign: TextAlign.center,
                    ),
                    padding: const EdgeInsets.all(20.0),
                  ),
                ),
                new InkWell(
                  child: new Center(
                    child: new Image.network(staticMapUri.toString()),
                  ),
                  onTap: showMap,
                )
              ],
            ),
          ),
          new Container(
            padding: new EdgeInsets.only(top: 10.0),
            child: new Text(
              "Tap the map to interact",
              style: new TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          new Container(
            padding: new EdgeInsets.only(top: 25.0),
            child: new Text(
                "Camera Position: \n\nLat: ${cameraPosition.center.latitude}\n\nLng:${cameraPosition.center.longitude}\n\nZoom: ${cameraPosition.zoom}"),
          ),
        ],
      ),
    );
  }
}