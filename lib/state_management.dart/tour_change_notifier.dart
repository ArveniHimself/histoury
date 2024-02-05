import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:histoury/shared/models/interesting_spot.dart';

import '../shared/models/tour.dart';

class TourProvider extends ChangeNotifier {
  late final List<InterestingSpot> _dortmundSpots = [
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
    InterestingSpot(
      name: 'Westfalenpark Dortmund',
      description: 'Ein großer Park mit Veranstaltungen und Attraktionen.',
      latitude: 51.4902,
      longitude: 7.4937,
      localImagePath: "assets/images/Westfalenpark.jpg",
      onlineImageUrl:
          "https://www.bergbahnen.org/gallery/albums/deutschland/dortmund/dortmund033.jpg",
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
      localImagePath: "assets/images/SignalIdunaPark.jpg",
      onlineImageUrl:
          "https://i0.wp.com/tfcstadiums.com/wp-content/uploads/2022/02/signal-iduna-park-aerial-night-ucl-2.jpg?fit=1376%2C868&ssl=1",
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
      localImagePath: "assets/images/Phoenixsee.jpg",
      onlineImageUrl:
          "https://www.wikinger-reisen.de/bilder/reiseseiten/phoenix-see-in-dortmund-head43ep-t.webp",
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
      localImagePath: "assets/images/KoelnerDom.jpg",
      onlineImageUrl:
          "https://img.ecmaps.de/remote/.jpg?url=https%3A%2F%2Fdam.destination.one%2F173310%2Fa164ccdb16477a3e603eec59c03627fdceb8528eb2c37005bde78f5d8fe4f23d%2Fkoelner-dom-koelntourismus-gmbh-axel-schulten.jpg&scale=both&mode=crop&quality=90&width=1356&height=1920",
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
      localImagePath: "assets/images/Rheinpark.jpg",
      onlineImageUrl:
          "https://img.ecmaps.de/remote/.jpg?url=https%3A%2F%2Fdam.destination.one%2F173408%2F2d270bb45aecbe9830b80949639ef10cf7bfa185dda8b9bd9b9b10d8dfd7136f%2Fkoelner-rheinpark-koelntourismus-gmbh-dieter-jacobi_3.jpg&scale=both&mode=crop&quality=90&width=2500&height=1667",
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
      localImagePath: "assets/images/Schokoladenmuseum.jpg",
      onlineImageUrl:
          "https://www.citynews-koeln.de/wp-content/uploads/2020/05/schokoladenmuseum-2020.jpg",
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
      localImagePath: "assets/images/RheinEnergieStadion.jpg",
      onlineImageUrl: "https://www.koeln.de/files/koeln/locations/stadion_westtribuene_03_565.jpg",
      question: "Wie viele Zuschauer fasst das RheinEnergieStadion?",
      answerOptions: ["40.000", "50.000", "60.000", "70.000"],
      answerChecker: [false, true, false, false],
      finished: false,
    ),
  ];

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

  late List<Tour> _tours = [sampleDortmundTour, sampleKoelnTour];

  List<Tour> get tours => _tours;

  set tours(List<Tour> tours) {
    _tours = tours;
    notifyListeners();
  }

  updateInterestingSpotStatus(int tourIndex, String currentSpotName, bool isFinished) {
    debugPrint(
        "[NOTIFY]: Entered Update. TI[$tourIndex], SI[$currentSpotName], IF[${isFinished.toString()}]");

    // Index des Spots herausfinden
    int spotIndex = _tours[tourIndex].spots.indexWhere((spot) => spot.name == currentSpotName);

    //User hat ja Frage richtig beantwortet, also finished = TRUE setzen
    _tours[tourIndex].spots[spotIndex].finished = isFinished;
    debugPrint("[NOTIFY]: ${_tours[tourIndex].spots[spotIndex].question}");

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
