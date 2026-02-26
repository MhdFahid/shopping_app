import 'package:flutter/material.dart';
import '../../utils/token_storage.dart';
import '../login/login_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Profile",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: const Color(0xFF7B3A00),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 20),
            const CircleAvatar(
              radius: 50,
              backgroundColor: Color(0xFFF5F5F5),
              child: Icon(Icons.person, size: 50, color: Color(0xFF7B3A00)),
            ),
            const SizedBox(height: 20),
            const Text(
              "User Account",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),
            _buildProfileItem(
              icon: Icons.person_outline,
              title: "Edit Profile",
              onTap: () {},
            ),
            _buildProfileItem(
              icon: Icons.shopping_bag_outlined,
              title: "My Orders",
              onTap: () {},
            ),
            _buildProfileItem(
              icon: Icons.location_on_outlined,
              title: "My Address",
              onTap: () {},
            ),
            _buildProfileItem(
              icon: Icons.settings_outlined,
              title: "Settings",
              onTap: () {},
            ),
            const Divider(height: 32),
            ListTile(
              leading: Image.asset(
                'assets/images/cat.png',
                width: 24,
                height: 24,
              ),
              title: const Text(
                "Logout",
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () => _handleLogout(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.grey[700]),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right, size: 20),
      onTap: onTap,
    );
  }

  Future<void> _handleLogout(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Logout"),
        content: const Text("Are you sure you want to logout?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Logout", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await TokenStorage.clearAuth();
      if (context.mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => LoginPage()),
          (route) => false,
        );
      }
    }
  }
}
