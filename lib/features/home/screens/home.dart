import 'package:car_rental/data/models/car_model.dart';
import 'package:car_rental/data/models/user_model.dart';
import 'package:car_rental/my_widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:car_rental/data/services/car_service.dart';
import 'package:car_rental/data/services/auth_service.dart';
import 'package:car_rental/data/services/booking_service.dart';
import 'package:shimmer/shimmer.dart';
import 'package:intl/intl.dart';
import '../../../core/constants/app_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<CarModel>> _carsFuture;
  @override
  void initState() {
    super.initState();
    // 👇 Fetch the cars ONCE when the screen first opens
    _carsFuture = CarService().getAllCars();
  }

  int _selectedBrandIndex = 1;
  int _currentNavIndex = 0;

  final List<Map<String, dynamic>> _brands = [
    {'name': 'All', 'icon': Icons.apps},
    {'name': 'Porsche', 'icon': Icons.sports_motorsports},
    {'name': 'Lamborghini', 'icon': Icons.electric_car},
    {'name': 'Ferrari', 'icon': Icons.speed},
    {'name': 'Toyota', 'icon': Icons.smart_toy_outlined},
    {'name': 'Mercedes', 'icon': Icons.fire_truck},
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    // String displayName = ;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: Stack(
        children: [
          SafeArea(
            child: RefreshIndicator(
              color: colorScheme.primary, // Make the pulling spinner Gold!
              backgroundColor: colorScheme.surface, // Make the background dark
              // 👇 2. Add the onRefresh function
              onRefresh: () async {
                setState(() {
                  _carsFuture = CarService().getAllCars();
                });
                try {
                  await _carsFuture;
                } catch (e) {
                  //
                }
              },

              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),

                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      _header(colorScheme, textTheme),
                      SizedBox(height: 30),
                      _buildSearchBar(colorScheme, textTheme),
                      SizedBox(height: 20),
                      _buildBrandRow(colorScheme, textTheme),
                      SizedBox(height: 20),
                      _buildCarGrid(colorScheme, textTheme),
                      const SizedBox(height: 120),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: _buildFloatingNavBar(colorScheme),
          ),
        ],
      ),
    );
  }

  Widget _header(ColorScheme colorScheme, TextTheme textTheme) {
    String displayName = AuthService.UserInfo?.name.toString() ?? ' Guest';

    return Row(
      mainAxisAlignment: .spaceBetween,

      children: [
        Row(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: .circle,

                border: Border.all(color: colorScheme.surfaceBright, width: 1),
              ),
              child: CircleAvatar(
                radius: 22,
                backgroundColor: colorScheme.onSecondary,
                child: Image.network(
                  'https://neizzshqtuaigwhgotpk.supabase.co/storage/v1/object/sign/assets/images/user.png?token=eyJraWQiOiJmYzBmZWY1OC00YzI3LTQ0ZjktYWNkNC0xMTQ3NTExMmE5MzkiLCJhbGciOiJIUzUxMiJ9.eyJ1cmwiOiJhc3NldHMvaW1hZ2VzL3VzZXIucG5nIiwic2NvcGUiOiJkb3dubG9hZCIsImlhdCI6MTc4OTc3ODk5OSwiZXhwIjoxODIxMzE0OTk5fQ.tPMVDHatQRVQAqXnaT27DxgfY7jckyau8He4zKRmizrXJQFjwfrNVz2sfE9P_TvrRvl3SpmeWY-Zh6FLEBdPfg',
                ),
              ),
            ),
            SizedBox(width: 12),

            Text(displayName, style: textTheme.titleLarge),
          ],
        ),

        Row(
          children: [
            Icon(
              Icons.location_on_outlined,
              color: colorScheme.primary,
              size: 30,
            ),
            const SizedBox(width: 4),
            Text('Yemen, Sanaa', style: textTheme.bodyMedium),
            const SizedBox(width: 20),

            Stack(
              children: [
                Icon(
                  Icons.notifications_none,
                  color: colorScheme.primary,
                  size: 30,
                ),

                //red dot
                Positioned(
                  top: 2,
                  right: 2,
                  child: Container(
                    height: 8,
                    width: 8,
                    decoration: BoxDecoration(
                      shape: .circle,
                      color: colorScheme.error,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSearchBar(ColorScheme colorScheme, TextTheme textTheme) {
    return ClipRRect(
      borderRadius: .circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),

        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: colorScheme.onSurface.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: colorScheme.onSurface.withValues(alpha: 0.1),
            ),
            gradient: LinearGradient(
              colors: [
                Colors.white.withValues(alpha: 0.6),
                Colors.white.withValues(alpha: 0.02),
              ],
            ),
          ),
          child: Row(
            children: [
              Icon(Icons.search),
              SizedBox(width: 10),
              Text('Search Luxury Cars...', style: textTheme.bodyMedium),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBrandRow(ColorScheme colorScheme, TextTheme textTheme) {
    return SizedBox(
      height: 80,

      child: ListView.builder(
        scrollDirection: .horizontal,

        itemCount: _brands.length,
        itemBuilder: (context, i) {
          final isSelected = _selectedBrandIndex == i;
          return GestureDetector(
            onTap: () => setState(() => _selectedBrandIndex = i),
            child: Padding(
              padding: EdgeInsets.only(right: 20),
              child: Column(
                children: [
                  Container(
                    height: 55,
                    width: 55,
                    decoration: BoxDecoration(
                      color: colorScheme.onSurface.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(16),
                      border: isSelected
                          ? Border.all(color: colorScheme.primary, width: 1.5)
                          : Border.all(color: Colors.transparent),
                      boxShadow: isSelected
                          ? [
                              BoxShadow(
                                color: colorScheme.primary.withOpacity(0.25),
                                blurRadius: 15,
                                spreadRadius: 1,
                              ),
                            ]
                          : [],
                    ),

                    child: Icon(
                      _brands[i]['icon'],
                      color: isSelected
                          ? colorScheme.primary
                          : textTheme.bodyMedium!.color,
                    ),
                  ),
                  const SizedBox(height: 8),

                  Text(
                    _brands[i]['name'],
                    style: textTheme.bodyMedium!.copyWith(
                      color: isSelected
                          ? colorScheme.onSurface
                          : textTheme.bodyMedium!.color,
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.normal,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCarGrid(ColorScheme colorScheme, TextTheme textTheme) {
    return FutureBuilder<List<CarModel>>(
      future: _carsFuture,
      builder: (context, snapshot) {
        // State 1: Still waiting for Supabase to respond
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              color: colorScheme.primary, // Gold spinner!
            ),
          );
        }

        // State 2: Supabase responded but with an error
        if (snapshot.hasError) {
          // Add debug logging here
          debugPrint('--- Error Loading Cars ---');
          debugPrint(snapshot.error.toString());
          debugPrint('--------------------------');

          return Center(
            child: Column(
              children: [
                Text(
                  'Could not load cars. Please check your Network connection',
                  style: textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      _carsFuture = CarService().getAllCars();
                    });
                  },
                  icon: Icon(Icons.refresh, size: 35),
                ),
              ],
            ),
          );
        }

        // State 3: Success but the table is empty
        final cars = snapshot.data ?? [];
        if (cars.isEmpty) {
          return Center(
            child: Text(
              'No cars available in database.',
              style: textTheme.bodyMedium,
            ),
          );
        }

        return ListView.separated(
          itemCount: cars.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          separatorBuilder: (context, index) => const SizedBox(height: 24),

          padding: .all(10),
          itemBuilder: (context, index) {
            return _carCard(cars[index], colorScheme, textTheme);
          },
        );
      },
    );
  }

  Widget _carCard(CarModel car, ColorScheme colorScheme, TextTheme textTheme) {
    return Container(
      padding: EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: colorScheme.primary.withValues(alpha: 0.20),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: colorScheme.primary.withValues(alpha: 0.8)),
        boxShadow: [
          BoxShadow(
            color: colorScheme.onSecondary.withValues(alpha: 0.20),
            blurRadius: 50,
            spreadRadius: 0,
          ),
        ],
      ),

      child: Column(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: car.imageUrl.isNotEmpty
                    ? Image.network(
                        car.imageUrl,
                        height: 180,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;

                          final isDark =
                              Theme.of(context).brightness == Brightness.dark;

                          return Shimmer.fromColors(
                            baseColor: isDark
                                ? AppColors.shimmerBaseDark
                                : AppColors.shimmerBaseLight,
                            highlightColor: isDark
                                ? AppColors.shimmerHighlightDark
                                : AppColors.shimmerHighlightLight,
                            child: Container(
                              height: 180,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                          );
                        },

                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            height: 180,
                            width: double.infinity,
                            color: const Color(0xFF1A1A1A),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.wifi_off,
                                  size: 40,
                                  color: colorScheme.primary,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Image failed to load',
                                  style: textTheme.bodySmall,
                                ),
                              ],
                            ),
                          );
                        },
                      )
                    : Container(height: 180, color: colorScheme.surface),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.favorite,
                    size: 30,
                    color: colorScheme.error,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildSpecColumn('Brand', car.brand, textTheme, colorScheme),
              // _buildSpecColumn('Car Name', 'Porsche 911 GT3', textTheme, colorScheme),
              // _buildSpecColumn('Year', '2023', textTheme, colorScheme),
              // _buildSpecColumn('Trans.', 'Auto', textTheme, colorScheme),
              _buildSpecColumn('Model', car.model, textTheme, colorScheme),
              _buildSpecColumn('Year', car.year, textTheme, colorScheme),
              _buildSpecColumn(
                'Trans.',
                car.transmission ?? 'auto',
                textTheme,
                colorScheme,
              ),
              _buildSpecColumn(
                'Seats',
                car.seats ?? 'N/A',
                textTheme,
                colorScheme,
              ),
            ],
          ),
          const SizedBox(height: 5),
          Divider(color: colorScheme.onSurface.withOpacity(0.1)),
          const SizedBox(height: 2),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: .start,
                children: [
                  Text('Rental Price', style: textTheme.bodyMedium),
                  Row(
                    crossAxisAlignment: .end,
                    children: [
                      Text(
                        car.pricePerDay.toString(),
                        style: textTheme.headlineMedium!.copyWith(
                          color: colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(' /day', style: textTheme.bodyMedium),
                    ],
                  ),
                ],
              ),
              ElevatedButton(
                child: Text('Rent Now', style: TextStyle(fontWeight: .bold)),

                onPressed: () {
                  _handleRentNow(context, car);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSpecColumn(
    String title,
    String value,
    TextTheme textTheme,
    ColorScheme colorScheme,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: textTheme.bodySmall), // Grey Subtitle
        const SizedBox(height: 4),
        Text(
          value,
          style: textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
        ), // Bold White Main
      ],
    );
  }

  Widget _buildFloatingNavBar(ColorScheme colorScheme) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 30),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Container(
            height: 70,
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainer.withValues(alpha: 0.8),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: colorScheme.onSurface.withValues(alpha: 0.1),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(
                  0,
                  Icons.home_filled,
                  'Home',
                  colorScheme,
                  '/home',
                ),
                _buildNavItem(
                  1,
                  Icons.search,
                  'Explore',
                  colorScheme,
                  '/explore',
                ),
                _buildNavItem(
                  2,
                  Icons.calendar_today,
                  'Bookings',
                  colorScheme,
                  '/bookings',
                ),
                _buildNavItem(
                  3,
                  Icons.person_outline,
                  'Account',
                  colorScheme,
                  'profile',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
    int index,
    IconData icon,
    String label,

    ColorScheme colorScheme,
    String route,
  ) {
    final isSelected = _currentNavIndex == index;
    final color = isSelected ? colorScheme.primary : colorScheme.onSurface;

    return GestureDetector(
      onTap: () async {
        setState(() => _currentNavIndex = index);
        if (index == 2) {
          await Navigator.pushNamed(context, '/bookings');

          if (mounted) {
            setState(() => _currentNavIndex = 0);
          }
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 10,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _handleRentNow(BuildContext context, CarModel car) async {
    final colorScheme = Theme.of(context).colorScheme;

    final DateTimeRange? dateRange = await showDateRangePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: colorScheme.copyWith(primary: colorScheme.primary),
          ),
          child: child!,
        );
      },
    );

    if (dateRange == null) return;

    final int days = dateRange.duration.inDays == 0
        ? 1
        : dateRange.duration.inDays;
    final double totalPrice = days * car.pricePerDay;

    final String startDate = DateFormat('dd - MMM').format(dateRange.start);
    final String endDate = DateFormat('dd - MMM').format(dateRange.end);

    if (!context.mounted) return;

    //show a Confirmation Popup
    final confirm = await showModalBottomSheet<bool>(
      context: context,
      builder: (context) => Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: .end,
              children: [Icon(Icons.close, size: 35)],
            ),
            Align(
              child: Text(
                'Confirm booking',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              alignment: .center,
            ),
            SizedBox(height: 20),

            Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                Text(
                  'Car name:',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: .bold,
                    fontSize: 22,
                  ),
                ),
                SizedBox(width: 20),

                Text(
                  car.brand,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontWeight: .bold,
                    fontSize: 23,
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),

            Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                Text(
                  'Start date',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: .bold,
                    fontSize: 22,
                  ),
                ),
                SizedBox(width: 5),

                Text(
                  startDate,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontWeight: .bold,
                    fontSize: 23,
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),

            Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                Text(
                  'End date:',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: .bold,
                    fontSize: 22,
                  ),
                ),
                SizedBox(width: 5),

                Text(
                  endDate,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontWeight: .bold,
                    fontSize: 23,
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),

            Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                Text(
                  'Total days:',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: .bold,
                    fontSize: 22,
                  ),
                ),
                SizedBox(width: 5),

                Text(
                  days.toString(),
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontWeight: .bold,
                    fontSize: 22,
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),

            Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                Text(
                  'Price /day:',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: .bold,
                    fontSize: 22,
                  ),
                ),
                SizedBox(width: 5),

                Text(
                  car.pricePerDay.toString(),
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontWeight: .bold,
                    fontSize: 22,
                  ),
                ),
              ],
            ),

            SizedBox(height: 5),

            Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                Text(
                  'Total price:',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: .bold,
                    fontSize: 22,
                  ),
                ),
                SizedBox(width: 20),

                Text(
                  totalPrice.toString(),
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontWeight: .bold,
                    fontSize: 22,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),

            Divider(),

            SizedBox(height: 20),

            Row(
              children: [
                SizedBox(width: 20),

                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorScheme.outline,
                    ),
                    child: Text(
                      'Cancel',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: colorScheme.error,
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context, false);
                    },
                  ),
                ),
                SizedBox(width: 20),

                Expanded(
                  child: ElevatedButton(
                    child: Row(
                      mainAxisAlignment: .spaceAround,
                      children: [
                        SizedBox(width: 20),

                        Text(
                          'Next',
                          style: Theme.of(context).textTheme.titleLarge!
                              .copyWith(color: colorScheme.surfaceBright),
                        ),
                        Icon(Icons.arrow_forward, size: 28),
                      ],
                    ),
                    onPressed: () async {
                      // 1. Show the final confirmation dialog
                      final sure = await showDialog<bool>(
                        context: context,
                        builder: (context) => AlertDialog(
                          // backgroundColor: colorScheme.surface,
                          title: Text('Confirm'),
                          content: const Text(
                            'Are you sure you want to book this car?',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context, false),
                              child: const Text('No'),
                            ),
                            ElevatedButton(
                              onPressed: () => Navigator.pop(context, true),
                              child: const Text('Yes, Book it!'),
                            ),
                          ],
                        ),
                      );

                      if (sure == true) {
                        if (!context.mounted) return;
                        Navigator.pop(context, true);
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );

    if (confirm != true) return;

    // 4. Save to Database
    try {
      // Show loading snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Booking your car...'),
          backgroundColor: colorScheme.primary,
        ),
      );

      await BookingService().createBooking(
        carId: car.id,
        startDate: dateRange.start,
        endDate: dateRange.end,
        totalPrice: totalPrice,
      );

      if (!context.mounted) return;

      // Success!
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Car Booked Successfully! 🎉'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to book car: $e'),
          backgroundColor: colorScheme.error,
        ),
      );
    }
  }
}
