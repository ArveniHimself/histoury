import 'package:flutter/material.dart';
import 'package:histoury/screens/explore_tours/tour_card.dart';
import 'package:histoury/shared/models/tour.dart';
import 'package:histoury/state_management.dart/tour_provider.dart';
import 'package:provider/provider.dart';

class DiscoverTours extends StatefulWidget {
  const DiscoverTours({super.key});

  @override
  State<DiscoverTours> createState() => _DiscoverToursState();
}

class _DiscoverToursState extends State<DiscoverTours> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox.shrink(),
        centerTitle: true,
        title: const Text(
          "Entdecke Touren",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.indigo, // Hintergrundfarbe
              textStyle: const TextStyle(color: Colors.black), // Textfarbe
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            ),
            onPressed: () {
              final tourProvider = Provider.of<TourProvider>(context, listen: false);
              tourProvider.resetTours();
            },
            child: const Text("Clear"),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: Provider.of<TourProvider>(context, listen: false).tours.length,
        itemBuilder: (BuildContext context, int index) {
          // Hole die aktuelle Tour aus der Liste
          // final currentTour = Provider.of<TourProvider>(context, listen: false).tours[index];
          //alle Touren
          final tourProvider = Provider.of<TourProvider>(context, listen: false);

          final currentTour = tourProvider.tours[index];
          // Gib eine TourCard zurück, die die Daten der aktuellen Tour darstellt
          return ChangeNotifierProvider.value(
            value: tourProvider,
            child: TourCard(
              tour: Tour(
                finished: currentTour.finished,
                tourLocation: currentTour.tourLocation,
                name: currentTour.name,
                description: currentTour.description,
                duration: currentTour.duration,
                lengthInKm: currentTour.lengthInKm,
                spots: currentTour.spots,
              ),
            ),
          );
        },
      ),
    );
  }
}
