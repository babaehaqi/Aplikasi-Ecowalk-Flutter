import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tugas_1_copy/models/ecowalk_profile.dart';

class EmailOtpScreen extends StatefulWidget {
  const EmailOtpScreen({
    super.key,
    this.destination,
    this.isContactUpdate = false,
  });

  final String? destination;
  final bool isContactUpdate;

  @override
  State<EmailOtpScreen> createState() => _EmailOtpScreenState();
}

class _EmailOtpScreenState extends State<EmailOtpScreen> {
  static const Color _brandTeal = Color(0xFF1A6556);
  static const Color _topBackground = Color(0xFFDCE9E8);

  final List<TextEditingController> _codeControllers = List.generate(
    4,
    (_) => TextEditingController(),
  );
  final List<FocusNode> _digitFocusNodes = List.generate(4, (_) => FocusNode());

  @override
  void dispose() {
    for (final controller in _codeControllers) {
      controller.dispose();
    }
    for (final node in _digitFocusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  Future<void> _onConfirmOtp() async {
    final otp = _codeControllers.map((c) => c.text).join();
    if (otp.length == 4) {
      if (widget.isContactUpdate && widget.destination != null) {
        EcowalkProfile.instance.email = widget.destination!;
        try {
          await EcowalkProfile.instance.save();
        } catch (_) {
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Email baru gagal disimpan pada perangkat ini.'),
            ),
          );
          return;
        }
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Email diperbarui lokal; verifikasi masih simulasi.'),
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
          backgroundColor: _brandTeal,
        ),
      );
      Navigator.pushReplacementNamed(context, '/profile');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Silakan lengkapi 4 digit kode OTP'),
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
              _buildCurvedHeader(),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Status Tag
                    Row(
                      children: const [
                        Icon(
                          Icons.check_circle_outline,
                          size: 20,
                          color: _brandTeal,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'VERIFIKASI',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.8,
                            color: _brandTeal,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Information section
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.mark_email_read_outlined,
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
                                  text: widget.destination ?? 'test@gmail.com',
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

                    // 4 Digit OTP inputs
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(4, (i) => _buildDigitInput(i)),
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
                              '/verificationWithNoHP',
                              arguments: widget.isContactUpdate
                                  ? {
                                      'purpose': 'change_phone',
                                      'target': widget.destination,
                                    }
                                  : null,
                            );
                          },
                          child: const Text(
                            'Verifikasi menggunakan No. HP',
                            style: TextStyle(
                              fontSize: 13.5,
                              color: Colors.cyan,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    if (!widget.isContactUpdate) const SizedBox(height: 28),

                    // Submit Button
                    SizedBox(
                      height: 42,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _brandTeal,
                          foregroundColor: Colors.white,
                          elevation: 1,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        onPressed: _onConfirmOtp,
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

                    // Resend code
                    Center(
                      child: InkWell(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Layanan kirim ulang OTP belum terhubung.',
                              ),
                              backgroundColor: _brandTeal,
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
                              color: _brandTeal,
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

  Widget _buildCurvedHeader() {
    return SizedBox(
      height: 220,
      child: Stack(
        children: [
          ClipPath(
            clipper: _EmailOtpHeaderClipper(),
            child: Container(height: 220, color: _topBackground),
          ),
          Positioned(
            top: 90,
            left: 0,
            right: 0,
            child: Center(child: _buildHeaderLogo()),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderLogo() {
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
            color: _brandTeal,
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
            color: _brandTeal,
          ),
        ),
      ],
    );
  }

  Widget _buildDigitInput(int index) {
    return SizedBox(
      width: 65,
      height: 65,
      child: TextFormField(
        controller: _codeControllers[index],
        focusNode: _digitFocusNodes[index],
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
            borderSide: const BorderSide(color: _brandTeal, width: 2),
          ),
        ),
        onChanged: (text) {
          if (text.isNotEmpty) {
            if (index < 3) {
              _digitFocusNodes[index + 1].requestFocus();
            } else {
              _digitFocusNodes[index].unfocus();
            }
          } else if (text.isEmpty && index > 0) {
            _digitFocusNodes[index - 1].requestFocus();
          }
        },
      ),
    );
  }
}

class _EmailOtpHeaderClipper extends CustomClipper<Path> {
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
