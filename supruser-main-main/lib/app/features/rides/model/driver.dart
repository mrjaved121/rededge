class Driver {
  final int id;
  final String name;
  final String? email;
  final String? phone;
  final String? photo;
  final double? rating;
  final Vehicle? vehicle;

  Driver({
    required this.id,
    required this.name,
    this.email,
    this.phone,
    this.photo,
    this.rating,
    this.vehicle,
  });

  factory Driver.fromJson(Map<String, dynamic> json) {
    return Driver(
      id: json['id'],
      name: json['name'] ?? '',
      email: json['email'],
      phone: json['phone'],
      photo: json['photo'],
      rating: json['rating']?.toDouble() ?? 4.5,
      vehicle: json['vehicle'] != null
          ? Vehicle.fromJson(json['vehicle'])
          : null,
    );
  }
}

class Vehicle {
  final int id;
  final String regNo;
  final String color;
  final String carMake;
  final String carModel;

  Vehicle({
    required this.id,
    required this.regNo,
    required this.color,
    required this.carMake,
    required this.carModel,
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
      id: json['id'],
      regNo: json['reg_no'] ?? '',
      color: json['color'] ?? '',
      carMake: json['car_make'] ?? '',
      carModel: json['car_model'] ?? '',
    );
  }

  String get vehicleInfo => "$color $carMake $carModel";
}