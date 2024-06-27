import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:histoury/shared/models/interesting_spot.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../shared/models/tour.dart';

// TourProvider verwaltet die Daten und den Zustand der Touren und interessanten Orte (InterestingSpots).
class TourProvider extends ChangeNotifier {
  // Liste der interessanten Orte in Dortmund.
  late final List<InterestingSpot> _dortmundSpots = [
    InterestingSpot(
      name: 'Deutsches Fußballmuseum',
      description: 'Museum über die Geschichte des deutschen Fußballs.',
      latitude: 51.5154,
      longitude: 7.4653,
      localImagePath: "assets/DeutschesFussballmuseum.jpg",
      question: "Wann wurde das Deutsche Fußballmuseum eröffnet?",
      answerOptions: ["2013", "2015", "2017", "2019"],
      answerChecker: [false, true, false, false],
      finished: false,
    ),
    InterestingSpot(
      name: 'Westfalenpark Dortmund',
      description: 'Ein großer Park mit Veranstaltungen und Attraktionen.',
      latitude: 51.4902,
      longitude: 7.4937,
      localImagePath: "assets/Westfalenpark.jpg",
      question: "Welches berühmte Bauwerk befindet sich im Westfalenpark?",
      answerOptions: ["Florianturm", "Kölner Dom", "Berliner Fernsehturm", "Münchner Olympiaturm"],
      answerChecker: [true, false, false, false],
      finished: false,
    ),
    InterestingSpot(
      name: 'Signal Iduna Park',
      description: 'Heimatstadion von Borussia Dortmund.',
      latitude: 51.4927,
      longitude: 7.4518,
      localImagePath: "assets/SignalIdunaPark.jpg",
      question: "Für welchen Fußballverein ist der Signal Iduna Park das Heimstadion?",
      answerOptions: ["FC Schalke 04", "Borussia Dortmund", "Bayern München", "Bayer Leverkusen"],
      answerChecker: [false, true, false, false, false],
      finished: false,
    ),
    InterestingSpot(
      name: 'Phönixsee',
      description: 'Ein künstlicher See, beliebt für Spaziergänge und Wassersport.',
      latitude: 51.4793,
      longitude: 7.5122,
      localImagePath: "assets/Phoenixsee.jpg",
      question: "Was war der Phönixsee ursprünglich?",
      answerOptions: ["Ein Bergwerk", "Ein Natursee", "Ein Freizeitpark", "Ein Flughafen"],
      answerChecker: [true, false, false, false],
      finished: false,
    ),
  ];

  late final List<InterestingSpot> _koelnSpots = [
    InterestingSpot(
      name: 'Kölner Dom',
      description: 'Ein berühmtes gotisches Wahrzeichen und Kathedrale Kölns.',
      latitude: 50.9413,
      longitude: 6.9583,
      localImagePath: "assets/KoelnerDom.jpg",
      question: "Wann wurde mit dem Bau des Kölner Doms begonnen?",
      answerOptions: ["1248", "1322", "1456", "1500"],
      answerChecker: [true, false, false, false],
      finished: false,
    ),
    InterestingSpot(
      name: 'Rheinpark',
      description: 'Ein großer, landschaftlich gestalteter Park am Rhein.',
      latitude: 50.9454,
      longitude: 6.9734,
      localImagePath: "assets/Rheinpark.jpg",
      question: "Welche Veranstaltung findet jährlich im Rheinpark statt?",
      answerOptions: ["Kölner Lichter", "Kölner Karneval", "Cologne Pride", "Christmas Market"],
      answerChecker: [true, false, false, false],
      finished: false,
    ),
    InterestingSpot(
      name: 'Schokoladenmuseum Köln',
      description: 'Ein Museum, das sich der Geschichte und Herstellung von Schokolade widmet.',
      latitude: 50.9326,
      longitude: 6.9645,
      localImagePath: "assets/Schokoladenmuseum.jpg",
      question: "Wann wurde das Schokoladenmuseum in Köln eröffnet?",
      answerOptions: ["1993", "1998", "2001", "2005"],
      answerChecker: [true, false, false, false],
      finished: false,
    ),
    InterestingSpot(
      name: 'RheinEnergieStadion',
      description: 'Das Heimatstadion des 1. FC Köln und Veranstaltungsort für diverse Events.',
      latitude: 50.9333,
      longitude: 6.8750,
      localImagePath: "assets/RheinEnergieStadion.jpg",
      question: "Wie viele Zuschauer fasst das RheinEnergieStadion?",
      answerOptions: ["40.000", "50.000", "60.000", "70.000"],
      answerChecker: [false, true, false, false],
      finished: false,
    ),
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

  //Konstruktor
  TourProvider() {
    loadProgress().then(
      (_) => notifyListeners(),
    );
  }

  // Diese Methode setzt alle Touren und ihre Spots zurück
  Future<void> resetTours() async {
    final prefs = await SharedPreferences.getInstance();
    for (var tour in _tours) {
      // Setze den Fortschritt jedes interessanten Ortes in der Tour zurück
      for (var spot in tour.spots) {
        spot.finished = false; // Setzt den Fortschrittsstatus zurück
        // Optional: Entferne den Fortschritt aus den SharedPreferences
        String key = "tour_${tour.name}_spot_${spot.name}";
        await prefs.remove(key);
      }
      // Optional: Setze den Tour-Fortschrittsstatus zurück
      tour.finished = false;
    }
    // Informiere die UI über die Änderung
    notifyListeners();
  }

  //Laden des Fortschritts einer Tour
  Future<void> loadProgress() async {
    final prefs = await SharedPreferences.getInstance();
    for (var tour in _tours) {
      bool allSpotsFinished = true; // Starte mit der Annahme, dass alle Spots fertig sind
      for (var spot in tour.spots) {
        String key = "tour_${tour.name}_spot_${spot.name}";
        bool finished = prefs.getBool(key) ?? false;
        spot.finished = finished;
        if (!finished) {
          allSpotsFinished =
              false; // Wenn ein Spot nicht fertig ist, setze allSpotsFinished auf false
        }
      }
      // Setze den finished-Status der Tour basierend auf allSpotsFinished
      tour.finished = allSpotsFinished;
    }
    notifyListeners(); // Benachrichtige Listener nach dem Laden des Fortschritts
  }

  //Speichern des Fortschritts einer Tour
  Future<void> saveProgress(int tourIndex, String currentSpotName, bool isFinished) async {
    final prefs = await SharedPreferences.getInstance();
    String key = "tour_${_tours[tourIndex].name}_spot_$currentSpotName";
    await prefs.setBool(key, isFinished);
  }

  //Besuch eines Ortes speichern
  Future<void> saveVisit(int tourIndex, String currentSpotName) async {
    final prefs = await SharedPreferences.getInstance();
    String key = "tour_${_tours[tourIndex].name}_spot_${currentSpotName}_visited";
    await prefs.setBool(key, true);
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
    debugPrint("[NOTIFY]: Save progress of Tour");
    saveProgress(tourIndex, currentSpotName, isFinished)
        .then((_) => debugPrint("[NOTIFY]: Progress saved"));
    debugPrint("[NOTIFY]: Notifiying listeners");
    notifyListeners();
  }
}
