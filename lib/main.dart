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
                styleString: "mapbox://styles/divyakekade/cla4ujlh6008b14nuk3uu53lr",
                accessToken:
                    "pk.eyJ1IjoiZGl2eWFrZWthZGUiLCJhIjoiY2w5dHhqdXV1MGloZjNvbXlyd3Zzc3N3eiJ9.mmZ_tvvhibvDR2ZCPV6fHg",
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
