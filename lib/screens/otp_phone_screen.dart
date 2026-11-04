import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tugas_1_copy/models/ecowalk_profile.dart';

class PhoneOtpScreen extends StatefulWidget {
  const PhoneOtpScreen({
    super.key,
    this.destination,
    this.isContactUpdate = false,
  });

  final String? destination;
  final bool isContactUpdate;

  @override
  State<PhoneOtpScreen> createState() => _PhoneOtpScreenState();
}

class _PhoneOtpScreenState extends State<PhoneOtpScreen> {
  static const Color _primaryTheme = Color(0xFF1A6556);
  static const Color _headerBg = Color(0xFFDCE9E8);

  final List<TextEditingController> _otpControllers = List.generate(
    4,
    (_) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());

  @override
  void dispose() {
    for (final controller in _otpControllers) {
      controller.dispose();
    }
    for (final node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  Future<void> _submitOtp() async {
    final code = _otpControllers.map((c) => c.text).join();
    if (code.length == 4) {
      if (widget.isContactUpdate && widget.destination != null) {
        EcowalkProfile.instance.phone = widget.destination!;
        try {
          await EcowalkProfile.instance.save();
        } catch (_) {
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Nomor baru gagal disimpan pada perangkat ini.'),
            ),
          );
          return;
        }
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Nomor diperbarui lokal; verifikasi masih simulasi.'),
          ),
        );
        Navigator.pop(context, true);
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Simulasi OTP selesai. Kode belum diverifikasi oleh layanan server.',
          ),
          backgroundColor: _primaryTheme,
        ),
      );
      Navigator.pushReplacementNamed(context, '/profile');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Masukkan 4 digit kode verifikasi'),
          backgroundColor: Colors.orange,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildTopHeader(),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Badge Verifikasi
                    Row(
                      children: const [
                        Icon(
                          Icons.check_circle_outline,
                          size: 20,
                          color: _primaryTheme,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'VERIFIKASI',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.8,
                            color: _primaryTheme,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Keterangan nomor telepon
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.phone_android,
                          size: 28,
                          color: Colors.black87,
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text.rich(
                            TextSpan(
                              text: 'Kode simulasi (belum dikirim layanan) untuk ',
                              style: TextStyle(
                                fontSize: 13.5,
                                color: Colors.black87,
                              ),
                              children: [
                                TextSpan(
                                  text: widget.destination ?? '+629593599593',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 35),

                    // Kotak OTP 4 Digit
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(
                        4,
                        (index) => _buildOtpField(index),
                      ),
                    ),
                    const SizedBox(height: 28),

                    // Opsi alternatif tersedia pada alur registrasi.
                    if (!widget.isContactUpdate)
                      Align(
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushReplacementNamed(
                              context,
                              '/verificationWithEmail',
                              arguments: widget.isContactUpdate
                                  ? {
                                      'purpose': 'change_email',
                                      'target': widget.destination,
                                    }
                                  : null,
                            );
                          },
                          child: const Text(
                            'Verifikasi menggunakan Email',
                            style: TextStyle(
                              fontSize: 13.5,
                              color: Colors.cyan,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    if (!widget.isContactUpdate) const SizedBox(height: 28),

                    // Tombol Kirim
                    SizedBox(
                      height: 42,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _primaryTheme,
                          foregroundColor: Colors.white,
                          elevation: 1,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        onPressed: _submitOtp,
                        child: const Text(
                          'KIRIM',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.6,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Kirim ulang
                    Center(
                      child: InkWell(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Layanan kirim ulang OTP belum terhubung.',
                              ),
                              backgroundColor: _primaryTheme,
                            ),
                          );
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(6.0),
                          child: Text(
                            'Kirim Ulang Kode',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: _primaryTheme,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopHeader() {
    return SizedBox(
      height: 220,
      child: Stack(
        children: [
          ClipPath(
            clipper: _PhoneOtpHeaderClipper(),
            child: Container(height: 220, color: _headerBg),
          ),
          Positioned(
            top: 90,
            left: 0,
            right: 0,
            child: Center(child: _buildBrandedLogo()),
          ),
        ],
      ),
    );
  }

  Widget _buildBrandedLogo() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          'ECOWA',
          style: TextStyle(
            fontFamily: 'Kanit',
            fontSize: 38,
            fontWeight: FontWeight.w800,
            color: _primaryTheme,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2.0),
          child: SvgPicture.asset(
            'lib/assets/images/runner_green.svg',
            width: 42,
            height: 42,
          ),
        ),
        const Text(
          'K',
          style: TextStyle(
            fontFamily: 'Kanit',
            fontSize: 38,
            fontWeight: FontWeight.w800,
            color: _primaryTheme,
          ),
        ),
      ],
    );
  }

  Widget _buildOtpField(int index) {
    return SizedBox(
      width: 65,
      height: 65,
      child: TextFormField(
        controller: _otpControllers[index],
        focusNode: _focusNodes[index],
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        decoration: InputDecoration(
          counterText: '',
          filled: true,
          fillColor: Colors.grey.shade50,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: _primaryTheme, width: 2),
          ),
        ),
        onChanged: (value) {
          if (value.isNotEmpty) {
            if (index < 3) {
              _focusNodes[index + 1].requestFocus();
            } else {
              _focusNodes[index].unfocus();
            }
          } else if (value.isEmpty && index > 0) {
            _focusNodes[index - 1].requestFocus();
          }
        },
      ),
    );
  }
}

class _PhoneOtpHeaderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height * 0.45);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
