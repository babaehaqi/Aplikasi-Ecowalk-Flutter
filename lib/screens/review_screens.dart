import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../models/destination.dart';
import '../models/ecowalk_profile.dart';
import '../widgets/ecowalk_info_widgets.dart';

class WriteReviewScreen extends StatefulWidget {
  const WriteReviewScreen({super.key, required this.destination});
  final Destination destination;

  @override
  State<WriteReviewScreen> createState() => _WriteReviewScreenState();
}

class _WriteReviewScreenState extends State<WriteReviewScreen> {
  final _reviewController = TextEditingController();
  final _picker = ImagePicker();
  XFile? _photo;
  int _rating = 0;
  bool _hideName = false;

  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }

  Future<void> _pickPhoto() async {
    final image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null && mounted) setState(() => _photo = image);
  }

  void _submit() {
    if (_rating == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pilih rating terlebih dahulu.')),
      );
      return;
    }
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: ecoWalkInfoAppBar(context, 'Beri Ulasan'),
    body: ListView(
      padding: const EdgeInsets.only(bottom: 20),
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(28),
              ),
              child: Image.asset(
                widget.destination.imageAsset,
                width: double.infinity,
                height: 145,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) =>
                    Container(height: 145, color: Colors.grey.shade300),
              ),
            ),
            Positioned(
              right: 18,
              bottom: -14,
              child: Container(
                constraints: const BoxConstraints(maxWidth: 145),
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 9,
                ),
                decoration: BoxDecoration(
                  color: ecoWalkTeal,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  widget.destination.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 27, 16, 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hai, ${EcowalkProfile.instance.name} !',
                style: const TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              const Text('bagaimana perjalananmu?'),
              const SizedBox(height: 12),
              Row(
                children: [
                  ...List.generate(
                    5,
                    (i) => IconButton(
                      padding: const EdgeInsets.only(right: 2),
                      constraints: const BoxConstraints(),
                      onPressed: () => setState(() => _rating = i + 1),
                      icon: Icon(
                        i < _rating ? Icons.star : Icons.star_border,
                        size: 34,
                        color: i < _rating ? Colors.amber : Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    _rating == 0
                        ? ''
                        : const [
                            'Buruk',
                            'Kurang',
                            'Cukup',
                            'Bagus',
                            'Bagus',
                          ][_rating - 1],
                    style: const TextStyle(color: Colors.green, fontSize: 12),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              TextField(
                controller: _reviewController,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: 'Ceritakan pengalamanmu ...',
                  hintStyle: const TextStyle(
                    color: Colors.black38,
                    fontSize: 11,
                    fontStyle: FontStyle.italic,
                  ),
                  filled: true,
                  fillColor: const Color(0xFFF6F6F6),
                  border: InputBorder.none,
                ),
              ),
              const SizedBox(height: 20),
              const Text('Tambahkan Gambar?', style: TextStyle(fontSize: 12)),
              const SizedBox(height: 10),
              Row(
                children: [
                  OutlinedButton(
                    onPressed: _pickPhoto,
                    style: OutlinedButton.styleFrom(
                      fixedSize: const Size(62, 62),
                      side: const BorderSide(color: Colors.black54),
                      shape: const RoundedRectangleBorder(),
                    ),
                    child: const Icon(Icons.add, size: 30),
                  ),
                  if (_photo != null) ...[
                    const SizedBox(width: 10),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: Image.file(
                        File(_photo!.path),
                        width: 62,
                        height: 62,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ],
              ),
              CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                dense: true,
                controlAffinity: ListTileControlAffinity.leading,
                value: _hideName,
                onChanged: (value) =>
                    setState(() => _hideName = value ?? false),
                title: const Text(
                  'Sembunyikan Nama Pengguna',
                  style: TextStyle(fontSize: 11),
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: FilledButton(
                  style: FilledButton.styleFrom(backgroundColor: ecoWalkTeal),
                  onPressed: _submit,
                  child: const Text('Kirim'),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

class ReviewsScreen extends StatefulWidget {
  const ReviewsScreen({super.key, required this.destination});
  final Destination destination;

  @override
  State<ReviewsScreen> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {
  bool _withPhoto = false;
  int? _stars;

  @override
  Widget build(BuildContext context) {
    final reviews = List.generate(8, (index) => index).where((index) {
      if (_withPhoto && index.isEven) return false;
      if (_stars != null && index != _stars! % 8) return false;
      return true;
    }).toList();

    return Scaffold(
      appBar: ecoWalkInfoAppBar(context, 'Nilai & Ulasan'),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        children: [
          Row(
            children: [
              const Text(
                '4.75',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 10),
              const Expanded(
                child: Text(
                  '★★★★★',
                  style: TextStyle(color: Colors.amber, fontSize: 20),
                ),
              ),
              const EcoWalkLogo(),
            ],
          ),
          const Text('24.543 Ulasan', style: TextStyle(fontSize: 11)),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            children: [
              ChoiceChip(
                label: const Text('Semua'),
                selected: !_withPhoto,
                onSelected: (_) => setState(() => _withPhoto = false),
                selectedColor: ecoWalkTeal,
                labelStyle: TextStyle(
                  color: !_withPhoto ? Colors.white : Colors.black,
                ),
              ),
              ChoiceChip(
                label: const Text('Dengan Foto'),
                selected: _withPhoto,
                onSelected: (_) => setState(() => _withPhoto = true),
                selectedColor: ecoWalkTeal,
                labelStyle: TextStyle(
                  color: _withPhoto ? Colors.white : Colors.black,
                ),
              ),
              PopupMenuButton<int>(
                initialValue: _stars,
                onSelected: (value) =>
                    setState(() => _stars = value == 0 ? null : value),
                itemBuilder: (_) => [
                  const PopupMenuItem(value: 0, child: Text('Semua bintang')),
                  ...List.generate(
                    5,
                    (i) => PopupMenuItem(
                      value: 5 - i,
                      child: Text('${5 - i} bintang'),
                    ),
                  ),
                ],
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 9,
                  ),
                  decoration: BoxDecoration(
                    color: ecoWalkTeal,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    _stars == null ? 'Bintang ⌄' : '$_stars Bintang ⌄',
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          if (reviews.isEmpty)
            const Padding(
              padding: EdgeInsets.all(24),
              child: Text('Belum ada ulasan untuk filter ini.'),
            ),
          ...reviews.map((index) => _ReviewCard(index: index)),
        ],
      ),
    );
  }
}

class _ReviewCard extends StatefulWidget {
  const _ReviewCard({required this.index});
  final int index;
  @override
  State<_ReviewCard> createState() => _ReviewCardState();
}

class _ReviewCardState extends State<_ReviewCard> {
  bool _expanded = false;
  @override
  Widget build(BuildContext context) => Card(
    margin: const EdgeInsets.only(top: 12, bottom: 4),
    elevation: 2,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
    child: Padding(
      padding: const EdgeInsets.all(13),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 11,
                backgroundColor: Colors.grey.shade300,
                backgroundImage: const AssetImage(
                  'lib/assets/images/profile.png',
                ),
              ),
              const SizedBox(width: 8),
              const Expanded(
                child: Text(
                  'Kaisyarani Zahra',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                decoration: BoxDecoration(
                  color: ecoWalkTeal,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  '5.0 / 5.0',
                  style: TextStyle(color: Colors.white, fontSize: 8),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            'Tempatnya bagus, banyak pilihan wahana dan pengalaman yang menyenangkan. Sangat cocok untuk dikunjungi bersama keluarga dan teman.',
            maxLines: _expanded ? null : 3,
            overflow: _expanded ? TextOverflow.visible : TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 10, height: 1.5),
          ),
          TextButton(
            onPressed: () => setState(() => _expanded = !_expanded),
            style: TextButton.styleFrom(padding: EdgeInsets.zero),
            child: Text(_expanded ? 'Lebih Sedikit' : 'Selengkapnya'),
          ),
          if (widget.index.isOdd)
            Row(
              children: [
                _reviewPhoto('lib/assets/images/dufan.png'),
                const SizedBox(width: 8),
                _reviewPhoto('lib/assets/images/tmii.png'),
              ],
            ),
          const Align(
            alignment: Alignment.centerRight,
            child: Text(
              'Ditulis pada 19 Februari 2025',
              style: TextStyle(fontSize: 7),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _reviewPhoto(String asset) => ClipRRect(
  borderRadius: BorderRadius.circular(3),
  child: Image.asset(
    asset,
    width: 64,
    height: 58,
    fit: BoxFit.cover,
    errorBuilder: (_, __, ___) =>
        Container(width: 64, height: 58, color: Colors.grey.shade300),
  ),
);
