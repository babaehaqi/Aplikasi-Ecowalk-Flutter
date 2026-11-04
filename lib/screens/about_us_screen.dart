import 'package:flutter/material.dart';
import 'package:tugas_1_copy/widgets/ecowalk_info_widgets.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  Widget _buildBulletItem(String text) => EcoWalkBulletItem(text: text);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: ecoWalkInfoAppBar(context, 'Tentang Kami'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Align(alignment: Alignment.topRight, child: EcoWalkLogo()),
            const SizedBox(height: 12),
            const Text(
              'ECOWALK adalah aplikasi wisata yang membantu pengguna menemukan destinasi terbaik dengan rekomendasi berdasarkan lokasi, perbandingan harga, serta informasi transportasi.',
              style: TextStyle(
                color: ecoWalkPrimaryText,
                fontSize: 14,
                height: 1.5,
              ),
            ),
            const EcoWalkSectionHeading('Misi Kami', underlined: true),
            const Text(
              'Menyediakan pengalaman wisata yang lebih mudah, informatif, dan terjangkau bagi semua orang dengan fokus pada ekowisata yang ramah lingkungan.',
              style: TextStyle(
                color: ecoWalkPrimaryText,
                fontSize: 14,
                height: 1.5,
              ),
            ),
            const EcoWalkSectionHeading('Apa yang Kami Tawarkan?'),
            _buildBulletItem(
              'Rekomendasi tempat wisata berdasarkan lokasi dan preferensi Anda.',
            ),
            _buildBulletItem(
              'Informasi harga tiket, ketersediaan fasilitas, dan ulasan pengguna.',
            ),
            _buildBulletItem(
              'Peta interaktif untuk membantu navigasi di area wisata.',
            ),
            _buildBulletItem(
              'Perbandingan harga transportasi untuk perjalanan yang lebih hemat.',
            ),
            const SizedBox(height: 8),
            const Text(
              'Kami percaya bahwa menjelajahi dunia harus menjadi pengalaman yang menyenangkan dan mudah diakses oleh semua orang, dengan tetap menjaga kelestarian lingkungan.',
              style: TextStyle(
                color: ecoWalkPrimaryText,
                fontSize: 14,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Untuk pertanyaan atau saran, hubungi kami di:',
              style: TextStyle(
                color: ecoWalkPrimaryText,
                fontSize: 14,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 8),
            const _ContactRow(icon: Icons.email, text: 'support@ecowalk.com'),
            const SizedBox(height: 6),
            const _ContactRow(icon: Icons.phone, text: '0899-1234-4567'),
          ],
        ),
      ),
    );
  }
}

class _ContactRow extends StatelessWidget {
  const _ContactRow({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 2),
        Icon(icon, size: 18, color: ecoWalkTeal),
        const SizedBox(width: 10),
        Text(
          text,
          style: const TextStyle(color: ecoWalkPrimaryText, fontSize: 14),
        ),
      ],
    );
  }
}
