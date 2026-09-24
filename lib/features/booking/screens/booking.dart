import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Add this to pubspec.yaml if you want nice date formatting
import '../../../data/services/booking_service.dart';
import 'package:car_rental/data/models/booking_model.dart';
import 'package:car_rental/features/home/screens/home.dart';


class BookingsScreen extends StatefulWidget {
  const BookingsScreen({super.key});

  @override
  State<BookingsScreen> createState() => _BookingsScreenState();
}

class _BookingsScreenState extends State<BookingsScreen> {
  late Future<List<BookingModel>> _bookingsFuture;

  @override
  void initState() {
    super.initState();
    _bookingsFuture = BookingService().getMyBookings();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        title: Text('My Bookings', style: textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold)),
      ),
      body: FutureBuilder<List<BookingModel>>(
        future: _bookingsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {

            return Center(child: CircularProgressIndicator(color: colorScheme.primary));
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error loading bookings', style: textTheme.bodyMedium));
          }

          final bookings = snapshot.data ?? [];

          if (bookings.isEmpty) {
            return Center(
              child: Text("You haven't booked any cars yet.", style: textTheme.titleMedium),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: bookings.length,
            separatorBuilder: (_, _) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              final booking = bookings[index];
              final car = booking.car;

              if (car == null) return const SizedBox();

              final startDate = DateFormat('MMM d, yyyy').format(booking.startDate);
              final endDate = DateFormat('MMM d, yyyy').format(booking.endDate);

              return Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: colorScheme.primary.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: colorScheme.primary.withValues(alpha: 0.3)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(car.imageUrl, height: 60, width: 80, fit: BoxFit.cover),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                             Row(
                               children: [
                                 Text(car.brand, style: textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold)),

                                 Text(' - '),
                                 
                                 Text(car.model, style: textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold)),
                               ],
                             ),
                              Text(booking.status, style: TextStyle(color: colorScheme.primary, fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                        Text('\$${booking.totalPrice.toStringAsFixed(0)}', style: textTheme.titleLarge),
                      ],
                    ),
                    const Divider(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildDateColumn('Pick-up', startDate, textTheme),
                        Icon(Icons.arrow_forward_rounded, color: colorScheme.primary),
                        _buildDateColumn('Drop-off', endDate, textTheme),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildDateColumn(String label, String date, TextTheme textTheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: textTheme.bodySmall),
        Text(date, style: textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold)),
      ],
    );
  }
}