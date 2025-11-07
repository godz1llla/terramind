class PlotModel {
  final String id;
  final String name;
  final List<PlotCoordinate> coordinates;
  final String? crop;
  final String? soilType;
  final DateTime? plantingDate;

  PlotModel({
    required this.id,
    required this.name,
    required this.coordinates,
    this.crop,
    this.soilType,
    this.plantingDate,
  });

  PlotModel copyWith({
    String? name,
    List<PlotCoordinate>? coordinates,
    String? crop,
    String? soilType,
    DateTime? plantingDate,
  }) {
    return PlotModel(
      id: id,
      name: name ?? this.name,
      coordinates: coordinates ?? this.coordinates,
      crop: crop ?? this.crop,
      soilType: soilType ?? this.soilType,
      plantingDate: plantingDate ?? this.plantingDate,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'coordinates': coordinates.map((c) => c.toJson()).toList(),
      'crop': crop,
      'soilType': soilType,
      'plantingDate': plantingDate?.toIso8601String(),
    };
  }

  factory PlotModel.fromJson(Map<String, dynamic> json) {
    return PlotModel(
      id: json['id'],
      name: json['name'],
      coordinates: (json['coordinates'] as List)
          .map((c) => PlotCoordinate.fromJson(c))
          .toList(),
      crop: json['crop'],
      soilType: json['soilType'],
      plantingDate: json['plantingDate'] != null
          ? DateTime.parse(json['plantingDate'])
          : null,
    );
  }
}

// Универсальный класс координат (работает с любыми картами)
class PlotCoordinate {
  final double latitude;
  final double longitude;

  PlotCoordinate({required this.latitude, required this.longitude});

  Map<String, dynamic> toJson() {
    return {
      'lat': latitude,
      'lng': longitude,
    };
  }

  factory PlotCoordinate.fromJson(Map<String, dynamic> json) {
    return PlotCoordinate(
      latitude: json['lat'],
      longitude: json['lng'],
    );
  }
}
