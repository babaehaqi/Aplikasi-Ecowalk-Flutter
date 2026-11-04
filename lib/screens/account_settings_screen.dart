import 'package:flutter/material.dart';

class AccountSettingsScreen extends StatelessWidget {
  const AccountSettingsScreen({super.key});

  static const _green = Color(0xFF1A6556);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pengaturan Akun')),
      body: ListView(
        children: [
          _item(context, Icons.person_outline, 'Edit Profile', '/edit_profile'),
          _item(
            context,
            Icons.phone_outlined,
            'Ubah Nomor HP',
            '/change_phone',
          ),
          _item(context, Icons.email_outlined, 'Ubah Email', '/change_email'),
          _item(
            context,
            Icons.lock_outline,
            'Ubah Kata Sandi',
            '/change_password',
          ),
          _item(context, Icons.delete_outline, 'Hapus Akun', '/delete_account'),
          _item(
            context,
            Icons.description_outlined,
            'Syarat & Ketentuan',
            '/terms',
          ),
        ],
      ),
    );
  }

  Widget _item(
    BuildContext context,
    IconData icon,
    String title,
    String route,
  ) {
    return ListTile(
      leading: Icon(icon, color: _green),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right),
      onTap: () => Navigator.pushNamed(context, route),
    );
  }
}
