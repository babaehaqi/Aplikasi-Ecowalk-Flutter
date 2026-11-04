import 'package:flutter/material.dart';
import 'package:tugas_1_copy/widgets/ecowalk_info_widgets.dart';

class TermsOfServiceScreen extends StatelessWidget {
  const TermsOfServiceScreen({super.key});

  Widget _buildBulletItem(String text) => EcoWalkBulletItem(text: text);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: ecoWalkInfoAppBar(context, 'Ketentuan Layanan'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'KETENTUAN PENGGUNAAN APLIKASI ECOWALK',
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
              'Selamat datang di ECOWALK! Dengan menggunakan aplikasi ini, Anda setuju dengan ketentuan dan persyaratan berikut:',
              style: TextStyle(
                color: ecoWalkPrimaryText,
                fontSize: 14,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 14),
            const Text(
              '1. Dengan menggunakan aplikasi ECOWALK, Anda dapat menemukan informasi tentang tempat wisata, rekomendasi tempat, perbandingan harga, dan layanan peta berbasis lokasi.',
              style: TextStyle(
                color: ecoWalkPrimaryText,
                fontSize: 14,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              '2. Anda bertanggung jawab atas keakuratan data, termasuk ulasan dan foto, yang Anda masukkan.',
              style: TextStyle(
                color: ecoWalkPrimaryText,
                fontSize: 14,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              '3. Perubahan Layanan ECOWALK berhak mengubah, menambah, atau menghentikan layanan tanpa pemberitahuan sebelumnya. Pengguna bertanggung jawab atas keamanan akun mereka, termasuk kata sandi. Pengguna juga dilarang menggunakan aplikasi untuk tujuan yang dapat merugikan pihak lain. Informasi yang diberikan oleh sumber seperti tiket atau biaya transportasi tidak akurat, dan kami tidak bertanggung jawab atas kesalahan tersebut.',
              style: TextStyle(
                color: ecoWalkPrimaryText,
                fontSize: 14,
                height: 1.5,
              ),
            ),
            const EcoWalkSectionHeading('4. Penolakan Tanggung Jawab'),
            _buildBulletItem(
              'ECOWALK hanya menyediakan informasi sebagai referensi dan bukan penyedia layanan wisata atau transportasi.',
            ),
            _buildBulletItem(
              'Kami tidak bertanggung jawab atas perubahan harga, ketersediaan tempat, atau keterlambatan transportasi.',
            ),
            const SizedBox(height: 10),
            const Text(
              'Dengan menggunakan aplikasi ini, Anda menyetujui semua ketentuan di atas.',
              style: TextStyle(
                color: ecoWalkPrimaryText,
                fontSize: 14,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TermsScreen extends TermsOfServiceScreen {
  const TermsScreen({super.key});
}
