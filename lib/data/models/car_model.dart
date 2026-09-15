class CarModel {
  final String id; // Don't forget the ID!
  final String name;
  final String brand;
  final String model;
  final String year;
  final String? category;
  final String? transmission;
  final String? seats;
  final String? fuelType;
  final String? location;
  final String imageUrl;
  final bool? isAvailable;
  final double pricePerDay;

  const CarModel({
    required this.id,
    required this.name,
    required this.brand,
    required this.model,
    required this.year,
    required this.pricePerDay,
    required this.imageUrl,
    this.category,
    this.transmission,
    this.seats,
    this.fuelType,
    this.location,
    this.isAvailable,
  });

  // Converts raw Supabase JSON into a clean CarModel object
  factory CarModel.fromJson(Map<String, dynamic> json) {
    return CarModel(
      id: json['id']?.toString() ?? '',
      name: json['name'] ?? 'Unknown Car',
      brand: json['brand'] ?? 'Unknown Brand',
      model: json['model'] ?? '',
      year: json['year']?.toString() ?? '',
      pricePerDay: (json['price_per_day'] as num?)?.toDouble() ?? 0.0,
      imageUrl: json['image_url'] ?? '',
      category: json['category'],
      transmission: json['transmission'],
      seats: json['seats']?.toString(),
      fuelType: json['fuel_type'],
      location: json['location'],
      isAvailable: json['is_available'],
    );
  }

  // Converts a CarModel back into JSON to send to Supabase
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'brand': brand,
      'model': model,
      'year': year,
      'price_per_day': pricePerDay,
      'image_url': imageUrl,
      'category': category,
      'transmission': transmission,
      'seats': seats,
      'fuel_type': fuelType,
      'location': location,
      'is_available': isAvailable,
    };
  }
}