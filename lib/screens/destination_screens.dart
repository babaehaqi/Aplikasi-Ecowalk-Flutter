import 'package:flutter/material.dart';

import '../models/destination.dart';
import '../models/recently_viewed_destinations.dart';
import '../widgets/ecowalk_bottom_nav.dart';
import '../widgets/ecowalk_info_widgets.dart';
import 'filter_bottom_sheet.dart';
import 'sort_bottom_sheet.dart';

const _categories = ['Semua', 'Kuliner', 'Sejarah', 'Alam', 'Religi', 'Seni'];

class DestinationDetailScreen extends StatefulWidget {
  const DestinationDetailScreen({super.key, required this.destination});
  final Destination destination;
  @override
  State<DestinationDetailScreen> createState() =>
      _DestinationDetailScreenState();
}

class _DestinationDetailScreenState extends State<DestinationDetailScreen> {
  bool favorite = false;

  @override
  void initState() {
    super.initState();
    RecentlyViewedDestinations.add(widget.destination);
  }

  @override
  Widget build(BuildContext context) {
    final d = widget.destination;
    final address = d.name == dufanDestination.name ? dufanAddress : d.location;
    return Scaffold(
      appBar: ecoWalkInfoAppBar(context, d.name),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Stack(
            alignment: Alignment.bottomLeft,
            children: [
              _image(d.imageAsset, 230),
              Positioned(
                left: 10,
                bottom: 10,
                child: _detailRatingBadge(d.rating),
              ),
              Positioned(
                right: 10,
                bottom: 10,
                child: CircleAvatar(
                  backgroundColor: ecoWalkTeal,
                  child: IconButton(
                    onPressed: () => setState(() => favorite = !favorite),
                    icon: Icon(
                      favorite ? Icons.favorite : Icons.favorite_border,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            d.name,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Row(
            children: [
              Icon(Icons.access_time_rounded, size: 18, color: ecoWalkTeal),
              SizedBox(width: 7),
              Text(
                'Open',
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(' | 10:00 - 22:00'),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.location_on_outlined,
                size: 18,
                color: ecoWalkTeal,
              ),
              const SizedBox(width: 7),
              Expanded(
                child: Text(
                  address,
                  style: const TextStyle(fontSize: 12, height: 1.35),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(d.description),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: ecoWalkTeal,
              borderRadius: BorderRadius.circular(9),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.confirmation_number_outlined,
                      size: 16,
                      color: Colors.white,
                    ),
                    SizedBox(width: 6),
                    Text(
                      'Harga Tiket Mulai Dari',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                Text(
                  'Rp. 190.000 - Rp. 400.000',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
                Text(
                  '*Harga tergantung hari dan dapat berubah sewaktu-waktu',
                  style: TextStyle(color: Colors.white70, fontSize: 10),
                ),
              ],
            ),
          ),
          const EcoWalkSectionHeading('Nilai & Ulasan'),
          Row(
            children: [
              _detailRatingBadge(d.rating),
              const SizedBox(width: 10),
              const Expanded(
                child: Text('Rekomendasi Istimewa\n24.543 Ulasan'),
              ),
              TextButton(
                onPressed: () =>
                    Navigator.pushNamed(context, '/reviews', arguments: d),
                child: const Text('Lihat Semua  â€º'),
              ),
            ],
          ),
          SizedBox(
            height: 150,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: List.generate(
                3,
                (i) => Container(
                  width: 230,
                  margin: const EdgeInsets.only(right: 10),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black12),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(radius: 9, backgroundColor: Colors.red),
                          SizedBox(width: 7),
                          Text(
                            'Kaisyarani Zahra',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(
                            Icons.star_rounded,
                            color: Colors.amber,
                            size: 15,
                          ),
                          Icon(
                            Icons.star_rounded,
                            color: Colors.amber,
                            size: 15,
                          ),
                          Icon(
                            Icons.star_rounded,
                            color: Colors.amber,
                            size: 15,
                          ),
                          Icon(
                            Icons.star_rounded,
                            color: Colors.amber,
                            size: 15,
                          ),
                          Icon(
                            Icons.star_rounded,
                            color: Colors.amber,
                            size: 15,
                          ),
                        ],
                      ),
                      Text(
                        'Pengalaman yang menyenangkan, tempatnya bagus dan cocok untuk keluarga.',
                        style: TextStyle(fontSize: 11),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Row(
            children: [
              const Icon(Icons.map_outlined, color: ecoWalkTeal, size: 19),
              const SizedBox(width: 7),
              const Expanded(child: EcoWalkSectionHeading('Lihat Peta')),
            ],
          ),
          Row(
            children: [
              const Icon(Icons.near_me_outlined, color: ecoWalkTeal, size: 16),
              const SizedBox(width: 6),
              Text('${d.distanceKm} KM dari lokasimu saat ini'),
            ],
          ),
          const SizedBox(height: 8),
          _image('lib/assets/images/map.png', 160),
        ],
      ),
    );
  }
}

class WeatherDetailScreen extends StatelessWidget {
  const WeatherDetailScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: ecoWalkInfoAppBar(context, 'Cuaca'),
    backgroundColor: const Color(0xFFE8F1F0),
    body: ListView(
      padding: const EdgeInsets.fromLTRB(18, 16, 18, 22),
      children: [
        const Text(
          'Prakiraan Cuaca',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 2),
        const Text(
          'Klapanunggal, Bogor',
          style: TextStyle(fontSize: 12, color: Color(0xFF424A48)),
        ),
        SizedBox(
          height: 100,
          child: Row(
            children: [
              const Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '30°C',
                      style: TextStyle(
                        fontSize: 30,
                        height: 1.05,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text('Cerah Berawan', style: TextStyle(fontSize: 17)),
                  ],
                ),
              ),
              Image.asset(
                'lib/assets/images/awan matahari.png',
                width: 112,
                height: 90,
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) =>
                    const Icon(Icons.cloud, size: 74, color: Colors.lightBlue),
              ),
            ],
          ),
        ),
        Row(
          children: [
            Expanded(child: _weatherInfo('Kelembapan', '92%')),
            const SizedBox(width: 12),
            Expanded(
              child: _weatherInfo('Kualitas Udara', '39.1', Icons.air_rounded),
            ),
          ],
        ),
        const EcoWalkSectionHeading('Hari ini'),
        SizedBox(
          height: 94,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: List.generate(6, (index) {
              const hours = [
                'Sekarang',
                '07:00',
                '10:00',
                '13:00',
                '16:00',
                '19:00',
              ];
              return Container(
                width: 70,
                margin: const EdgeInsets.only(right: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'lib/assets/images/awan matahari.png',
                      width: 38,
                      height: 32,
                      fit: BoxFit.contain,
                      errorBuilder: (_, __, ___) => const Icon(
                        Icons.cloud,
                        size: 28,
                        color: Colors.lightBlue,
                      ),
                    ),
                    Text(hours[index], style: const TextStyle(fontSize: 10)),
                    const Text('30°C', style: TextStyle(fontSize: 10)),
                  ],
                ),
              );
            }),
          ),
        ),
        const SizedBox(height: 18),
        Card(
          elevation: 1,
          color: const Color(0xFFF4F8F7),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
            child: Column(
              children: [
                _dailyWeatherRow('Hari Ini'),
                const SizedBox(height: 7),
                _dailyWeatherRow('Besok'),
              ],
            ),
          ),
        ),
        const EcoWalkSectionHeading('Aktivitas Harian'),
        _activityRow(
          Icons.sentiment_satisfied_alt_outlined,
          'Berjalan-jalan adalah pilihan terbaik saat ini!',
          action: 'Lihat Destinasi Wisata',
          onTap: () => Navigator.pushNamed(context, '/categories'),
        ),
        _activityRow(
          Icons.umbrella_outlined,
          'Jangan lupa bawa payung untuk berjaga-jaga',
        ),
        _activityRow(
          Icons.camera_alt_outlined,
          'Aktivitas outdoor direkomendasikan',
        ),
      ],
    ),
  );

  Widget _dailyWeatherRow(String day) => Row(
    children: [
      SizedBox(
        width: 54,
        child: Text(day, style: const TextStyle(fontSize: 11)),
      ),
      Image.asset(
        'lib/assets/images/awan matahari.png',
        width: 28,
        height: 25,
        fit: BoxFit.contain,
        errorBuilder: (_, __, ___) =>
            const Icon(Icons.cloud, color: Colors.lightBlue, size: 20),
      ),
      const SizedBox(width: 8),
      const Expanded(
        child: Text('Cerah Berawan', style: TextStyle(fontSize: 11)),
      ),
      const Text(
        '30°C / 20°C',
        style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
      ),
    ],
  );

  Widget _activityRow(
    IconData icon,
    String text, {
    String? action,
    VoidCallback? onTap,
  }) => Padding(
    padding: const EdgeInsets.only(bottom: 9),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 34,
          child: Icon(icon, size: 21, color: const Color(0xFF37413F)),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(text, style: const TextStyle(fontSize: 12, height: 1.35)),
              if (action != null)
                GestureDetector(
                  onTap: onTap,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 3),
                    child: Text(
                      action,
                      style: const TextStyle(fontSize: 10, color: ecoWalkTeal),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _weatherInfo(String title, String value, [IconData? icon]) => Container(
  height: 62,
  decoration: BoxDecoration(
    color: ecoWalkTeal,
    borderRadius: BorderRadius.circular(11),
  ),
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) ...[
            Icon(icon, color: Colors.white, size: 14),
            const SizedBox(width: 4),
          ],
          Text(
            title,
            style: const TextStyle(color: Colors.white, fontSize: 11),
          ),
        ],
      ),
      Text(
        value,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 19,
          fontWeight: FontWeight.bold,
        ),
      ),
    ],
  ),
);

class TravelRecapScreen extends StatefulWidget {
  const TravelRecapScreen({super.key});
  @override
  State<TravelRecapScreen> createState() => _TravelRecapScreenState();
}

class _TravelRecapScreenState extends State<TravelRecapScreen> {
  int rating = 0;
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: ecoWalkInfoAppBar(context, 'Rekap Perjalanan'),
    body: ListView(
      padding: const EdgeInsets.only(bottom: 18),
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
          child: _image('lib/assets/images/dufan.png', 150),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Dunia Fantasi (DUFAN)',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const Text('?  19 Februari 2025 | 12:00 WIB'),
              const SizedBox(height: 6),
              const Text('?  $dufanAddress', style: TextStyle(fontSize: 11)),
              const EcoWalkSectionHeading('Rute Perjalanan'),
              _image('lib/assets/images/map.png', 140),
              const EcoWalkSectionHeading('Transportasi'),
              _image('lib/assets/images/prank ojol.png', 105),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Bagaimana Perjalananmu?',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const Text(
                        'Yuk beri ulasan untuk tempat yang baru kamu kunjungi !',
                        style: TextStyle(fontSize: 12),
                      ),
                      Row(
                        children: List.generate(
                          5,
                          (i) => IconButton(
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            onPressed: () => Navigator.pushNamed(
                              context,
                              '/write_review',
                              arguments: dufanDestination,
                            ),
                            icon: Icon(
                              i < rating ? Icons.star : Icons.star_border,
                              size: 28,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  style: FilledButton.styleFrom(backgroundColor: ecoWalkTeal),
                  onPressed: () => Navigator.pushNamed(
                    context,
                    '/destination_detail',
                    arguments: dufanDestination,
                  ),
                  child: const Text('Pergi Lagi'),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

class CategoryListScreen extends StatefulWidget {
  const CategoryListScreen({super.key});
  @override
  State<CategoryListScreen> createState() => _CategoryListScreenState();
}

class _CategoryListScreenState extends State<CategoryListScreen> {
  String query = '';
  int category = 0;
  @override
  Widget build(BuildContext context) {
    final items = List.generate(
      7,
      (_) => dufanDestination,
    ).where((d) => d.name.toLowerCase().contains(query.toLowerCase())).toList();
    return Scaffold(
      appBar: ecoWalkInfoAppBar(context, 'Kategori'),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 10, 8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: (s) => setState(() => query = s),
                    decoration: InputDecoration(
                      hintText: 'Cari destinasi wisata',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.white,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                    builder: (_) => const FilterBottomSheet(),
                  ),
                  icon: const Icon(Icons.tune),
                ),
                IconButton(
                  onPressed: () => showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.white,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                    builder: (_) => const SortBottomSheet(),
                  ),
                  icon: const Icon(Icons.sort),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 44,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: List.generate(
                _categories.length,
                (i) => TextButton(
                  onPressed: () => setState(() => category = i),
                  child: Text(
                    _categories[i],
                    style: TextStyle(
                      color: category == i ? ecoWalkTeal : Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, i) {
                final item = items[i];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(item.imageAsset),
                  ),
                  title: Text(
                    item.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    "â˜… ${item.rating} | Open 10:00 - 22:00\n${item.location}\nMulai dari ${item.formattedPrice}",
                    style: const TextStyle(fontSize: 11),
                  ),
                  trailing: const Icon(Icons.chevron_right),
                  isThreeLine: true,
                  onTap: () => Navigator.pushNamed(
                    context,
                    "/destination_detail",
                    arguments: item,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class RecentlyViewedScreen extends StatelessWidget {
  const RecentlyViewedScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: ecoWalkInfoAppBar(context, 'Terakhir Dilihat'),
    body: ValueListenableBuilder(
      valueListenable: RecentlyViewedDestinations.items,
      builder: (context, destinations, _) {
        if (destinations.isEmpty) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(28),
              child: Text(
                'Destinasi wisata yang kamu lihat akan tersimpan di sini.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black54),
              ),
            ),
          );
        }
        return ListView.separated(
          itemCount: destinations.length,
          separatorBuilder: (_, _) => const Divider(height: 1),
          itemBuilder: (context, index) {
            final destination = destinations[index];
            return ListTile(
              minVerticalPadding: 15,
              leading: CircleAvatar(
                radius: 25,
                backgroundColor: Colors.grey.shade300,
                backgroundImage: AssetImage(destination.imageAsset),
              ),
              title: Text(
                destination.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 2),
                child: Text.rich(
                  TextSpan(
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 10,
                      height: 1.35,
                    ),
                    children: [
                      TextSpan(
                        text:
                            'â˜… ${destination.rating}  |  Open 10:00 - 22:00\n',
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      TextSpan(text: '${destination.location}\n'),
                      TextSpan(
                        text: 'Mulai dari ${destination.formattedPrice}',
                      ),
                    ],
                  ),
                ),
              ),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => Navigator.pushNamed(
                context,
                '/destination_detail',
                arguments: destination,
              ),
            );
          },
        );
      },
    ),
  );
}

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: ecoWalkInfoAppBar(context, 'Komunitas'),
    body: const Center(child: Text('Komunitas EcoWalk')),
    bottomNavigationBar: EcoWalkBottomNav(
      selectedIndex: 2,
      onTap: (i) {
        if (i == 0) Navigator.pushReplacementNamed(context, '/home');
        if (i == 3) Navigator.pushReplacementNamed(context, '/profile');
        if (i == 1) Navigator.pushReplacementNamed(context, '/recommendations');
      },
    ),
  );
}

Widget _detailRatingBadge(double rating) => Container(
  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
  decoration: BoxDecoration(
    color: ecoWalkTeal,
    borderRadius: BorderRadius.circular(7),
  ),
  child: Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Icon(Icons.star_rounded, color: Colors.amber, size: 15),
      const SizedBox(width: 4),
      Text(
        rating.toStringAsFixed(2),
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 11,
        ),
      ),
    ],
  ),
);

Widget _image(String path, double height) => ClipRRect(
  borderRadius: BorderRadius.circular(10),
  child: Image.asset(
    path,
    width: double.infinity,
    height: height,
    fit: BoxFit.cover,
    errorBuilder: (_, __, ___) =>
        Container(height: height, color: Colors.grey.shade300),
  ),
);
