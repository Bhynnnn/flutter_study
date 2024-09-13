class Book {
  final String title, subtitle, thumbnail, previewLink;

  Book({
    required this.title,
    required this.subtitle,
    required this.thumbnail,
    required this.previewLink,
  });

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "subtitle": subtitle,
      "thumbnail": thumbnail,
      "previewLink": previewLink,
    };
  }

  factory Book.fromJson(Map<String, dynamic> volumeInfo) {
    return Book(
      title: volumeInfo["title"] ?? "",
      subtitle: volumeInfo["subtitle"] ?? "",
      thumbnail: volumeInfo["imageLinks"]["thumbnail"] ?? "",
      previewLink: volumeInfo["previewLink"] ?? "",
    );
  }
}
