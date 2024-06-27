import 'package:flutter/material.dart';
import 'package:histoury/screens/map_page/map_with_spots.dart';
import 'package:histoury/screens/map_page/qr_scan_page.dart';
import 'package:histoury/shared/models/tour.dart';
import 'package:provider/provider.dart';

import '../../state_management.dart/tour_provider.dart';

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
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        actions: [
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              backgroundColor: Colors.transparent,
              side: const BorderSide(color: Colors.transparent),
              textStyle: const TextStyle(color: Colors.white),
              foregroundColor: Colors.white,
            ),
            onPressed: () async {
              String? scannedCode = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const QRScanPage()),
              );

              if (scannedCode != null) {
                Provider.of<TourProvider>(context, listen: false)
                    .saveVisit(detailedTour.name == "Dortmund Tour" ? 0 : 1, scannedCode);
                debugPrint("$scannedCode QR-Code detected");
              }
            },
            child: const Text('Scan Code'),
          )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            elevation: 1,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Tourbeschreibung",
                    style: TextStyle(
                        fontSize: 20,
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
                    'Quizze beendet: ${checkTourFinished(Provider.of<TourProvider>(context).tours.firstWhere((element) => element.name == detailedTour.name).finished)}',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            elevation: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Sehenswürdigkeit | Besuchtstatus',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15),
                  for (var spot in detailedTour.spots)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        children: [
                          SizedBox(
                            height: 55,
                            width: 95,
                            child: Image.asset(
                              spot.localImagePath,
                              fit: BoxFit.fill,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(spot.name),
                          const Spacer(),
                          Text(
                              " |  ${besuchtStatus(Provider.of<TourProvider>(context).tours.firstWhere((element) => element.name == detailedTour.name).spots.firstWhere((element) => element.name == spot.name).visited)}"),
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            child: SizedBox(
              height: 55,
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
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Text("Tour starten", style: TextStyle(fontSize: 18)),
                ),
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

String besuchtStatus(bool vis) {
  return vis ? "Besucht" : "Unbesucht";
}
