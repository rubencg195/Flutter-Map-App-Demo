import 'package:flutter/material.dart';
//import 'package:map_demo/MapViewDemo.dart';
//import 'package:map_view/map_view.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';
import 'package:charts_flutter/flutter.dart' as charts;
 import 'package:fcharts/fcharts.dart';

var apiKey = "AIzaSyA7dpupje0RCB_Rul-gWoXJ2RPmGpj8rdo";
void main() {
  //MapView.setApiKey(apiKey);

  runApp(new App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Flutter App',
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  HomeState createState() {
    return new HomeState();
  }
}

class HomeState extends State<Home> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    new FlutterMapPage(),
    new ChartPage(),
    Center(
      child: ListView(
        children: list,
      ),
    )
    //PlaceholderWidget(Colors.green)
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      //home: new MapViewDemoPage(),
      home: new Scaffold(
          appBar: new AppBar(
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: new Image.network(
                  "http://internetoftrees.io/assets/img/Internet.png"),
            ),
            backgroundColor: Colors.white,
            actions: <Widget>[
              //new IconButton(icon: new Icon(Icons.menu), onPressed: null),
              new DropdownButton(
              items: ['Profile', 'About us', 'Settings', 'Logout'].map((String val){
                return DropdownMenuItem<String>(
                  value: val,
                  child: new Text(val),
                );
              }).toList(),
              hint:Text("Menu"),
              onChanged:null
              )
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            fixedColor: Colors.green,
            onTap: onTabTapped, // new
            currentIndex: _currentIndex, // new
            items: [
              new BottomNavigationBarItem(
                icon: Icon(Icons.home),
                title: Text('Home'),
              ),
              new BottomNavigationBarItem(
                icon: Icon(Icons.insert_chart),
                title: Text('Dashboard'),
              ),
              new BottomNavigationBarItem(
                  icon: Icon(Icons.mail), title: Text('Messages'))
            ],
          ),
          body: _children[_currentIndex]),
    );
  }
}

class FlutterMapPage extends StatefulWidget {
  @override
  _FlutterMapPageState createState() => _FlutterMapPageState();
}

class _FlutterMapPageState extends State<FlutterMapPage> {
  @override
  Widget build(BuildContext context) {
    return new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Expanded(
            child: new FlutterMap(
                options: new MapOptions(
                  center: new LatLng(51.5, -0.09),
                  zoom: 13.0,
                ),
                layers: [
                  new TileLayerOptions(
                    urlTemplate: "https://api.tiles.mapbox.com/v4/"
                        "{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}",
                    additionalOptions: {
                      'accessToken':
                          'pk.eyJ1IjoicnViZW5jZzE5NSIsImEiOiJjampyZ2dvZmkzeTlpM3Zxc2lheGd3MzZhIn0.cWMbtYM8xz5cv9saJ4crcA',
                      'id': 'mapbox.streets',
                    },
                  ),
                  new MarkerLayerOptions(markers: [
                    new Marker(
                      width: 50.0,
                      height: 50.0,
                      point: new LatLng(51.58, -0.093),
                      builder: (ctx) => new Container(
                            child: new Image.network(
                                "https://cdn.pixabay.com/photo/2014/04/03/10/03/google-309741_640.png"),
                          ),
                    ),
                    new Marker(
                      width: 50.0,
                      height: 50.0,
                      point: new LatLng(51.54, -0.093),
                      builder: (ctx) => new Container(
                            child: new Image.network(
                                "https://cdn.pixabay.com/photo/2014/04/03/10/03/google-309741_640.png"),
                          ),
                    ),
                    new Marker(
                        width: 40.0,
                        height: 40.0,
                        point: new LatLng(51.5, -0.095),
                        builder: (ctx) => new Container(
                              child: new Image.network(
                                  "http://www.myiconfinder.com/uploads/iconsets/256-256-666cadab011445f169d7eec921508aef-fire.png"),
                            ))
                  ])
                ]),
          ),
        ]);
  }
}

class PlaceholderWidget extends StatelessWidget {
  final Color color;

  PlaceholderWidget(this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
    );
  }
}

class ChartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: new Column(
      children: <Widget>[
          new Row(
            children: <Widget>[
              new Expanded(child: new Container()),
              new CircleChart(),
              new Expanded(child: new Container()),
              new CircleChart(),
              new Expanded(child: new Container()),
              new CircleChart(),
              new Expanded(child: new Container())
            ],
          ),
          //new SimpleLineChart()
          new Container(
            padding: EdgeInsets.only(top: 20.0),
            width: double.infinity,
            height: 200.0,
            child: new PointsLineChart.withSampleData()
            ),
          new Container(
            padding: EdgeInsets.only(top: 20.0),
            width: double.infinity,
            height: 200.0,
            child: new SimpleBarChart.withSampleData()
            )
      ],
    ),
        ));
  }
}

class CircleChart extends StatelessWidget {
  final GlobalKey<AnimatedCircularChartState> _chartKey =
      new GlobalKey<AnimatedCircularChartState>();

  final List<CircularStackEntry> data = <CircularStackEntry>[
    new CircularStackEntry(
      <CircularSegmentEntry>[
        new CircularSegmentEntry(500.0, Colors.red[200], rankKey: 'Q1'),
        new CircularSegmentEntry(1000.0, Colors.green[200], rankKey: 'Q2'),
        new CircularSegmentEntry(2000.0, Colors.blue[200], rankKey: 'Q3'),
        new CircularSegmentEntry(1000.0, Colors.yellow[200], rankKey: 'Q4'),
      ],
      rankKey: 'Quarterly Profits',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return new AnimatedCircularChart(
      key: _chartKey,
      size: new Size(100.0, 100.0),
      initialChartData: <CircularStackEntry>[
        new CircularStackEntry(
          <CircularSegmentEntry>[
            new CircularSegmentEntry(
              33.33,
              Colors.green[400],
              rankKey: 'completed',
            ),
            new CircularSegmentEntry(
              66.67,
              Colors.blueGrey[600],
              rankKey: 'remaining',
            ),
          ],
          rankKey: 'progress',
        ),
      ],
      chartType: CircularChartType.Radial,
      percentageValues: true,
      holeLabel: '1/3',
      labelStyle: new TextStyle(
        color: Colors.blueGrey[600],
        fontWeight: FontWeight.bold,
        fontSize: 24.0,
      ),
    );
  }
}

class PointsLineChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  PointsLineChart(this.seriesList, {this.animate});

  /// Creates a [LineChart] with sample data and no transition.
  factory PointsLineChart.withSampleData() {
    return new PointsLineChart(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new charts.LineChart(seriesList,
        animate: animate,
        defaultRenderer: new charts.LineRendererConfig(includePoints: true));
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<LinearSales, int>> _createSampleData() {
    final data = [
      new LinearSales(0, 5),
      new LinearSales(1, 25),
      new LinearSales(2, 100),
      new LinearSales(3, 75),
    ];

    return [
      new charts.Series<LinearSales, int>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }
}

/// Sample linear data type.
class LinearSales {
  final int year;
  final int sales;

  LinearSales(this.year, this.sales);
}


class SimpleBarChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  SimpleBarChart(this.seriesList, {this.animate});

  /// Creates a [BarChart] with sample data and no transition.
  factory SimpleBarChart.withSampleData() {
    return new SimpleBarChart(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
  }


  @override
  Widget build(BuildContext context) {
    return new charts.BarChart(
      seriesList,
      animate: animate,
    );
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<OrdinalSales, String>> _createSampleData() {
    final data = [
      new OrdinalSales('2014', 5),
      new OrdinalSales('2015', 25),
      new OrdinalSales('2016', 100),
      new OrdinalSales('2017', 75),
    ];

    return [
      new charts.Series<OrdinalSales, String>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }
}

/// Sample ordinal data type.
class OrdinalSales {
  final String year;
  final int sales;

  OrdinalSales(this.year, this.sales);
}

List<Widget> list = <Widget>[
  ListTile(
    title: Text('Temperature Rising',
        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0)),
    subtitle: Text('10:10 AM 18/07/2018'),
    leading: Icon(
      Icons.warning,
      color: Colors.yellow[500],
    ),
  ),
  ListTile(
    title: Text('Temperature Rising',
        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0)),
    subtitle: Text('10:10 AM 18/07/2018'),
    leading: Icon(
      Icons.warning,
      color: Colors.yellow[500],
    ),
  ),
  ListTile(
    title: Text('Temperature Critic',
        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0)),
    subtitle: Text('10:10 AM 18/07/2018'),
    leading: Icon(
      Icons.warning,
      color: Colors.red[500],
    ),
  ),
  ListTile(
    title: Text('Temperature Critic',
        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0)),
    subtitle: Text('10:10 AM 18/07/2018'),
    leading: Icon(
      Icons.warning,
      color: Colors.red[500],
    ),
  ),
  ListTile(
    title: Text('Temperature Critic',
        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0)),
    subtitle: Text('10:10 AM 18/07/2018'),
    leading: Icon(
      Icons.warning,
      color: Colors.red[500],
    ),
  ),
  // ...
  // See the rest of the column defined on GitHub:
  // https://raw.githubusercontent.com/flutter/website/master/_includes/code/layout/listview/main.dart
];