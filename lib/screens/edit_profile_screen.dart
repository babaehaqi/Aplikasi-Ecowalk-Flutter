import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tugas_1_copy/models/ecowalk_profile.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  static const _green = Color(0xFF1A6556);
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _name.text = EcowalkProfile.instance.name;
  }

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  Future<void> _choosePhoto(ImageSource source) async {
    try {
      final image = await _picker.pickImage(
        source: source,
        imageQuality: 85,
        maxWidth: 512,
        maxHeight: 512,
      );
      if (image != null) {
        final bytes = await image.readAsBytes();
        if (!mounted) return;
        EcowalkProfile.instance.photoBytes = bytes;
        await EcowalkProfile.instance.save();
        if (!mounted) return;
        setState(() {});
      }
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Foto tidak dapat dipilih atau disimpan di perangkat ini.',
          ),
        ),
      );
    }
  }

  Future<void> _showPhotoOptions() async {
    await showModalBottomSheet<void>(
      context: context,
      builder: (context) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library_outlined),
              title: const Text('Pilih dari Galeri'),
              onTap: () {
                Navigator.pop(context);
                _choosePhoto(ImageSource.gallery);
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt_outlined),
              title: const Text('Ambil Foto'),
              onTap: () {
                Navigator.pop(context);
                _choosePhoto(ImageSource.camera);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _save() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    EcowalkProfile.instance.name = _name.text.trim();
    try {
      await EcowalkProfile.instance.save();
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Perubahan profil gagal disimpan pada perangkat ini.'),
        ),
      );
      return;
    }
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Profil disimpan pada perangkat ini.')),
    );
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    final photo = EcowalkProfile.instance.photoBytes;
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Profile')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 18),
                Center(
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 58,
                        backgroundColor: const Color(0xFFDCE9E8),
                        backgroundImage: photo == null
                            ? null
                            : MemoryImage(photo),
                        child: photo == null
                            ? const Icon(Icons.person, size: 64, color: _green)
                            : null,
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: IconButton.filled(
                          onPressed: _showPhotoOptions,
                          icon: const Icon(Icons.camera_alt_outlined),
                          style: IconButton.styleFrom(backgroundColor: _green),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 34),
                TextFormField(
                  controller: _name,
                  textCapitalization: TextCapitalization.words,
                  decoration: const InputDecoration(
                    labelText: 'Nama Pengguna',
                    prefixIcon: Icon(Icons.person_outline),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => value == null || value.trim().isEmpty
                      ? 'Nama pengguna tidak boleh kosong'
                      : null,
                ),
                const SizedBox(height: 28),
                FilledButton(
                  style: FilledButton.styleFrom(backgroundColor: _green),
                  onPressed: _save,
                  child: const Text('SIMPAN'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
