class HeroModal {
  final String heroImage;
  final String heroLogo;
  final String heroName;
  final String heroInfo;
  final List<String> heroLatestNews;
  final List<String> relatedMovies;

  HeroModal({
    required this.heroImage,
    required this.heroLogo,
    required this.heroName,
    required this.heroInfo,
    required this.heroLatestNews,
    required this.relatedMovies,
  });

  factory HeroModal.fromJson(Map<String, dynamic> json) {
    return HeroModal(
      heroImage: json['heroImage'],
      heroLogo: json['heroLogo'],
      heroName: json['heroName'],
      heroInfo: json['heroInfo'],
      heroLatestNews: List<String>.from(json['heroLatestNews']),
      relatedMovies: List<String>.from(json['relatedMovies']),
    );
  }
}
