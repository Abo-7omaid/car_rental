import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/car_model.dart';

class CarService {
  final _client = Supabase.instance.client;

  Future<List<CarModel>> getAllCars() async {
    final response = await _client.from('cars').select();

    return (response as List)
        .map((json) => CarModel.fromJson(json))
        .toList();
  }
}