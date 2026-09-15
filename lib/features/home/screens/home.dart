import 'package:car_rental/data/models/user_model.dart';
import 'package:car_rental/data/services/auth_service.dart';
import 'package:car_rental/my_widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

import 'package:flutter_glass_morphism/flutter_glass_morphism.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   // We will use this to track which brand button the user tapped
//   int _selectedBrandIndex = 0;
//   final List<String> _brands = ['All', 'Porsche', 'Mercedes', 'BMW', 'Lamborghini'];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // SafeArea prevents the UI from hiding behind the phone's top notch
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(20.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               _buildHeader(context),
//               const SizedBox(height: 24),
//               _buildSearchBar(context),
//               const SizedBox(height: 32),
//
//               // Top Brands Section
//               _buildSectionTitle('Top Brands', context),
//               const SizedBox(height: 16),
//               _buildBrandFilter(),
//               const SizedBox(height: 32),
//
//               // Featured Cars Section
//               _buildSectionTitle('Available Cars', context),
//               const SizedBox(height: 16),
//               _buildCarGrid(context),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   // ─── 1. HEADER ──────────────────────────────────────────────────────────
//   Widget _buildHeader(BuildContext context) {
//
//     String displayName = 'loading..';
//
//
//     return FutureBuilder<UserModel?>(
//       future: AuthService().getUserProfile(),
//       builder: (context, snapshot){
//         if(snapshot.hasData){
//           displayName = snapshot.data!.name;
//         }
//
//         return Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Welcome back,',
//                   style: Theme.of(context).textTheme.bodyMedium,
//                 ),
//                 Text(
//                   displayName, // 🔥 REAL NAME HERE 🔥
//                   style: Theme.of(context).textTheme.headlineSmall!.copyWith(
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ],
//             ),
//             const CircleAvatar(
//               radius: 24,
//               backgroundImage: AssetImage('assets/images/face.svg'),
//               backgroundColor: Colors.grey,
//             ),
//           ],
//         );
//
//
//       },
//
//
//
//
//     );
//
//   }
//
//   // ─── 2. SEARCH BAR ──────────────────────────────────────────────────────
//   Widget _buildSearchBar(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       decoration: BoxDecoration(
//         color: Theme.of(context).colorScheme.surface,
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(color: Theme.of(context).colorScheme.outline),
//       ),
//       child: Row(
//         children: [
//           Icon(Icons.search, color: Theme.of(context).colorScheme.onSurfaceVariant),
//           const SizedBox(width: 12),
//           Expanded(
//             child: TextField(
//               decoration: InputDecoration(
//                 hintText: 'Search for your dream car...',
//                 hintStyle: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant),
//                 border: InputBorder.none,
//                 enabledBorder: InputBorder.none,
//                 focusedBorder: InputBorder.none,
//                 fillColor: Colors.transparent,
//               ),
//             ),
//           ),
//           Icon(Icons.tune, color: Theme.of(context).colorScheme.primary), // Filter icon in Gold
//         ],
//       ),
//     );
//   }
//
//   // ─── 3. BRAND FILTER ────────────────────────────────────────────────────
//   Widget _buildBrandFilter() {
//     return SizedBox(
//       height: 40,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: _brands.length,
//         itemBuilder: (context, index) {
//           final isSelected = _selectedBrandIndex == index;
//           return GestureDetector(
//             onTap: () {
//               setState(() => _selectedBrandIndex = index);
//             },
//             child: Container(
//               margin: const EdgeInsets.only(right: 12),
//               padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
//               decoration: BoxDecoration(
//                 // If selected, turn Gold. If not, make it transparent with a border.
//                 color: isSelected
//                     ? Theme.of(context).colorScheme.primary
//                     : Colors.transparent,
//                 borderRadius: BorderRadius.circular(20),
//                 border: Border.all(
//                   color: isSelected
//                       ? Theme.of(context).colorScheme.primary
//                       : Theme.of(context).colorScheme.outline,
//                 ),
//               ),
//               child: Center(
//                 child: Text(
//                   _brands[index],
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     // If selected, text is Carbon. If not, text is standard.
//                     color: isSelected
//                         ? Theme.of(context).colorScheme.onPrimary
//                         : Theme.of(context).colorScheme.onSurface,
//                   ),
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
//
//   // ─── 4. CAR GRID ────────────────────────────────────────────────────────
//   Widget _buildCarGrid(BuildContext context) {
//     // We use a ListView with shrinkWrap for now. Later we will build a real Grid.
//     return ListView.builder(
//       shrinkWrap: true, // Important when putting ListView inside SingleChildScrollView
//       physics: const NeverScrollableScrollPhysics(),
//       itemCount: 3, // Just 3 dummy cars for now
//       itemBuilder: (context, index) {
//         return _buildCarCard(context);
//       },
//     );
//   }
//
//   // ─── CAR CARD DESIGN ────────────────────────────────────────────────────
//   Widget _buildCarCard(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 20),
//       decoration: BoxDecoration(
//         color: Theme.of(context).colorScheme.surface,
//         borderRadius: BorderRadius.circular(24),
//         border: Border.all(color: Theme.of(context).colorScheme.outline),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Top Half: Image
//           ClipRRect(
//             borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
//             child: Image.asset(
//               'assets/images/josh-berquist-_4sWbzH5fp8-unsplash.jpg', // One of your actual images!
//               height: 180,
//               width: double.infinity,
//               fit: BoxFit.cover,
//             ),
//           ),
//           // Bottom Half: Details
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Porsche 911',
//                       style: Theme.of(context).textTheme.titleLarge!.copyWith(
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     const SizedBox(height: 4),
//                     Text(
//                       'Auto • Petrol • 2 Seats',
//                       style: Theme.of(context).textTheme.bodyMedium,
//                     ),
//                   ],
//                 ),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   children: [
//                     Text(
//                       '\$250',
//                       style: Theme.of(context).textTheme.titleLarge!.copyWith(
//                         color: Theme.of(context).colorScheme.primary, // Gold Price!
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     Text(
//                       '/day',
//                       style: Theme.of(context).textTheme.bodySmall,
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   // Helper widget for section titles
//   Widget _buildSectionTitle(String title, BuildContext context) {
//     return Text(
//       title,
//       style: Theme.of(context).textTheme.titleLarge!.copyWith(
//         fontWeight: FontWeight.bold,
//       ),
//     );
//   }
// }
//

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

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
    final colorScheme = Theme
        .of(context)
        .colorScheme;
    final textTheme = Theme
        .of(context)
        .textTheme;
    String displayName = 'Ahmed';

    return Scaffold(
      backgroundColor: Theme
          .of(context)
          .scaffoldBackgroundColor,
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(children: [
                  _header(colorScheme, textTheme),
                  SizedBox(height: 30,),
                  _buildSearchBar(colorScheme, textTheme),

                  SizedBox(height: 20,),

                  _buildBrandRow(colorScheme,textTheme),
                  SizedBox(height: 20,),




                  _carCard(colorScheme,textTheme),
                  _carCard(colorScheme,textTheme),
                  _carCard(colorScheme,textTheme),
                  _carCard(colorScheme,textTheme),
                  _carCard(colorScheme,textTheme),





                ]),
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
    String displayName = 'Ahmed';

    return Row(
      mainAxisAlignment: .spaceBetween,

      children: [

        Row(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: .circle,

                border: Border.all(color: colorScheme.primary, width: 1.5),
              ),
              child: const CircleAvatar(
                radius: 22,
                backgroundImage: AssetImage('assets/svg/face.svg'),
                backgroundColor: Colors.transparent,
              ),
            ),

            SizedBox(width: 12),

            Text('$displayName', style: textTheme.titleLarge),


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
                color: colorScheme.onSurface.withValues(alpha: 0.1)),
            gradient: LinearGradient(colors: [
              Colors.white.withValues(alpha: 0.6),
              Colors.white.withValues(alpha: 0.02)
            ]),

          ),
          child: Row(
            children: [
              Icon(Icons.search),
              SizedBox(width: 10,),
              Text(
                'Search Luxury Cars...',
                style: textTheme.bodyMedium,
              ),
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
        itemBuilder: (context, i){
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
                      border: isSelected ?
                          Border.all(color: colorScheme.primary, width: 1.5)
                      : Border.all(color: Colors.transparent,),
                      boxShadow: isSelected
                          ? [
                        BoxShadow(
                          color: colorScheme.primary.withOpacity(0.25),
                          blurRadius: 15,
                          spreadRadius: 1,
                        )
                      ]
                          : [],

                    ),




                    child: Icon(
                      _brands[i]['icon'],
                      // Active = Gold, Inactive = Adaptive Grey
                      color: isSelected ? colorScheme.primary : textTheme.bodyMedium!.color,
                    ),
                  ),
                  const SizedBox(height: 8),

                  Text(
                    _brands[i]['name'],
                    style: textTheme.bodyMedium!.copyWith(
                      color: isSelected ? colorScheme.onSurface : textTheme.bodyMedium!.color,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
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




  Widget _carCard(  ColorScheme colorScheme, TextTheme textTheme){

    return Container(

      padding: EdgeInsets.all(16),

      decoration: BoxDecoration(
          color: colorScheme.primary.withValues(alpha: 0.20),
        borderRadius: BorderRadius.circular(24),
        border: Border.all( color: colorScheme.primary.withValues(alpha: 0.8), ),
        boxShadow: [
          BoxShadow(
            color: colorScheme.onSecondary.withValues(alpha: 0.20),
            blurRadius: 50,
            spreadRadius: 0,
          )
        ],
      ),

      child: Column(

        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  'assets/images/josh-berquist-_4sWbzH5fp8-unsplash.jpg',
                  height: 180,

                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 10,
                  right: 10,
                  child: IconButton(onPressed: (){}, icon: Icon(Icons.favorite, size: 30, color: colorScheme.error,),

                  )

              )
            ],
          ),

          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildSpecColumn('Car Name', 'Porsche 911 GT3', textTheme, colorScheme),
              _buildSpecColumn('Year', '2023', textTheme, colorScheme),
              _buildSpecColumn('Trans.', 'Auto', textTheme, colorScheme),
              _buildSpecColumn('Seats', '2', textTheme, colorScheme),
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
                        '\$899',
                        style: textTheme.headlineMedium!.copyWith(
                          color: colorScheme.primary, // PRODUCTION: Gold Price
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(' /day', style: textTheme.bodyMedium),
                    ],
                  ),
                ],
              ),

              ElevatedButton(
                onPressed: () {},
                child: const Text('Rent Now'),
              )
            ],
          ),
        ],

      ),


    );


  }


  Widget _buildSpecColumn(String title, String value, TextTheme textTheme, ColorScheme colorScheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: textTheme.bodySmall), // Grey Subtitle
        const SizedBox(height: 4),
        Text(value, style: textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold)), // Bold White Main
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
              color: colorScheme.onSurface.withOpacity(0.08),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: colorScheme.onSurface.withOpacity(0.1)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(0, Icons.home_filled, 'Home', colorScheme),
                _buildNavItem(1, Icons.search, 'Explore', colorScheme),
                _buildNavItem(2, Icons.calendar_today, 'Bookings', colorScheme),
                _buildNavItem(3, Icons.person_outline, 'Account', colorScheme),
              ],
            ),
          ),
        ),
      ),
    );
  }


  Widget _buildNavItem(int index, IconData icon, String label, ColorScheme colorScheme) {
    final isSelected = _currentNavIndex == index;
    // Active = Gold Theme Primary. Inactive = Adaptive White/Grey with opacity.
    final color = isSelected ? colorScheme.primary : colorScheme.onSurface.withOpacity(0.5);

    return GestureDetector(
      onTap: () => setState(() => _currentNavIndex = index),
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
          )
        ],
      ),
    );
  }





}
