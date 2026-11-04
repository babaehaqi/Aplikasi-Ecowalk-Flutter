import 'package:flutter/material.dart';
import 'package:tugas_1_copy/models/ecowalk_profile.dart';
import 'package:tugas_1_copy/widgets/ecowalk_bottom_nav.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  static const Color _primaryThemeColor = Color(0xFF1A6556);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildProfileHeader(context),
            const SizedBox(height: 35),
            Expanded(child: _buildMenuList(context)),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(context),
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
    return SizedBox(
      height: 220,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Background top band
          Container(
            width: double.infinity,
            height: 96,
            color: _primaryThemeColor,
          ),

          // User Avatar
          Positioned(
            top: 36,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: 120,
                height: 120,
                padding: const EdgeInsets.all(3),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: CircleAvatar(
                  backgroundImage: EcowalkProfile.instance.photoBytes != null
                      ? MemoryImage(EcowalkProfile.instance.photoBytes!)
                      : const AssetImage('lib/assets/images/profile.png'),
                  onBackgroundImageError: (_, _) {},
                ),
              ),
            ),
          ),

          // Display Name
          Positioned(
            top: 162,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                EcowalkProfile.instance.name,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: Colors.black87,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),

          // Email Pill
          Positioned(
            top: 196,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: _primaryThemeColor,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  EcowalkProfile.instance.email,
                  style: TextStyle(
                    fontSize: 11.5,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuList(BuildContext context) {
    final menuItems = [
      _ProfileItemData(
        icon: Icons.settings_outlined,
        title: 'Pengaturan',
        onTap: () =>
            Navigator.pushNamed(context, '/account_settings').then((_) {
              if (mounted) setState(() {});
            }),
      ),
      _ProfileItemData(
        icon: Icons.edit_outlined,
        title: 'Edit Profil',
        onTap: () => Navigator.pushNamed(context, '/edit_profile').then((_) {
          if (mounted) setState(() {});
        }),
      ),
      _ProfileItemData(
        icon: Icons.lock_outline,
        title: 'Kebijakan Privasi',
        onTap: () => Navigator.pushNamed(context, '/privacy'),
      ),
      _ProfileItemData(
        icon: Icons.info_outline,
        title: 'Tentang Kami',
        onTap: () => Navigator.pushNamed(context, '/about'),
      ),
      _ProfileItemData(
        icon: Icons.description_outlined,
        title: 'Ketentuan Layanan',
        onTap: () => Navigator.pushNamed(context, '/terms'),
      ),
      _ProfileItemData(
        icon: Icons.logout,
        title: 'Keluar',
        onTap: () => _confirmLogout(context),
      ),
    ];

    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: menuItems.length,
      separatorBuilder: (context, index) =>
          Divider(height: 1, thickness: 0.8, color: Colors.grey.shade200),
      itemBuilder: (context, index) {
        final item = menuItems[index];
        return ListTile(
          dense: true,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 4,
            vertical: 2,
          ),
          leading: Icon(item.icon, size: 26, color: Colors.black87),
          title: Text(
            item.title,
            style: const TextStyle(
              fontSize: 15.5,
              fontWeight: FontWeight.w400,
              color: Colors.black87,
            ),
          ),
          trailing: const Icon(
            Icons.chevron_right,
            size: 24,
            color: Colors.black54,
          ),
          onTap: item.onTap,
        );
      },
    );
  }

  Future<void> _confirmLogout(BuildContext context) async {
    final shouldLogout = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 22, 24, 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Keluar?',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 7),
              const Text(
                'Apakah Kamu Yakin Ingin Keluar?',
                style: TextStyle(fontSize: 13, color: Colors.black87),
              ),
              const SizedBox(height: 18),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FilledButton(
                    onPressed: () => Navigator.pop(dialogContext, false),
                    style: FilledButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: _primaryThemeColor,
                      minimumSize: const Size(88, 32),
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: const Text('Batal'),
                  ),
                  const SizedBox(width: 12),
                  OutlinedButton(
                    onPressed: () => Navigator.pop(dialogContext, true),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: _primaryThemeColor,
                      minimumSize: const Size(88, 32),
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      side: const BorderSide(
                        color: _primaryThemeColor,
                        width: 1.5,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: const Text('Keluar'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );

    if (shouldLogout == true && context.mounted) {
      Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
    }
  }

  Widget _buildBottomNav(BuildContext context) {
    return EcoWalkBottomNav(
      selectedIndex: 3,
      onTap: (index) {
        if (index == 0) {
          Navigator.pushReplacementNamed(context, '/home');
        } else if (index == 1) {
          Navigator.pushReplacementNamed(context, '/recommendations');
        } else if (index == 2) {
          Navigator.pushReplacementNamed(context, '/community');
        }
      },
    );
  }
}

class _ProfileItemData {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _ProfileItemData({
    required this.icon,
    required this.title,
    required this.onTap,
  });
}
