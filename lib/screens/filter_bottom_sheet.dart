import 'package:flutter/material.dart';

import '../widgets/ecowalk_info_widgets.dart';

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({super.key});
  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  double distance = .25;
  final Set<String> locations = {};
  final Set<String> zones = {};
  String? selectedDistance;
  String? selectedPrice;
  @override
  Widget build(BuildContext context) => SafeArea(
    child: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 80,
                height: 6,
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Filter',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                ),
                TextButton(
                  onPressed: () => setState(() {
                    locations.clear();
                    zones.clear();
                    selectedDistance = null;
                    selectedPrice = null;
                    distance = .25;
                  }),
                  child: const Text('Reset'),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            const Text(
              'Rentang Jarak',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Wrap(
              spacing: 8,
              children: ['500 M', 'Terdekat', 'Terjauh']
                  .map(
                    (s) =>
                        _distanceChoice(s, selectedDistance, _selectDistance),
                  )
                  .toList(),
            ),
            Slider(
              value: distance,
              onChanged: (v) => setState(() => distance = v),
              activeColor: ecoWalkTeal,
              inactiveColor: Colors.grey.shade300,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Terdekat', style: TextStyle(fontSize: 8)),
                Text('Terjauh', style: TextStyle(fontSize: 8)),
              ],
            ),
            const Divider(),
            const Text(
              'Rentang Harga',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(child: _priceBox('Minimal', 'Rp 100.000,00')),
                const SizedBox(width: 12),
                Expanded(child: _priceBox('Maksimal', 'Rp 99.999.999,00')),
              ],
            ),
            Column(
              children: [
                Row(
                  children: [
                    Expanded(child: _priceChoice('< Rp 50.000,00')),
                    const SizedBox(width: 12),
                    Expanded(child: _priceChoice('< Rp 100.000,00')),
                  ],
                ),
                Row(
                  children: [
                    Expanded(child: _priceChoice('< Rp 300.000,00')),
                    const SizedBox(width: 12),
                    Expanded(child: _priceChoice('Gratis')),
                  ],
                ),
              ],
            ),
            const Divider(),
            const Text(
              'Lokasi Populer',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            ...['Blok M', 'Gelora Bung Karno', 'Senayan', 'Citra Delapan'].map(
              (s) => InkWell(
                onTap: () => setState(
                  () => locations.contains(s)
                      ? locations.remove(s)
                      : locations.add(s),
                ),
                child: SizedBox(
                  height: 28,
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(s, style: const TextStyle(fontSize: 12)),
                      ),
                      Container(
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: locations.contains(s)
                              ? ecoWalkTeal
                              : Colors.transparent,
                          border: Border.all(color: ecoWalkTeal),
                        ),
                        child: locations.contains(s)
                            ? const Icon(
                                Icons.check,
                                size: 11,
                                color: Colors.white,
                              )
                            : null,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const Text('Zona', style: TextStyle(fontWeight: FontWeight.bold)),
            Wrap(
              spacing: 10,
              children: [
                _zoneOption(
                  'Dalam Ruangan',
                  Icons.home_work_outlined,
                  zones.contains('Dalam Ruangan'),
                  () => _toggleZone('Dalam Ruangan'),
                ),
                _zoneOption(
                  'Luar Ruangan',
                  Icons.sports_soccer_outlined,
                  zones.contains('Luar Ruangan'),
                  () => _toggleZone('Luar Ruangan'),
                ),
              ],
            ),
            const SizedBox(height: 14),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: ecoWalkTeal,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 13),
                ),
                onPressed: () => Navigator.pop(context),
                child: const Text('Terapkan'),
              ),
            ),
          ],
        ),
      ),
    ),
  );

  Widget _priceChoice(String label) => Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: _choice(
      label,
      selectedPrice,
      (value) => setState(() => selectedPrice = value),
    ),
  );

  void _toggleZone(String zone) => setState(
    () => zones.contains(zone) ? zones.remove(zone) : zones.add(zone),
  );

  void _selectDistance(String value) => setState(() {
    selectedDistance = value;
    distance = switch (value) {
      '500 M' => .12,
      'Terdekat' => 0,
      'Terjauh' => 1,
      _ => distance,
    };
  });
}

Widget _distanceChoice(
  String label,
  String? selected,
  ValueChanged<String> onTap,
) => Padding(
  padding: const EdgeInsets.only(right: 6),
  child: ChoiceChip(
    label: Text(label, style: const TextStyle(fontSize: 10)),
    selected: selected == label,
    onSelected: (_) => onTap(label),
    selectedColor: ecoWalkTeal,
    backgroundColor: ecoWalkTeal,
    labelStyle: const TextStyle(color: Colors.white),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
    side: BorderSide.none,
    showCheckmark: false,
  ),
);

Widget _choice(String s, String? selected, ValueChanged<String> onTap) =>
    ChoiceChip(
      label: Text(s, style: const TextStyle(fontSize: 11)),
      selected: s == selected,
      onSelected: (_) => onTap(s),
      selectedColor: ecoWalkTeal,
      labelStyle: TextStyle(color: s == selected ? Colors.white : Colors.black),
      backgroundColor: Colors.white,
      shape: const StadiumBorder(),
      side: BorderSide(color: s == selected ? ecoWalkTeal : Colors.black),
      showCheckmark: false,
    );

Widget _zoneOption(
  String label,
  IconData icon,
  bool selected,
  VoidCallback onTap,
) => InkWell(
  onTap: onTap,
  borderRadius: BorderRadius.circular(6),
  child: Container(
    width: 78,
    height: 76,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: selected ? ecoWalkTeal : Colors.black38),
      color: selected ? ecoWalkTeal.withValues(alpha: .08) : Colors.white,
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 22, color: Colors.black87),
        const SizedBox(height: 5),
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 8),
        ),
      ],
    ),
  ),
);
Widget _priceBox(String title, String value) => Container(
  padding: const EdgeInsets.all(10),
  decoration: BoxDecoration(
    color: ecoWalkTeal,
    borderRadius: BorderRadius.circular(6),
  ),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(title, style: const TextStyle(color: Colors.white70, fontSize: 10)),
      Text(
        value,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    ],
  ),
);
