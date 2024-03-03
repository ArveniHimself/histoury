import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:histoury/shared/models/interesting_spot.dart';

import '../shared/models/tour.dart';

// TourProvider verwaltet die Daten und den Zustand der Touren und interessanten Orte (InterestingSpots).
class TourProvider extends ChangeNotifier {
  // Liste der interessanten Orte in Dortmund.
  late final List<InterestingSpot> _dortmundSpots = [
    // Definiert einen interessanten Ort mit Namen, Beschreibung, Koordinaten, Pfad zu lokalen und Online-Bildern, einer Frage mit Antwortmöglichkeiten und einem Status, ob der Ort als besucht markiert wurde.
    InterestingSpot(
      name: 'Deutsches Fußballmuseum',
      description: 'Museum über die Geschichte des deutschen Fußballs.',
      latitude: 51.5154,
      longitude: 7.4653,
      localImagePath: "assets/images/DeutschesFußballmuseum.jpg",
      onlineImageUrl:
          "https://m.spox.com/de/sport/fussball/1805/Bilder/deutsches-fussballmuseum-600.jpg",
      question: "Wann wurde das Deutsche Fußballmuseum eröffnet?",
      answerOptions: ["2013", "2015", "2017", "2019"],
      answerChecker: [false, true, false, false],
      finished: false,
    ),
    // Weitere InterestingSpot-Instanzen folgen hier...
  ];

  // Liste der interessanten Orte in Köln.
  late final List<InterestingSpot> _koelnSpots = [
    // Definiert einen interessanten Ort mit Namen, Beschreibung, Koordinaten, Pfad zu lokalen und Online-Bildern, einer Frage mit Antwortmöglichkeiten und einem Status, ob der Ort als besucht markiert wurde.
    InterestingSpot(
      name: 'Kölner Dom',
      description: 'Ein berühmtes gotisches Wahrzeichen und Kathedrale Kölns.',
      latitude: 50.9413,
      longitude: 6.9583,
      localImagePath: "assets/images/KoelnerDom.jpg",
      onlineImageUrl:
          "https://img.ecmaps.de/remote/.jpg?url=https%3A%2F%2Fdam.destination.one%2F173310%2Fa164ccdb16477a3e603eec59c03627fdceb8528eb2c37005bde78f5d8fe4f23d%2Fkoelner-dom-koelntourismus-gmbh-axel-schulten.jpg",
      question: "Wann wurde mit dem Bau des Kölner Doms begonnen?",
      answerOptions: ["1248", "1322", "1456", "1500"],
      answerChecker: [true, false, false, false],
      finished: false,
    ),
    // Weitere InterestingSpot-Instanzen für Köln folgen hier...
  ];

  // Definiert eine Beispiel-Tour durch Dortmund, inklusive Namen, Beschreibung, Dauer, Länge, Liste der interessanten Orte und einem Status, ob die Tour abgeschlossen wurde.
  late final Tour sampleDortmundTour = Tour(
    name: 'Dortmund Tour',
    tourLocation: const LatLng(51.514244, 7.466449),
    description:
        "Erkunden Sie Dortmund, das Herz des Ruhrgebiets und eine Stadt, die Industriegeschichte mit modernem Leben verbindet. Besichtigen Sie das Deutsche Fußballmuseum und tauchen Sie ein in die leidenschaftliche Welt des deutschen Fußballs. Genießen Sie einen Spaziergang rund um den Phönixsee, einem der beliebtesten Erholungsgebiete der Stadt. Lassen Sie sich von der elektrisierenden Atmosphäre im Signal Iduna Park mitreißen, der Heimat von Borussia Dortmund.",
    duration: const Duration(hours: 4),
    lengthInKm: 20.0,
    spots: _dortmundSpots,
    finished: false,
  );

  // Definiert eine Beispiel-Tour durch Köln, inklusive Namen, Beschreibung, Dauer, Länge, Liste der interessanten Orte und einem Status, ob die Tour abgeschlossen wurde.
  late final Tour sampleKoelnTour = Tour(
    name: 'Köln Tour',
    tourLocation: const LatLng(50.9413, 6.9583),
    description:
        "Entdecken Sie das historische Herz von Köln, einer Stadt, die reich an Kultur und Geschichte ist. Bestaunen Sie den beeindruckenden Kölner Dom, ein Meisterwerk gotischer Architektur und ein UNESCO-Weltkulturerbe. Flanieren Sie entlang des Rheins und erleben Sie die lebendige Atmosphäre der Altstadt mit ihren zahlreichen Brauhäusern und Kneipen. Tauchen Sie in das pulsierende kulturelle Leben der Stadt ein, von den römischen Ruinen bis zu den modernen Kunstgalerien.",
    duration: const Duration(hours: 3),
    lengthInKm: 15.0,
    spots: _koelnSpots,
    finished: false,
  );

  // Liste der verfügbaren Touren.
  late List<Tour> _tours = [sampleDortmundTour, sampleKoelnTour];

  // Getter, um die Liste der Touren abzurufen.
  List<Tour> get tours => _tours;

  // Setter, um die Liste der Touren zu aktualisieren und Benachrichtigungen an die UI zu senden.
  set tours(List<Tour> tours) {
    _tours = tours;
    notifyListeners();
  }

  // Aktualisiert den Status eines interessanten Ortes innerhalb einer Tour und sendet eine Benachrichtigung an die UI.
  updateInterestingSpotStatus(int tourIndex, String currentSpotName, bool isFinished) {
    debugPrint(
        "[NOTIFY]: Entered Update. TI[$tourIndex], SI[$currentSpotName], IF[${isFinished.toString()}]");

    // Index des Spots innerhalb der Tour finden.
    int spotIndex = _tours[tourIndex].spots.indexWhere((spot) => spot.name == currentSpotName);

    // Status des interessanten Ortes auf abgeschlossen setzen, wenn die zugehörige Frage richtig beantwortet wurde.
    _tours[tourIndex].spots[spotIndex].finished = isFinished;
    debugPrint("[NOTIFY]: ${_tours[tourIndex].spots[spotIndex].question}");

    // Überprüfen, ob alle Orte der Tour besucht wurden, und entsprechend den Status der Tour aktualisieren.
    _tours[tourIndex].finished = true;
    for (var spot in _tours[tourIndex].spots) {
      if (!spot.finished) {
        debugPrint("[NOTIFY]: Spot ${spot.name} NOT finished");
        _tours[tourIndex].finished = false;
      } else {
        debugPrint("[NOTIFY]: Spot ${spot.name} finished");
      }
    }
    debugPrint("[NOTIFY]: Whole tour finished? ${_tours[tourIndex].finished.toString()}");
    debugPrint("[NOTIFY]: ---------------------------------------");
    notifyListeners();
  }
}
