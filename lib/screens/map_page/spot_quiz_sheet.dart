import 'package:flutter/material.dart';
import 'package:histoury/shared/models/tour.dart';
import 'package:provider/provider.dart';

import '../../state_management.dart/tour_change_notifier.dart';
import '../../shared/models/interesting_spot.dart';

class SpotQuizSheet extends StatefulWidget {
  final Tour tour;
  final InterestingSpot spot;

  const SpotQuizSheet({Key? key, required this.tour, required this.spot}) : super(key: key);

  @override
  State<SpotQuizSheet> createState() => _SpotQuizSheetState();
}

class _SpotQuizSheetState extends State<SpotQuizSheet> {
  num notify = 0; // 0 - neutral, 1 - right answer, -1 - wrong answer

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: const Icon(Icons.place),
              title: Text(widget.spot.name),
              subtitle: Text(widget.spot.description),
              // trailing: Text(widget.tour.finished.toString()),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          Wrap(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  widget.spot.question,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.spot.answerOptions.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("${index + 1}. ${widget.spot.answerOptions[index]}"),
                  ),
                  onTap: () {
                    setState(() {
                      if (widget.spot.answerChecker[index]) {
                        int tourIndex = widget.tour.name == "Dortmund Tour" ? 0 : 1;
                        Provider.of<TourProvider>(context, listen: false)
                            .updateInterestingSpotStatus(tourIndex, widget.spot.name, true);
                        notify = 1;
                      } else {
                        notify = -1;
                      }
                    });
                  },
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                notify == -1
                    ? "Falsche Anwort"
                    : notify == 1
                        ? "Richtige Antwort"
                        : "Wähle eine Antwormöglichkeit.",
                style: TextStyle(
                  color: notify == -1
                      ? Colors.red
                      : notify == 1
                          ? Colors.green
                          : Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
