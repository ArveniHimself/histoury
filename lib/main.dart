import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:histoury/screens/explore_tours/discover_tours.dart';
import 'package:histoury/shared/themes/themes.dart';
import 'package:histoury/state_management.dart/tour_change_notifier.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  runApp(const MyApp());
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // Transparente Statusleiste.
    statusBarIconBrightness:
        Brightness.dark, // Icons der Statusleiste auf dunkel setzen (für helle Hintergründe).
    systemNavigationBarColor: Colors.transparent, // Transparente Navigationsleiste.
    systemNavigationBarIconBrightness:
        Brightness.dark, // Icons der Navigationsleiste auf dunkel setzen (für helle Hintergründe).
  ));
}

//Die "Hülle" in der die App ist.
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: 'UniversityApp',
      debugShowCheckedModeBanner: false,
      theme: HistouryTheme.light,
      home: const StartScreen(),
    );
  }
}

//First screen to appear for the user
class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const SizedBox(
            height: 200,
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Histoury",
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: Colors.indigo, // background
                  foregroundColor: Colors.white, // foreground
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChangeNotifierProvider(
                        create: (context) => TourProvider(),
                        builder: (context, child) {
                          return const DiscoverTours();
                        },
                      ),
                    ),
                  );
                },
                child: const Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "Start",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 150,
          )
        ],
      ),
    );
  }
}
