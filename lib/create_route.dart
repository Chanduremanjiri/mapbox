import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:geolocator/geolocator.dart';

String baseUrl = 'https://api.mapbox.com/directions/v5/mapbox';
String accessToken =
    "pk.eyJ1IjoiZGl2eWFrZWthZGUiLCJhIjoiY2w5dHhqdXV1MGloZjNvbXlyd3Zzc3N3eiJ9.mmZ_tvvhibvDR2ZCPV6fHg";
String navType = 'cycling';
Dio dio = Dio();

class RouteCreater extends StatelessWidget {
   RouteCreater({super.key});
  String buttonText = "Get Route";
  Future getRoute(LatLng source, LatLng destination) async {
    String url =
        '$baseUrl/$navType/${source.longitude},${source.latitude};${destination.longitude},${destination.latitude}?alternatives=true&continue_straight=true&geometries=geojson&language=en&overview=full&steps=true&access_token=$accessToken';

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
    print(geometry);
    print(duration);
    print(distance);
    Map directionData = {
      "geometry": geometry,
      "duration": duration,
      "distance": distance,
    };
    return directionData;
  }

  void drawRoute() async {
    await formatedData(
        16.8455475, 74.6021831, 16.84348775296008, 74.60332862799596);
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: drawRoute, child: const Text("Get Route"));
  }
}
