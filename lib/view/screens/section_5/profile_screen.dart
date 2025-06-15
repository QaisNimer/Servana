import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../controller/lang_controller.dart';
import '../../../core/theme/theme_provider.dart';
import '../../widgets/botton_navigation_widget.dart';
import '../section_2/login_screen.dart';
import '../section_3/home_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int selectedIndex = 3;
  bool pushNotifications = true;
  bool promotionalNotifications = false;

  void onItemTapped(int index) {
    setState(() => selectedIndex = index);
  }

  void _navigate(int idx, Widget page) {
    onItemTapped(idx);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => page));
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Theme.of(context).iconTheme.color),
          onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomeScreen())),
        ),
        title: Text(
          'Profile',
          style: TextStyle(
            fontSize: width * .06,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).textTheme.titleMedium?.color,
          ),
        ),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: height * .02),
              CircleAvatar(
                radius: width * .15,
                backgroundImage: const AssetImage('assets/images/man1.PNG'),
              ),
              SizedBox(height: height * .02),
              Text(
                'Ahmad Daboor',
                style: TextStyle(
                  fontSize: width * .045,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.titleMedium?.color,
                ),
              ),
              Text(
                'ahmad1709@gmail.com',
                style: TextStyle(
                  fontSize: width * .035,
                  color: Theme.of(context).textTheme.bodyMedium?.color,
                ),
              ),
              SizedBox(height: height * .02),

              // Account Card
              Container(
                width: width * .9,
                padding: EdgeInsets.all(width * .04),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: isDarkMode ? Colors.black.withOpacity(.5) : Colors.grey.withOpacity(.3),
                      spreadRadius: 2,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'My Account',
                      style: TextStyle(
                        fontSize: width * .045,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).textTheme.titleMedium?.color,
                      ),
                    ),
                    SizedBox(height: width * .02),

                    // Personal Information Tile
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(Icons.person_outline, size: width * .06, color: Theme.of(context).iconTheme.color),
                      title: Text(
                        'Personal Information',
                        style: TextStyle(
                          fontSize: width * .04,
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).textTheme.bodyMedium?.color,
                        ),
                      ),
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => HomeScreen())),
                    ),

                    // Language Tile with trailing button
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(Icons.language, size: width * .06, color: Theme.of(context).iconTheme.color),
                      title: Text(
                        'Language',
                        style: TextStyle(
                          fontSize: width * .04,
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).textTheme.bodyMedium?.color,
                        ),
                      ),
                      trailing: TextButton(
                        onPressed: () {
                          String currentLang = Localizations.localeOf(context).languageCode;
                          String newLang = currentLang == 'ar' ? 'en' : 'ar';
                          Provider.of<LangController>(context, listen: false).changeLang(langCode: newLang);
                        },
                        style: ButtonStyle(foregroundColor: MaterialStateProperty.all(Colors.blueAccent)),
                        child: const Text('عربية', style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ),

                    // Dark Mode switch
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(Icons.dark_mode, size: width * .06, color: Theme.of(context).iconTheme.color),
                      title: Text(
                        'Dark Mode',
                        style: TextStyle(
                          fontSize: width * .04,
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).textTheme.bodyMedium?.color,

                        ),
                      ),
                      trailing: Switch(
                        value: Provider.of<ThemeProvider>(context).isDarkMode,
                        onChanged: (v) => Provider.of<ThemeProvider>(context, listen: false).toggleTheme(v),
                        activeColor: Colors.blue,
                        activeTrackColor: Colors.blue[100],


                      ),
                    ),

                    // Privacy Policy Tile
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(Icons.privacy_tip_outlined, size: width * .06, color: Theme.of(context).iconTheme.color),
                      title: Text(
                        'Privacy Policy',
                        style: TextStyle(
                          fontSize: width * .04,
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).textTheme.bodyMedium?.color,
                        ),
                      ),
                      onTap: () {},
                    ),

                    // Settings Tile
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(Icons.settings_outlined, size: width * .06, color: Theme.of(context).iconTheme.color),
                      title: Text(
                        'Settings',
                        style: TextStyle(
                          fontSize: width * .04,
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).textTheme.bodyMedium?.color,
                        ),
                      ),
                      onTap: () {},
                    ),
                  ],
                ),
              ),

              // Notifications
              Container(
                width: width * .9,
                margin: EdgeInsets.only(top: width * .04),
                padding: EdgeInsets.all(width * .04),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: isDarkMode ? Colors.black.withOpacity(.5) : Colors.grey.withOpacity(.3),
                      spreadRadius: 2,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Notifications',
                      style: TextStyle(
                        fontSize: width * .045,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).textTheme.titleMedium?.color,

                      ),
                    ),

                    // Push Notifications Switch
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(Icons.notifications_none, size: width * .06, color: Theme.of(context).iconTheme.color),
                      title: Text(
                        'Push Notifications',
                        style: TextStyle(
                          fontSize: width * .04,
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).textTheme.bodyMedium?.color,
                        ),
                      ),
                      trailing: Switch(
                        value: pushNotifications,
                        onChanged: (v) => setState(() => pushNotifications = v),
                        activeColor: Colors.blue,
                        activeTrackColor: Colors.blue[100],


                      ),
                    ),

                    // Promotional Notifications Switch
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(Icons.notifications_none, size: width * .06, color: Theme.of(context).iconTheme.color),
                      title: Text(
                        'Promotional Notifications',
                        style: TextStyle(
                          fontSize: width * .04,
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).textTheme.bodyMedium?.color,
                        ),
                      ),
                      trailing: Switch(
                        value: promotionalNotifications,
                        onChanged: (v) => setState(() => promotionalNotifications = v),
                        activeColor: Colors.blue,
                        activeTrackColor: Colors.blue[100],


                      ),
                    ),
                  ],
                ),
              ),

              // More
              Container(
                width: width * .9,
                margin: EdgeInsets.only(top: width * .04, bottom: width * .04),
                padding: EdgeInsets.all(width * .04),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: isDarkMode ? Colors.black.withOpacity(.5) : Colors.grey.withOpacity(.3),
                      spreadRadius: 2,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'More',
                      style: TextStyle(
                        fontSize: width * .045,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).textTheme.titleMedium?.color,
                      ),
                    ),

                    // Help Center Tile
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(Icons.help_outline, size: width * .06, color: Theme.of(context).iconTheme.color),
                      title: Text(
                        'Help Center',
                        style: TextStyle(
                          fontSize: width * .04,
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).textTheme.bodyMedium?.color,
                        ),
                      ),
                      onTap: () {},
                    ),

                    // Log Out Tile
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(Icons.logout, size: width * .06, color: Colors.red),
                      title: Text(
                        'Log Out',
                        style: TextStyle(
                          fontSize: width * .04,
                          fontWeight: FontWeight.w400,
                          color: Colors.red,
                        ),
                      ),
                      onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginScreen())),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomBar(width),
    );
  }

  BottomAppBar _buildBottomBar(double width) {
    return BottomAppBar(
      color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
      shape: const CircularNotchedRectangle(),
      notchMargin: 8,
      child: SizedBox(
        height: 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BottonNavigationWidget(
              icon: Icons.home_filled,
              label: "Home",
              isSelected: selectedIndex == 0,
              onTap: () => _navigate(0, const HomeScreen()),
            ),
            BottonNavigationWidget(
              icon: Icons.wallet,
              label: "Wallet",
              isSelected: selectedIndex == 1,
              onTap: () {
                onItemTapped(1);
                // Add wallet screen if exists
              },
            ),
            BottonNavigationWidget(
              icon: Icons.history,
              label: "History",
              isSelected: selectedIndex == 2,
              onTap: () {
                onItemTapped(2);
                // Add history screen if exists
              },
            ),
            BottonNavigationWidget(
              icon: Icons.person,
              label: "Profile",
              isSelected: selectedIndex == 3,
              onTap: () => _navigate(3, const ProfileScreen()),
            ),
          ],
        ),
      ),
    );
  }
}
