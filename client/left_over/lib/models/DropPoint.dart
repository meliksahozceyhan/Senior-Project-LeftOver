class DropPoint {
  String id,
      title,
      lat,
      lon;

  DropPoint({
    this.id,
    this.title,
    this.lat,
    this.lon,
  });

  factory DropPoint.fromJson(Map<String, dynamic> json) {
    return DropPoint(
      id: json['id'],
      title: json['title'],
      lat: json['lat'],
      lon: json['lon'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "lat": lat,
      "lon": lon
    };
  }
}
