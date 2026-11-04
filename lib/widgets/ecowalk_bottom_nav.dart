import 'package:flutter/material.dart';

const ecoWalkNavColor = Color(0xFF1E6056);

class EcoWalkBottomNav extends StatelessWidget {
  const EcoWalkBottomNav({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  final int selectedIndex;
  final ValueChanged<int> onTap;

  static const _items = <(IconData, String)>[
    (Icons.home_outlined, 'Beranda'),
    (Icons.verified_user_outlined, 'Rekomendasi'),
    (Icons.chat_bubble_outline, 'Komunitas'),
    (Icons.person_outline, 'Profil'),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: SizedBox(
        height: 76,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                height: 62,
                color: ecoWalkNavColor,
                child: Row(
                  children: List.generate(_items.length, (index) {
                    final (icon, label) = _items[index];
                    final selected = index == selectedIndex;
                    return Expanded(
                      child: InkWell(
                        onTap: () => onTap(index),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            if (selected)
                              Transform.translate(
                                offset: const Offset(0, -14),
                                child: Container(
                                  width: 48,
                                  height: 48,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: ecoWalkNavColor,
                                      width: 5,
                                    ),
                                  ),
                                  child: Icon(
                                    icon,
                                    color: ecoWalkNavColor,
                                    size: 24,
                                  ),
                                ),
                              )
                            else
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 13,
                                  bottom: 3,
                                ),
                                child: Icon(
                                  icon,
                                  color: Colors.white,
                                  size: 23,
                                ),
                              ),
                            Text(
                              label,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: selected ? 10 : 9,
                                fontWeight: selected
                                    ? FontWeight.w700
                                    : FontWeight.w500,
                              ),
                            ),
                            if (!selected) const SizedBox(height: 5),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
