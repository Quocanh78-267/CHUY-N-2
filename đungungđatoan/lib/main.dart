import 'package:flutter/material.dart';
import 'app_state.dart';
import 'screens/auth/login_page.dart';
import 'screens/home_page.dart';
import 'screens/orders_page.dart';
import 'widgets/nav_item_button.dart';

void main() {
  runApp(const FoodDeliveryApp());
}

class FoodDeliveryApp extends StatelessWidget {
  const FoodDeliveryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ứng dụng giao đồ ăn',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Arial',
        scaffoldBackgroundColor: const Color(0xFFF7F5EE),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFCDEAAF),
        ),
      ),
      home: const AppEntry(),
    );
  }
}

class AppEntry extends StatefulWidget {
  const AppEntry({super.key});

  @override
  State<AppEntry> createState() => _AppEntryState();
}

class _AppEntryState extends State<AppEntry> {
  final AppState appState = AppState();

  @override
  Widget build(BuildContext context) {
    if (!appState.isLoggedIn) {
      return LoginPage(
        appState: appState,
        onLoginSuccess: () {
          setState(() {});
        },
      );
    }

    return MainScreen(
      appState: appState,
      onLogout: () {
        setState(() {});
      },
    );
  }
}

class MainScreen extends StatefulWidget {
  final AppState appState;
  final VoidCallback onLogout;

  const MainScreen({
    super.key,
    required this.appState,
    required this.onLogout,
  });

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomePage(
        appState: widget.appState,
        onGoOrders: () {
          setState(() {
            currentIndex = 1;
          });
        },
        onStateChanged: () {
          setState(() {});
        },
      ),
      OrdersPage(
        appState: widget.appState,
        onStateChanged: () {
          setState(() {});
        },
      ),
      const PlaceholderScreen(title: 'Tìm kiếm'),
      const PlaceholderScreen(title: 'Yêu thích'),
      ProfileScreen(
        appState: widget.appState,
        onLogout: () {
          widget.appState.logout();
          widget.onLogout();
        },
      ),
    ];

    return Scaffold(
      body: SafeArea(child: pages[currentIndex]),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
          child: Container(
            height: 66,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(33),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                NavItemButton(
                  icon: Icons.home_outlined,
                  label: 'Trang chủ',
                  selected: currentIndex == 0,
                  onTap: () {
                    setState(() {
                      currentIndex = 0;
                    });
                  },
                ),
                NavItemButton(
                  icon: Icons.shopping_cart_outlined,
                  label: 'Đơn hàng',
                  selected: currentIndex == 1,
                  onTap: () {
                    setState(() {
                      currentIndex = 1;
                    });
                  },
                ),
                NavItemButton(
                  icon: Icons.search,
                  label: 'Tìm kiếm',
                  selected: currentIndex == 2,
                  onTap: () {
                    setState(() {
                      currentIndex = 2;
                    });
                  },
                ),
                NavItemButton(
                  icon: Icons.bookmark_border,
                  label: 'Đã lưu',
                  selected: currentIndex == 3,
                  onTap: () {
                    setState(() {
                      currentIndex = 3;
                    });
                  },
                ),
                NavItemButton(
                  icon: Icons.person_outline,
                  label: 'Tài khoản',
                  selected: currentIndex == 4,
                  onTap: () {
                    setState(() {
                      currentIndex = 4;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PlaceholderScreen extends StatelessWidget {
  final String title;

  const PlaceholderScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  final AppState appState;
  final VoidCallback onLogout;

  const ProfileScreen({
    super.key,
    required this.appState,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    final user = appState.currentUser;

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          const SizedBox(height: 30),
          const CircleAvatar(
            radius: 42,
            backgroundColor: Color(0xFFCDEAAF),
            child: Icon(
              Icons.person,
              size: 42,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            user?.fullName ?? 'Người dùng',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            user?.email ?? '',
            style: const TextStyle(
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 28),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(22),
            ),
            child: Column(
              children: [
                _profileRow('Họ tên', user?.fullName ?? ''),
                const Divider(),
                _profileRow('Email', user?.email ?? ''),
                const Divider(),
                _profileRow(
                  'Số đơn đã tạo',
                  appState.orderHistory.length.toString(),
                ),
              ],
            ),
          ),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            height: 56,
            child: FilledButton(
              onPressed: onLogout,
              style: FilledButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
              child: const Text('Đăng xuất'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _profileRow(String label, String value) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
        Text(value),
      ],
    );
  }
}