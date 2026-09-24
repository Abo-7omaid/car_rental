import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/car_model.dart';

// --- THE MODEL ---
class BookingModel {
  final String id;
  final int carId;
  final DateTime startDate;
  final DateTime endDate;
  final double totalPrice;
  final String status;
  final CarModel? car;

  BookingModel({
    required this.id,
    required this.carId,
    required this.startDate,
    required this.endDate,
    required this.totalPrice,
    required this.status,
    this.car,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      id: json['id'],
      carId: json['car_id'],
      startDate: DateTime.parse(json['start_date']),
      endDate: DateTime.parse(json['end_date']),
      totalPrice: (json['total_price'] as num).toDouble(),
      status: json['status'] ?? 'Confirmed',
      // If Supabase sends the joined car data, parse it!
      car: json['cars'] != null ? CarModel.fromJson(json['cars']) : null,
    );
  }
}

