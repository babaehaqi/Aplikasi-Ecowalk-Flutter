import 'package:flutter/material.dart';

import '../widgets/ecowalk_info_widgets.dart';

class SortBottomSheet extends StatefulWidget {
  const SortBottomSheet({super.key});
  @override
  State<SortBottomSheet> createState() => _SortBottomSheetState();
}

class _SortBottomSheetState extends State<SortBottomSheet> {
  String selected = 'Direkomendasikan';
  @override
  Widget build(BuildContext context) => SafeArea(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 14, 12, 4),
          child: Row(
            children: [
              const Expanded(
                child: Text(
                  'Urutkan',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
              ),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close),
              ),
            ],
          ),
        ),
        ...[
          'Direkomendasikan',
          'Harga Tertinggi',
          'Harga Terendah',
          'Ulasan Terbaik',
          'Jarak Terdekat',
        ].map(
          (s) => RadioListTile<String>(
            title: Text(s),
            value: s,
            groupValue: selected,
            activeColor: ecoWalkTeal,
            onChanged: (v) {
              setState(() => selected = v!);
              Navigator.pop(context, v);
            },
          ),
        ),
      ],
    ),
  );
}
