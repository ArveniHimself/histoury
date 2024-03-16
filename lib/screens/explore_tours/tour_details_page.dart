import 'package:flutter/material.dart';
import 'package:histoury/screens/map_page/map_with_spots.dart';
import 'package:histoury/screens/map_page/qr_scan_page.dart';
import 'package:histoury/shared/models/tour.dart';
import 'package:provider/provider.dart';

import '../../state_management.dart/tour_change_notifier.dart';

class TourDetailsPage extends StatelessWidget {
  final Tour detailedTour;

  const TourDetailsPage({Key? key, required this.detailedTour}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          detailedTour.name,
          style: const TextStyle(color: Colors.white),
        ),
        // actions: [
        //   ElevatedButton(
        //     style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
        //     onPressed: () async {
        //       String? scannedCode = await Navigator.push(
        //         context,
        //         MaterialPageRoute(builder: (context) => const QRScanPage()),
        //       );

        //       if (scannedCode != null) {
        //         // Hier Logik zum Überprüfen des gescannten Codes und zum Aktualisieren der App
        //         // Beispiel: tourProvider.updateInterestingSpotStatus(...);
        //       }
        //     },
        //     child: const Text('Scan QR-Code'),
        //   )
        // ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          Card(
            elevation: 4.0,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Beschreibung: ${detailedTour.name}",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    detailedTour.description,
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    'Dauer: ${detailedTour.duration.inHours} Stunden ${detailedTour.duration.inMinutes.remainder(60)} Minuten',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    'Länge: ${detailedTour.lengthInKm.toStringAsFixed(2)} km',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    'Beendet: ${checkTourFinished(detailedTour.finished)}',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 15),
          Card(
            elevation: 4.0,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Interessante Sehenswürdigkeiten',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  for (var spot in detailedTour.spots)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: ListTile(
                        leading: SizedBox(
                          width: 90,
                          height: 90,
                          child: Image.asset(spot.localImagePath),
                        ),
                        title: Text(spot.name),
                      ),
                    ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: ElevatedButton(
              onPressed: () {
                final tourProvider = Provider.of<TourProvider>(context, listen: false);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChangeNotifierProvider.value(
                      value: tourProvider,
                      child: MapWithSpots(detailedTour: detailedTour),
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo, // Hintergrund
                foregroundColor: Colors.white, // Vordergrund
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Text("Tour starten", style: TextStyle(fontSize: 18)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

String checkTourFinished(bool val) {
  return val ? "Ja" : "Nein";
}
