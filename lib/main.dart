import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
      
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Wce Maps'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  

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
                accessToken:
                    "pk.eyJ1Ijoic2FoaWx0aGFrdXIxMjMiLCJhIjoiY2xhMGU3NHJzMDRyOTNxdWFuaDV1Zmp4YyJ9.rexBI6p_yUx7xOEeGKYR1Q",
                initialCameraPosition: const CameraPosition(target: LatLng(16.8457,74.6015),
                zoom: 10
              ),
              minMaxZoomPreference: const MinMaxZoomPreference(14, 17),

            ),
            )
          ],
        ),
      ),
      
    );
  }
}
