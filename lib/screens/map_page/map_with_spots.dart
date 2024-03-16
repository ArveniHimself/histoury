import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:histoury/screens/map_page/spot_quiz_sheet.dart';
import 'package:provider/provider.dart';

import '../../state_management.dart/tour_change_notifier.dart';
import '../../shared/models/tour.dart';

class MapWithSpots extends StatefulWidget {
  final Tour detailedTour;

  const MapWithSpots({super.key, required this.detailedTour});

  @override
  State<MapWithSpots> createState() => _MapWithSpotsState();
}

class _MapWithSpotsState extends State<MapWithSpots> {
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();
  final Set<Marker> _googleMapsMarkers = {};

  num notify = 0; //0 - neutral, 1 - right answer, -1 wrong answer
  void _createMarkers() {
    _googleMapsMarkers.clear();
    for (var spot in widget.detailedTour.spots) {
      _googleMapsMarkers.add(
        Marker(
          markerId: MarkerId(spot.name),
          onTap: () {
            final tourProvider = Provider.of<TourProvider>(context, listen: false);

            showModalBottomSheet(
                context: context,
                builder: (BuildContext bc) {
                  return ChangeNotifierProvider.value(
                    value: tourProvider,
                    child: SpotQuizSheet(
                      spot: spot,
                      tour: widget.detailedTour,
                    ),
                  );
                });
          },
          position: LatLng(spot.latitude, spot.longitude),
          infoWindow: InfoWindow(
            title: spot.name,
            snippet: spot.description,
          ),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _createMarkers();
  }

  @override
  Widget build(BuildContext context) {
    int tourIndex = widget.detailedTour.name == "Dortmund Tour" ? 0 : 1;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Sehenswürdigkeiten der ${widget.detailedTour.name}",
          style: const TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            markers: _googleMapsMarkers,
            initialCameraPosition: CameraPosition(
              target: widget.detailedTour.tourLocation,
              zoom: 11.5,
            ),
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
          Positioned(
            right: 20,
            top: 20,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.indigo, width: 2),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                    "Tour beendet: ${checkTourFinished(Provider.of<TourProvider>(context).tours[tourIndex].finished)}"),
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
