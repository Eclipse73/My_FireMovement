import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'theme.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/tracker_screen.dart';
import 'screens/directory_screen.dart';
import 'screens/info_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));
  runApp(const MyFireMovementApp());
}

class MyFireMovementApp extends StatelessWidget {
  const MyFireMovementApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'My Fire Movement',
    debugShowCheckedModeBanner: false,
    theme: buildAppTheme(),
    home: const AuthGate(),
  );
}

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});
  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  bool _loggedIn = false;
  @override
  Widget build(BuildContext context) => _loggedIn
      ? MainShell(onLogout: () => setState(() => _loggedIn = false))
      : LoginScreen(onLogin: () => setState(() => _loggedIn = true));
}

class MainShell extends StatefulWidget {
  final VoidCallback onLogout;
  const MainShell({super.key, required this.onLogout});
  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _idx = 0;

  @override
  Widget build(BuildContext context) {
    final screens = [
      const HomeScreen(),
      const TrackerScreen(),
      const DirectoryScreen(),
      InfoScreen(onLogout: widget.onLogout),
    ];

    const items = [
      {'icon': Icons.home_rounded,      'label': 'Home'},
      {'icon': Icons.check_box_rounded, 'label': 'Tracker'},
      {'icon': Icons.grid_view_rounded, 'label': 'Ministry'},
      {'icon': Icons.info_rounded,      'label': 'Info'},
    ];

    return Scaffold(
      body: IndexedStack(index: _idx, children: screens),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: AppColors.border)),
          boxShadow: [BoxShadow(
            color: AppColors.navyMid.withOpacity(0.06),
            blurRadius: 16, offset: const Offset(0, -4))],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(items.length, (i) {
                final active = _idx == i;
                return GestureDetector(
                  onTap: () => setState(() => _idx = i),
                  behavior: HitTestBehavior.opaque,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
                    decoration: BoxDecoration(
                      color: active ? AppColors.brandLight : Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(items[i]['icon'] as IconData,
                          color: active ? AppColors.brand : AppColors.gray, size: 24),
                        const SizedBox(height: 3),
                        Text(items[i]['label'] as String,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 10,
                            fontWeight: active ? FontWeight.w800 : FontWeight.w500,
                            color: active ? AppColors.brand : AppColors.gray)),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
