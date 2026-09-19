import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/car_model.dart';
import '../models/booking_model.dart';


// --- THE SERVICE ---
class BookingService {
  final _client = Supabase.instance.client;

  // 1. Create a new booking
  Future<void> createBooking({
    required String carId,
    required DateTime startDate,
    required DateTime endDate,
    required double totalPrice,
  }) async {
    final userId = _client.auth.currentUser!.id;

    await _client.from('bookings').insert({
      'user_id': userId,
      'car_id': carId,

      'start_date': startDate.toIso8601String(),
      'end_date': endDate.toIso8601String(),
      'total_price': totalPrice,
    });
  }

  // 2. Get my bookings (with the car details joined!)
  Future<List<BookingModel>> getMyBookings() async {
    final userId = _client.auth.currentUser!.id;

    // Notice we do `select('*, cars(*)')` - this automatically fetches the car details too!
    final response = await _client
        .from('bookings')
        .select('*, cars(*)')
        .eq('user_id', userId)
        .order('created_at', ascending: false);


    // print(response.length);


    return (response as List).map((json) => BookingModel.fromJson(json)).toList();
  }
}