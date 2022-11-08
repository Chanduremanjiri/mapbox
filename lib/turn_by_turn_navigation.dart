import 'package:flutter_mapbox_navigation/library.dart';
import 'package:flutter/material.dart';
class TurnByTurn extends StatefulWidget {
  const TurnByTurn({super.key});

  @override
  State<StatefulWidget> createState() {
    return TurnByTurnState();
  }
}

class TurnByTurnState extends State<TurnByTurn>{
  double srclat = 16.8455475;
  double srclong = 74.6021831;
  double destlat = 16.84348775296008;
  double destlong = 74.60332862799596;
  late WayPoint sourceWaypoint, destinationWaypoint;
  var wayPoints = <WayPoint>[];

  // Config variables for Mapbox Navigation
  late MapBoxNavigation directions;
  late MapBoxOptions _options;
  late double distanceRemaining, durationRemaining;
  late MapBoxNavigationViewController _controller;
  final bool isMultipleStop = false;
  String instruction = "";
  bool arrived = false;
  bool routeBuilt = false;
  bool isNavigating = false;
  // TurnByTurnState(this.srclat, this.srclong, this.destlat, this.destlong);


  Future<void> initialize() async {
    if (!mounted) return;

    // Setup directions and options
    directions = MapBoxNavigation(onRouteEvent: _onRouteEvent);
    _options = MapBoxOptions(
        zoom: 18.0,
        voiceInstructionsEnabled: true,
        bannerInstructionsEnabled: true,
        mode: MapBoxNavigationMode.drivingWithTraffic,
        isOptimized: true,
        units: VoiceUnits.metric,
        simulateRoute: true,
        language: "en");

    // Configure waypoints
    sourceWaypoint = WayPoint(
        name: "Source", latitude: srclat, longitude: srclong);
    destinationWaypoint = WayPoint(
        name: "Destination",
        latitude: srclat,
        longitude: srclong);
    wayPoints.add(sourceWaypoint);
    wayPoints.add(destinationWaypoint);

    // Start the trip
    await directions.startNavigation(wayPoints: wayPoints, options: _options);
  }
//----
  Future<void> _onRouteEvent(e) async {
    distanceRemaining = await directions.distanceRemaining;
    durationRemaining = await directions.durationRemaining;

    switch (e.eventType) {
      case MapBoxEvent.progress_change:
        var progressEvent = e.data as RouteProgressEvent;
        arrived = progressEvent.arrived!;
        if (progressEvent.currentStepInstruction != null) {
          instruction = progressEvent.currentStepInstruction!;
        }
        break;
      case MapBoxEvent.route_building:
      case MapBoxEvent.route_built:
        routeBuilt = true;
        break;
      case MapBoxEvent.route_build_failed:
        routeBuilt = false;
        break;
      case MapBoxEvent.navigation_running:
        isNavigating = true;
        break;
      case MapBoxEvent.on_arrival:
        arrived = true;
        if (!isMultipleStop) {
          await Future.delayed(const Duration(seconds: 3));
          await _controller.finishNavigation();
        } else {}
        break;
      case MapBoxEvent.navigation_finished:
      case MapBoxEvent.navigation_cancelled:
        routeBuilt = false;
        isNavigating = false;
        break;
      default:
        break;
    }
    //refresh UI
    setState(() {});
  }
  //-------------------------
  @override
  Widget build(BuildContext context) {
    return const ElevatedButton(onPressed: null, child: Text("Navigate"));
  }
}
