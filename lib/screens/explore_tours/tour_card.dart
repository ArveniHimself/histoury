import 'package:flutter/material.dart';
import 'package:histoury/state_management.dart/tour_change_notifier.dart';
import 'package:histoury/shared/models/tour.dart';
import 'package:histoury/screens/explore_tours/tour_details_page.dart';
import 'package:provider/provider.dart';

class TourCard extends StatefulWidget {
  final Tour tour;

  const TourCard({Key? key, required this.tour}) : super(key: key);

  @override
  State<TourCard> createState() => _TourCardState();
}

class _TourCardState extends State<TourCard> {
  @override
  Widget build(BuildContext context) {
    int tourIndex = widget.tour.name == "Dortmund Tour" ? 0 : 1;

    return GestureDetector(
      onTap: () {
        final tourProvider = Provider.of<TourProvider>(context, listen: false);

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return ChangeNotifierProvider.value(
              value: tourProvider,
              child: TourDetailsPage(detailedTour: widget.tour),
            );
          }),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            // Untere rechte Ecke abgerundet
          ),
          color: Colors.white,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  widget.tour.name,
                  style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      'Distanz: ${widget.tour.lengthInKm.toStringAsFixed(0)} km',
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      'Die Tour enthält: ${widget.tour.spots.length} interessante Spots',
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      "Dauer: ${widget.tour.duration.inHours.toString().padLeft(2, '0')}:${(widget.tour.duration.inMinutes % 60).toString().padLeft(2, '0')} Stunden",
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                            "Tour finished: ${Provider.of<TourProvider>(context).tours[tourIndex].finished.toString().toUpperCase()}")
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
