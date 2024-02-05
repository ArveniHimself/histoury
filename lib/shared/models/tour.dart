import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'interesting_spot.dart';

class Tour {
  final String name;
  final LatLng tourLocation;
  final String description;
  final Duration duration; // Dauer der Tour
  final double lengthInKm; // Länge der Tour in Kilometern
  final List<InterestingSpot> spots; // Liste der interessanten Orte
  bool finished;

  Tour({
    required this.name,
    required this.finished,
    required this.tourLocation,
    required this.description,
    required this.duration,
    required this.lengthInKm,
    required this.spots,
  });
}
