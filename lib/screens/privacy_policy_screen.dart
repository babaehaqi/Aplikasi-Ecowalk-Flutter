import 'package:flutter/material.dart';
import 'package:tugas_1_copy/widgets/ecowalk_info_widgets.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  Widget _buildBulletItem(String text) => EcoWalkBulletItem(text: text);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: ecoWalkInfoAppBar(context, 'Kebijakan Privasi'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'KEBIJAKAN PRIVASI APLIKASI ECOWALK',
              style: TextStyle(
                color: ecoWalkPrimaryText,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                height: 1.35,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Diperbaharui tanggal 16 Februari 2024',
              style: TextStyle(
                color: ecoWalkSecondaryText,
                fontSize: 13,
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 18),
            const Text(
              'Kami menghargai privasi pengguna. Kebijakan ini menjelaskan bagaimana ECOWALK mengumpulkan, menggunakan, dan melindungi data Anda.',
              style: TextStyle(
                color: ecoWalkPrimaryText,
                fontSize: 14,
                height: 1.5,
              ),
            ),
            const EcoWalkSectionHeading('1. Data yang Kami Kumpulkan'),
            const Text(
              'Kami dapat mengumpulkan data berikut:',
              style: TextStyle(
                color: ecoWalkPrimaryText,
                fontSize: 14,
                height: 1.45,
              ),
            ),
            _buildBulletItem('Data Pribadi: Nama, email, dan informasi akun.'),
            _buildBulletItem(
              'Data Lokasi: Untuk memberikan rekomendasi wisata dan perhitungan jarak.',
            ),
            _buildBulletItem(
              'Ulasan dan Foto: Jika Anda memposting ulasan atau berbagi pengalaman wisata.',
            ),
            const EcoWalkSectionHeading('2. Cara Kami Menggunakan Data'),
            _buildBulletItem(
              'Memberikan rekomendasi tempat wisata berdasarkan lokasi.',
            ),
            _buildBulletItem(
              'Memproses pencarian dan filter destinasi sesuai preferensi.',
            ),
            _buildBulletItem(
              'Menampilkan ulasan dan foto yang dibagikan pengguna lain.',
            ),
            _buildBulletItem(
              'Menyediakan informasi transportasi berdasarkan data lokasi.',
            ),
            const EcoWalkSectionHeading('3. Keamanan Data'),
            const Text(
              'Kami menggunakan enkripsi dan metode keamanan lainnya untuk melindungi data Anda.',
              style: TextStyle(
                color: ecoWalkPrimaryText,
                fontSize: 14,
                height: 1.5,
              ),
            ),
            const EcoWalkSectionHeading('4. Hak Pengguna'),
            _buildBulletItem(
              'Anda dapat memperbarui atau menghapus informasi akun kapan saja.',
            ),
            _buildBulletItem(
              'Anda dapat menonaktifkan fitur lokasi jika tidak ingin berbagi data lokasi.',
            ),
            _buildBulletItem(
              'Kami tidak akan membagikan data pribadi Anda kepada pihak ketiga tanpa izin Anda.',
            ),
          ],
        ),
      ),
    );
  }
}
