class InterestingSpot {
  final String name;
  final String description;
  final double latitude; // Breitengrad
  final double longitude; // Längengrad
  final String onlineImageUrl;
  final String localImagePath;
  final String question;
  final List<String> answerOptions;
  final List<bool> answerChecker;
  bool finished;

  InterestingSpot({
    required this.name,
    required this.description,
    required this.latitude,
    required this.longitude,
    required this.onlineImageUrl,
    required this.localImagePath,
    required this.question,
    required this.answerOptions,
    required this.answerChecker,
    required this.finished,
  });
}
