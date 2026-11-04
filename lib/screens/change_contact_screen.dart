import 'package:flutter/material.dart';

class ChangeContactScreen extends StatefulWidget {
  const ChangeContactScreen({super.key, required this.isPhone});

  final bool isPhone;

  @override
  State<ChangeContactScreen> createState() => _ChangeContactScreenState();
}

class _ChangeContactScreenState extends State<ChangeContactScreen> {
  static const _green = Color(0xFF1A6556);
  final _formKey = GlobalKey<FormState>();
  final _value = TextEditingController();

  @override
  void dispose() {
    _value.dispose();
    super.dispose();
  }

  String get _label => widget.isPhone ? 'Nomor HP' : 'Email';

  String? _validate(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return '$_label baru tidak boleh kosong';
    if (widget.isPhone) {
      final digits = text.replaceAll(RegExp(r'[+\s()-]'), '');
      if (!RegExp(r'^\d{10,15}$').hasMatch(digits)) {
        return 'Masukkan nomor telepon yang valid (10–15 digit)';
      }
    } else if (!RegExp(r'^[\w.+-]+@[\w-]+(\.[\w-]+)+$').hasMatch(text)) {
      return 'Format email tidak valid';
    }
    return null;
  }

  void _send() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    final route = widget.isPhone
        ? '/verificationWithNoHP'
        : '/verificationWithEmail';
    Navigator.pushNamed(
      context,
      route,
      arguments: {
        'purpose': widget.isPhone ? 'change_phone' : 'change_email',
        'target': _value.text.trim(),
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final phone = widget.isPhone;
    return Scaffold(
      appBar: AppBar(title: Text('Ubah ${phone ? 'Nomor HP' : 'Email'}')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 22),
                Text(
                  'Masukan ${phone ? 'Nomor HP' : 'Email'} Baru',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 18),
                TextFormField(
                  controller: _value,
                  keyboardType: phone
                      ? TextInputType.phone
                      : TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: phone
                        ? 'Contoh: 081234567890'
                        : 'nama@domain.com',
                    prefixIcon: Icon(
                      phone ? Icons.phone_outlined : Icons.email_outlined,
                    ),
                    border: const OutlineInputBorder(),
                  ),
                  validator: _validate,
                ),
                const SizedBox(height: 26),
                FilledButton(
                  style: FilledButton.styleFrom(backgroundColor: _green),
                  onPressed: _send,
                  child: const Text('KIRIM'),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Kode verifikasi tidak dikirim karena aplikasi belum terhubung ke layanan OTP.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black54, fontSize: 12),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
