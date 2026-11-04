import 'package:flutter/material.dart';
import 'package:tugas_1_copy/models/ecowalk_profile.dart';
import 'package:tugas_1_copy/widgets/ecowalk_alert_dialog.dart';

class DeleteAccountScreen extends StatefulWidget {
  const DeleteAccountScreen({super.key});

  @override
  State<DeleteAccountScreen> createState() => _DeleteAccountScreenState();
}

class _DeleteAccountScreenState extends State<DeleteAccountScreen> {
  static const _danger = Color(0xFFE92329);
  static const _warningBackground = Color(0xFFFFE3E3);
  final _formKey = GlobalKey<FormState>();
  final _password = TextEditingController();
  bool _hidePassword = true;
  bool _showWarning = true;

  @override
  void dispose() {
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'HAPUS AKUN',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Color(0xFF333333),
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 20, 24, 28),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _password,
                  obscureText: _hidePassword,
                  decoration: InputDecoration(
                    labelText: 'Kata Sandi',
                    hintText: 'Masukkan Kata Sandi',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 16,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(3),
                      borderSide: const BorderSide(color: _danger, width: 1.4),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(3),
                      borderSide: const BorderSide(color: _danger, width: 1.8),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(3),
                      borderSide: const BorderSide(color: _danger),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(3),
                      borderSide: const BorderSide(color: _danger, width: 1.8),
                    ),
                    suffixIcon: IconButton(
                      onPressed: () =>
                          setState(() => _hidePassword = !_hidePassword),
                      icon: Icon(
                        _hidePassword
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  validator: (value) => value == null || value.isEmpty
                      ? 'Kata sandi wajib diisi'
                      : null,
                ),
                if (_showWarning) ...[
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 8, 6, 8),
                    decoration: BoxDecoration(
                      color: _warningBackground,
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.error_outline,
                          color: _danger,
                          size: 19,
                        ),
                        const SizedBox(width: 8),
                        const Expanded(
                          child: Text(
                            'Penghapusan akun bersifat permanen. Pada prototipe ini, penghapusan belum terhubung ke layanan akun.',
                            style: TextStyle(fontSize: 11, height: 1.3),
                          ),
                        ),
                        IconButton(
                          visualDensity: VisualDensity.compact,
                          constraints: const BoxConstraints.tightFor(
                            width: 30,
                            height: 30,
                          ),
                          onPressed: () => setState(() => _showWarning = false),
                          icon: const Icon(Icons.close, size: 17),
                        ),
                      ],
                    ),
                  ),
                ],
                const SizedBox(height: 26),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 88,
                      height: 32,
                      child: FilledButton(
                        onPressed: _confirmDeletion,
                        style: FilledButton.styleFrom(
                          backgroundColor: _danger,
                          foregroundColor: Colors.white,
                          minimumSize: const Size(88, 32),
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        child: const Text('Hapus'),
                      ),
                    ),
                    const SizedBox(width: 20),
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.black87,
                        textStyle: const TextStyle(fontSize: 15),
                      ),
                      child: const Text('Batal'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _confirmDeletion() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    final confirmed = await EcoWalkAlertDialog.show(
      context,
      title: 'Hapus akun?',
      message: 'Tindakan ini bersifat permanen. Pada prototipe ini kata sandi tidak diverifikasi dan akun maupun data tidak akan benar-benar dihapus.',
      confirmText: 'Lanjut',
      confirmColor: _danger,
    );
    if (confirmed != true || !mounted) return;

    EcowalkProfile.instance.accountDeletionRequested = true;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Simulasi selesai. Akun dan data Anda belum dihapus.'),
      ),
    );
    Navigator.pop(context);
  }
}
