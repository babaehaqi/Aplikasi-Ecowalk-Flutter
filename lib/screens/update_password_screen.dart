import 'package:flutter/material.dart';

class UpdatePasswordScreen extends StatefulWidget {
  const UpdatePasswordScreen({super.key});

  @override
  State<UpdatePasswordScreen> createState() => _UpdatePasswordScreenState();
}

class _UpdatePasswordScreenState extends State<UpdatePasswordScreen> {
  static const _green = Color(0xFF1A6556);
  final _formKey = GlobalKey<FormState>();
  final _old = TextEditingController();
  final _new = TextEditingController();
  final _confirm = TextEditingController();
  bool _hideOld = true;
  bool _hideNew = true;
  bool _hideConfirm = true;

  @override
  void dispose() {
    _old.dispose();
    _new.dispose();
    _confirm.dispose();
    super.dispose();
  }

  Widget _field(
    String label,
    TextEditingController controller,
    bool hidden,
    VoidCallback toggle,
    String? Function(String?) validator,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: TextFormField(
        controller: controller,
        obscureText: hidden,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: const Icon(Icons.lock_outline),
          suffixIcon: IconButton(
            onPressed: toggle,
            icon: Icon(
              hidden
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
            ),
          ),
          border: const OutlineInputBorder(),
        ),
        validator: validator,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ubah Kata Sandi')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _field(
                  'Kata Sandi Lama',
                  _old,
                  _hideOld,
                  () => setState(() => _hideOld = !_hideOld),
                  (v) => v == null || v.isEmpty
                      ? 'Kata sandi lama wajib diisi'
                      : null,
                ),
                _field(
                  'Kata Sandi Baru',
                  _new,
                  _hideNew,
                  () => setState(() => _hideNew = !_hideNew),
                  (v) {
                    if (v == null || v.isEmpty) {
                      return 'Kata sandi baru wajib diisi';
                    }
                    if (v.length < 8) return 'Gunakan minimal 8 karakter';
                    if (v == _old.text) return 'Kata sandi baru harus berbeda';
                    return null;
                  },
                ),
                _field(
                  'Konfirmasi Kata Sandi',
                  _confirm,
                  _hideConfirm,
                  () => setState(() => _hideConfirm = !_hideConfirm),
                  (v) => v != _new.text
                      ? 'Konfirmasi kata sandi tidak sama'
                      : null,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, '/forpassNoHp'),
                    child: const Text('Lupa Kata Sandi?'),
                  ),
                ),
                const SizedBox(height: 12),
                FilledButton(
                  style: FilledButton.styleFrom(backgroundColor: _green),
                  onPressed: () {
                    if (!(_formKey.currentState?.validate() ?? false)) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Pemeriksaan lokal selesai. Kata sandi tidak disimpan oleh aplikasi.',
                        ),
                      ),
                    );
                    Navigator.pop(context);
                  },
                  child: const Text('UBAH'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
