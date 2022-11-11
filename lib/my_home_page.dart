import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:geolocator/geolocator.dart';
import 'package:dio/dio.dart';

String baseUrl = 'https://api.mapbox.com/directions/v5/mapbox';
String accessToken =
    "pk.eyJ1IjoiZGl2eWFrZWthZGUiLCJhIjoiY2w5dHhqdXV1MGloZjNvbXlyd3Zzc3N3eiJ9.mmZ_tvvhibvDR2ZCPV6fHg";
String navType = 'cycling';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;
  // Position position;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late MapboxMapController controller;

  String buttonTextRoute = "Get d";

  _onMapCreated(MapboxMapController controller) async {
    this.controller = controller;
  }

  Future getRoute(LatLng source, LatLng destination) async {
    String url =
        '$baseUrl/$navType/${source.longitude},${source.latitude};${destination.longitude},${destination.latitude}?alternatives=true&continue_straight=true&geometries=geojson&language=en&overview=full&steps=true&access_token=$accessToken';
    Dio dio = Dio();
    try {
      dio.options.contentType = Headers.jsonContentType;
      final responseData = await dio.get(url);
      return responseData.data;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<Map> formatedData(
      double srclat, double srclng, double destlat, double destlng) async {
    var response =
    await getRoute(LatLng(srclat, srclng), LatLng(destlat, destlng));

    Map geometry = response['routes'][0]['geometry'];
    num duration = response['routes'][0]['duration'];
    num distance = response['routes'][0]['distance'];
    // print(geometry);
    // print(duration);
    // print(distance);
    Map directionData = {
      "geometry": geometry,
      "duration": duration,
      "distance": distance,
    };
//-------------------drawing route--------------

    final fills = {
      "type": "FeatureCollection",
      "features": [
        {
          "type": "Feature",
          "id": 0,
          "properties": <String, dynamic>{},
          "geometry": geometry,
        },
      ],
    };

    await controller.addSource("fills", GeojsonSourceProperties(data: fills));
    await controller.addLineLayer(
      "fills",
      "lines",
      LineLayerProperties(
        lineColor: Colors.indigo.toHexStringRGB(),
        lineCap: "round",
        lineJoin: "round",
        lineWidth: 3,
      ),
    );

//--- drawing root end --------------------------

    setState(() {
      buttonTextRoute = "duration = $duration";
    });
    return directionData;
  }

  void drawRoute() async {
    await formatedData(
        16.8455475, 74.6021831, 16.84348775296008, 74.60332862799596);
  }

  //----------------------------
  var buttontext = "Get Current Location";
  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return Future.error('Location services are disabled');
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        return Future.error("Location permission denied");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied');
    }

    Position position = await Geolocator.getCurrentPosition();

    return position;
  }

  void showLocation() async {
    Position position = await determinePosition();
    // print(position);
    // print(position.longitude);
    double long = position.longitude;
    double lat = position.latitude;

    setState(() {
      buttontext = "longitude = $long lattitude= $lat";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Collage Map'),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.8,
              child: MapboxMap(
                styleString:
                "mapbox://styles/divyakekade/cla4ujlh6008b14nuk3uu53lr",
                accessToken:
                "pk.eyJ1IjoiZGl2eWFrZWthZGUiLCJhIjoiY2w5dHhqdXV1MGloZjNvbXlyd3Zzc3N3eiJ9.mmZ_tvvhibvDR2ZCPV6fHg",
                initialCameraPosition: const CameraPosition(
                    target: LatLng(16.8457, 74.6015), zoom: 10),
                minMaxZoomPreference: const MinMaxZoomPreference(14, 17),
                myLocationEnabled: true,
                myLocationTrackingMode: MyLocationTrackingMode.TrackingGPS,
                onMapCreated: _onMapCreated,
              ),
            ),
            ElevatedButton(onPressed: drawRoute, child: Text(buttonTextRoute)),
            // ElevatedButton(
            //     onPressed: () => Navigator.push(context,
            //         MaterialPageRoute(builder: (_) => const TurnByTurn())),
            //     style:
            //         ElevatedButton.styleFrom(padding: const EdgeInsets.all(20)),
            //     child: Row(
            //         mainAxisAlignment: MainAxisAlignment.center,
            //         children: const [
            //           Text('Start your premier ride now'),
            //         ]))
            // const TurnByTurn()

          ],
        ),
      ),
    );
  }
}
