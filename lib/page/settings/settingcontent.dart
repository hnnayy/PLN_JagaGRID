import 'package:flutter/material.dart';
import 'layoutsetting.dart';

// File: lib/page/settings/tambahuser.dart
class SettingsContent {
  static List<SettingsItem> getSettingsItems() {
    return [
      const SettingsItem(
        title: 'Profile',
        iconPath: 'assets/icons/profile.png',
      ),
      const SettingsItem(
        title: 'Settings Content',
        iconPath: 'assets/icons/add.png',
      ),
      const SettingsItem(
        title: 'Assets JTM',
        iconPath: 'assets/icons/powerline.png',
      ),
      const SettingsItem(
        title: 'Logout',
        iconPath: 'assets/icons/logout.png',
      ),
    ];
  }

  static void handleSettingsTap(int index, BuildContext context) {
    switch (index) {
      case 0:
        // Handle Profile tap
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ProfilePage()),
        );
        break;
      case 1:
        // Handle Settings Content tap
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SettingsContentPage()),
        );
        break;
      case 2:
        // Handle Assets JTM tap
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AssetsJTMPage()),
        );
        break;
      case 3:
        // Handle Logout tap
        _showLogoutDialog(context);
        break;
    }
  }

  static void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Apakah Anda yakin ingin keluar?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Implement logout logic here
                // Example: Navigator.pushReplacementNamed(context, '/login');
              },
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );
  }
}

// Main Settings Page
class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  int _selectedIndex = 4; // Assuming settings is the 5th tab (index 4)

  final List<Widget> _widgetOptions = [
    const HomePage(),
    const Page2(),
    const Page3(),
    const Page4(),
    const SettingsMainContent(), // This page
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFE8FBF9),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -1),
            ),
          ],
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedItemColor: const Color(0xFF0B5F6D),
          unselectedItemColor: Colors.black,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.public),
              label: 'Page2',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart),
              label: 'Page3',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications_none),
              label: 'Page4',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              label: 'Page5',
            ),
          ],
        ),
      ),
    );
  }
}

// Settings Main Content Widget
class SettingsMainContent extends StatelessWidget {
  const SettingsMainContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SettingsLayout(
      settingsItems: SettingsContent.getSettingsItems(),
      onItemTap: (index) => SettingsContent.handleSettingsTap(index, context),
    );
  }
}

// Placeholder pages - replace with your actual pages
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Home Page'));
  }
}

class Page2 extends StatelessWidget {
  const Page2({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Page 2'));
  }
}

class Page3 extends StatelessWidget {
  const Page3({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Page 3'));
  }
}

class Page4 extends StatelessWidget {
  const Page4({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Page 4'));
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: const Center(child: Text('Profile Page')),
    );
  }
}

class SettingsContentPage extends StatelessWidget {
  const SettingsContentPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings Content')),
      body: const Center(child: Text('Settings Content Page')),
    );
  }
}

class AssetsJTMPage extends StatelessWidget {
  const AssetsJTMPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Assets JTM')),
      body: const Center(child: Text('Assets JTM Page')),
    );
  }
}