import 'package:flutter/material.dart';
import 'package:servana/view/screens/section_3/electrical_screen.dart';
import 'package:servana/view/screens/section_3/gardner_screen.dart';
import 'package:servana/view/screens/section_3/paint_screen.dart';
import 'package:servana/view/screens/section_3/pluming%20_screen.dart';
import 'package:servana/view/widgets/botton_navigation_widget.dart';
import 'package:servana/view/widgets/category_button_widget.dart';
import 'package:servana/view/widgets/top_rated_widget.dart';

import '../../../l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  final double? latitude;
  final double? longitude;

  const HomeScreen({this.latitude, this.longitude, super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  int selectedIndex2 = 0;

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  void onItemTapped2(int index2) {
    setState(() {
      selectedIndex2 = index2;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? Colors.black : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        //  titleSpacing: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Servana ",
              style: TextStyle(
                color: Colors.teal,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.notifications, color: Colors.teal, size: 32),
            ),
          ],
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  hintText:
                      AppLocalizations.of(
                        context,
                      )!.search_service_workers_or_etc,
                  prefixIcon: Icon(Icons.search),
                  // suffixIcon: IconButton(
                  //   icon: Icon(Icons.tune),
                  //   onPressed:
                  //       () => Navigator.push(
                  //     context,
                  //     MaterialPageRoute(builder: (_) => FilterScreen()),
                  //   ),
                  // ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  fillColor: isDark ? Colors.grey[800] : Colors.grey[200],
                  filled: true,
                ),
              ),
              SizedBox(height: 20),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Categories ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        color: Colors.teal,
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        CategoryButtonWidget(
                          title: AppLocalizations.of(context)!.pluming,
                          isSelected: selectedIndex == 0,
                          onPressed:
                              () => {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PlumingScreen(),
                                  ),
                                ),
                                onItemTapped(0),
                              },
                          ImagePath: 'assets/images/pluming.png',
                        ),
                        CategoryButtonWidget(
                          title: AppLocalizations.of(context)!.electrical,
                          isSelected: selectedIndex == 1,
                          onPressed:
                              () => {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ElectricalScreen(),
                                  ),
                                ),
                                onItemTapped(1),
                              },
                          ImagePath: 'assets/images/electrical.png',
                        ),
                        CategoryButtonWidget(
                          title: AppLocalizations.of(context)!.gardner,
                          isSelected: selectedIndex == 2,
                          onPressed:
                              () => {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => GardnerScreen(),
                                  ),
                                ),
                                onItemTapped(2),
                              },
                          ImagePath: 'assets/images/gardner.png',
                        ),
                        CategoryButtonWidget(
                          title: AppLocalizations.of(context)!.paint,
                          isSelected: selectedIndex == 3,
                          onPressed:
                              () => {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PaintScreen(),
                                  ),
                                ),
                                onItemTapped(3),
                              },
                          ImagePath: 'assets/images/paint.png',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Top Rated Workers",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 21,
                        color: Colors.teal,
                      ),
                    ),
                    SizedBox(height: 10),

                    Row(
                      children: [
                        TopRatedWidget(
                          title: "John Deo",
                          imagePath: "assets/images/man2.PNG",
                          rating: 4.5,
                          onPressed: () {},
                          description: 'Pluming',
                        ),
                        TopRatedWidget(
                          title: "Emma Smith",
                          imagePath: "assets/images/girl2.PNG",
                          rating: 3.0,
                          onPressed: () {},
                          description: 'Cleaning',
                        ),
                      ],
                    ),
                    SizedBox(height: 11),
                    Row(
                      children: [
                        TopRatedWidget(
                          title: "Clivia Brown",
                          imagePath: "assets/images/girl1.PNG",
                          rating: 4.0,
                          onPressed: () {},
                          description: 'Paint',
                        ),
                        TopRatedWidget(
                          title: "James Jonson",
                          imagePath: "assets/images/man1.PNG",
                          rating: 3.5,
                          onPressed: () {},
                          description: 'Electrical',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      bottomNavigationBar: BottomAppBar(
        color: bgColor,
        shape: CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: SizedBox(
          height: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BottonNavigationWidget(
                icon: Icons.home_filled,
                label: "Home",
                isSelected: selectedIndex2 == 0,
                onTap: () => onItemTapped2(0),
              ),
              BottonNavigationWidget(
                icon: Icons.wallet,
                label: "Wallet",
                isSelected: selectedIndex2 == 1,
                onTap: () => onItemTapped2(1),
              ),
              BottonNavigationWidget(
              icon: Icons.history,
               label: "History ",
               isSelected: selectedIndex2 == 2,
                onTap: () => onItemTapped2(2),
             ),

              BottonNavigationWidget(
                icon: Icons.person,
                label: "Profile",
                isSelected: selectedIndex2 == 3,
                onTap: () => onItemTapped2(3),
              ),
            ],
          ),
        ),
      ),
    );

  }
}
