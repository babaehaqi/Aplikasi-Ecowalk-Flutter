import 'package:flutter/material.dart';

import '../models/destination.dart';
import '../models/ecowalk_profile.dart';
import '../models/recently_viewed_destinations.dart';
import '../widgets/ecowalk_bottom_nav.dart';
import '../widgets/ecowalk_info_widgets.dart';

const _mint = Color(0xFF1E6056);
const _categories = ['Semua', 'Kuliner', 'Sejarah', 'Alam', 'Religi', 'Seni'];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _category = 0;
  bool _showReview = true;
  int _rating = 0;

  void _navigateTab(int index) {
    if (index == 0) return;
    final route = index == 3
        ? '/profile'
        : index == 1
        ? '/recommendations'
        : '/community';
    Navigator.pushReplacementNamed(context, route);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.white,
    body: SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 20),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                Row(
                  children: [
                    const EcoWalkLogo(),
                    const Spacer(),
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(context, '/profile'),
                      child: CircleAvatar(
                        radius: 17,
                        backgroundImage:
                            EcowalkProfile.instance.photoBytes != null
                            ? MemoryImage(EcowalkProfile.instance.photoBytes!)
                            : const AssetImage('lib/assets/images/profile.png'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    CircleAvatar(
                      backgroundColor: _mint,
                      radius: 18,
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        icon: const Icon(
                          Icons.notifications_none,
                          color: Colors.white,
                          size: 21,
                        ),
                        onPressed: () =>
                            Navigator.pushNamed(context, '/notifications'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                _weatherCard(context),
                const _SectionTitle('Rekomendasi'),
                SizedBox(
                  height: 222,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      _destinationCard(context, dufanDestination, width: 155),
                      const SizedBox(width: 12),
                      _destinationCard(context, _tmii, width: 155),
                      const SizedBox(width: 12),
                      _destinationCard(context, dufanDestination, width: 155),
                    ],
                  ),
                ),
                if (_showReview) ...[const SizedBox(height: 40), _reviewCard()],
                const SizedBox(height: 22),
                const _SectionTitle('Kategori'),
                SizedBox(
                  height: 38,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: List.generate(
                      _categories.length,
                      (i) => Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: ChoiceChip(
                          label: Text(_categories[i]),
                          selected: i == _category,
                          onSelected: (_) => setState(() => _category = i),
                          selectedColor: _mint,
                          labelStyle: TextStyle(
                            color: i == _category ? Colors.white : Colors.black,
                            fontSize: 13,
                          ),
                          showCheckmark: false,
                          backgroundColor: Colors.white,
                          side: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                ),
                _sectionAction(
                  'Pilihan Teratas',
                  'Jelajahi',
                  () => Navigator.pushNamed(context, '/categories'),
                ),
                SizedBox(
                  height: 112,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: List.generate(
                      3,
                      (_) => Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: _smallDestination(context, dufanDestination),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 28),
                _promo(context),
                const SizedBox(height: 22),
                _sectionAction(
                  'Kunjungi Lagi',
                  'Selengkapnya',
                  () => Navigator.pushNamed(context, '/travel_recap'),
                ),
                SizedBox(
                  height: 112,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: List.generate(
                      3,
                      (_) => Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: _smallDestination(context, dufanDestination),
                      ),
                    ),
                  ),
                ),
                _sectionAction(
                  'Terakhir Dilihat',
                  'Selengkapnya',
                  () => Navigator.pushNamed(context, '/recently_viewed'),
                ),
                ValueListenableBuilder(
                  valueListenable: RecentlyViewedDestinations.items,
                  builder: (context, items, _) {
                    if (items.isEmpty) {
                      return const Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          'Destinasi yang kamu buka akan muncul di sini.',
                          style: TextStyle(color: Colors.black54, fontSize: 12),
                        ),
                      );
                    }
                    return SizedBox(
                      height: 112,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: items.length,
                        separatorBuilder: (_, _) => const SizedBox(width: 12),
                        itemBuilder: (context, index) =>
                            _smallDestination(context, items[index]),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16),
              ]),
            ),
          ),
        ],
      ),
    ),
    floatingActionButton: Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: GestureDetector(
        onTap: () => ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Asisten EcoWalk siap membantu!')),
        ),
        child: Image.asset(
          'lib/assets/images/ai bot.png',
          width: 62,
          height: 62,
          errorBuilder: (_, __, ___) =>
              const CircleAvatar(child: Icon(Icons.smart_toy)),
        ),
      ),
    ),
    bottomNavigationBar: EcoWalkBottomNav(
      selectedIndex: 0,
      onTap: _navigateTab,
    ),
  );

  Widget _weatherCard(BuildContext context) => GestureDetector(
    onTap: () => Navigator.pushNamed(context, '/weather'),
    child: Container(
      height: 210,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [_mint, Color(0xFFBFC8C6)],
        ),
        boxShadow: const [
          BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(0, 3)),
        ],
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Minggu, 16 Februari 2025',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                'Klapanunggal, Bogor',
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
              const SizedBox(height: 7),
              const Text(
                '30°C',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Cerah Berawan',
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ],
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Image.asset(
              'lib/assets/images/awan matahari.png',
              width: 145,
              height: 145,
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) =>
                  const Icon(Icons.cloud, size: 100, color: Colors.white),
            ),
          ),
        ],
      ),
    ),
  );

  Widget _reviewCard() => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(11),
      border: Border.all(color: Colors.black12),
      boxShadow: const [
        BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Expanded(
              child: Text(
                'Bagaimana Perjalananmu?',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.close, size: 20),
              onPressed: () => setState(() => _showReview = false),
            ),
          ],
        ),
        const Text(
          'Yuk beri ulasan untuk tempat yang baru kamu kunjungi !',
          style: TextStyle(fontSize: 12),
        ),
        Row(
          children: List.generate(
            5,
            (i) => IconButton(
              constraints: const BoxConstraints(),
              padding: const EdgeInsets.only(right: 4, top: 8),
              icon: Icon(
                i < _rating ? Icons.star : Icons.star_border,
                size: 27,
                color: Colors.black,
              ),
              onPressed: () => Navigator.pushNamed(
                context,
                '/write_review',
                arguments: dufanDestination,
              ),
            ),
          ),
        ),
      ],
    ),
  );

  Widget _promo(BuildContext context) => GestureDetector(
    onTap: () => Navigator.pushNamed(context, '/categories'),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: SizedBox(
        height: 104,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              'lib/assets/images/informasi.png',
              fit: BoxFit.fill,
              errorBuilder: (_, __, ___) => Container(color: _mint),
            ),
          ],
        ),
      ),
    ),
  );

  Widget _sectionAction(String title, String action, VoidCallback onTap) =>
      Padding(
        padding: const EdgeInsets.only(top: 22, bottom: 12),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
            InkWell(
              onTap: onTap,
              child: Row(
                children: [
                  Text(action, style: const TextStyle(fontSize: 12)),
                  const Icon(Icons.chevron_right, size: 18),
                ],
              ),
            ),
          ],
        ),
      );
}

const _tmii = Destination(
  name: 'Taman Mini Indonesia Indah (TMII)',
  location: 'Jakarta Timur',
  price: 35000,
  distanceKm: 3.68,
  rating: 4.7,
  imageAsset: 'lib/assets/images/tmii.png',
  description: 'Taman Mini Indonesia Indah.',
);

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.text);
  final String text;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 20, bottom: 8),
    child: Text(
      text,
      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
    ),
  );
}

Widget _destinationCard(
  BuildContext context,
  Destination d, {
  required double width,
}) => GestureDetector(
  onTap: () =>
      Navigator.pushNamed(context, '/destination_detail', arguments: d),
  child: ClipRRect(
    borderRadius: BorderRadius.circular(11),
    child: SizedBox(
      width: width,
      height: 220,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            d.imageAsset,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) =>
                Container(color: Colors.grey.shade300),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 95,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black87],
                ),
              ),
            ),
          ),
          Positioned(
            top: 5,
            right: 5,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
              decoration: BoxDecoration(
                color: _mint,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                '${d.distanceKm} KM',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 8,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Positioned(
            left: 8,
            right: 6,
            bottom: 7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  d.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '📍 ${d.location}',
                  style: const TextStyle(color: Colors.white, fontSize: 7),
                ),
                Text(
                  'Mulai dari ${d.formattedPrice}',
                  style: const TextStyle(color: Colors.white, fontSize: 7),
                ),
                Row(
                  children: [
                    const Text(
                      '★★★★★',
                      style: TextStyle(color: Colors.amber, fontSize: 12),
                    ),
                    const Spacer(),
                    const Text(
                      'Lebih Lanjut  ›',
                      style: TextStyle(color: Colors.white, fontSize: 7),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  ),
);

Widget _smallDestination(BuildContext context, Destination d) =>
    GestureDetector(
      onTap: () =>
          Navigator.pushNamed(context, '/destination_detail', arguments: d),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(9),
        child: SizedBox(
          width: 145,
          height: 112,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                d.imageAsset,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) =>
                    Container(color: Colors.grey.shade300),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(height: 45, color: Colors.black54),
              ),
              Positioned(
                left: 7,
                bottom: 6,
                right: 5,
                child: Text(
                  '${d.name}\n★ ${d.rating} · ${d.location}',
                  style: const TextStyle(color: Colors.white, fontSize: 8),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
