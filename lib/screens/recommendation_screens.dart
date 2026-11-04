import 'package:flutter/material.dart';

import '../widgets/ecowalk_bottom_nav.dart';
import '../widgets/ecowalk_info_widgets.dart';

const _teal = Color(0xFF1E6056);

void _selectMainTab(BuildContext context, int index) {
  final route = switch (index) {
    0 => '/home',
    1 => '/recommendations',
    2 => '/community',
    _ => '/profile',
  };
  Navigator.pushNamedAndRemoveUntil(context, route, (route) => false);
}

class RecommendationSearchScreen extends StatefulWidget {
  const RecommendationSearchScreen({super.key});

  @override
  State<RecommendationSearchScreen> createState() =>
      _RecommendationSearchScreenState();
}

class _RecommendationSearchScreenState
    extends State<RecommendationSearchScreen> {
  final _origin = TextEditingController();
  final _destination = TextEditingController();

  @override
  void dispose() {
    _origin.dispose();
    _destination.dispose();
    super.dispose();
  }

  void _findRoute([String? destination]) {
    final origin = _origin.text.trim().isEmpty
        ? 'Klapanunggal'
        : _origin.text.trim();
    final target = destination ?? _destination.text.trim();
    if (target.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Masukkan lokasi tujuan terlebih dahulu.'),
        ),
      );
      return;
    }
    Navigator.pushNamed(
      context,
      '/route_recommendations',
      arguments: {'origin': origin, 'destination': target},
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
        children: [
          const EcoWalkLogo(),
          const SizedBox(height: 30),
          const Text(
            'MAU KEMANA HARI INI?',
            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _teal,
              borderRadius: BorderRadius.circular(11),
            ),
            child: Column(
              children: [
                _locationInput(
                  controller: _origin,
                  hint: 'Masukan Lokasi Asal',
                  icon: Icons.search_rounded,
                ),
                const SizedBox(height: 10),
                _locationInput(
                  controller: _destination,
                  hint: 'Masukan Lokasi Tujuan',
                  icon: Icons.location_on_outlined,
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          Align(
            alignment: Alignment.centerLeft,
            child: FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: _teal,
                minimumSize: const Size(116, 38),
              ),
              onPressed: _findRoute,
              child: const Text('Cari Rute'),
            ),
          ),
          const SizedBox(height: 34),
          const Text(
            'Rekomendasi Tujuan',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 14),
          SizedBox(
            height: 220,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _placeCard(
                  context,
                  'Maja Museum',
                  'Jakarta Pusat',
                  'Rp. 136.500',
                  'lib/assets/images/museum.png',
                  () => _findRoute('Maja Museum'),
                ),
                const SizedBox(width: 14),
                _placeCard(
                  context,
                  'Ocean Park BSD City Serpong',
                  'Tangerang Selatan',
                  'Rp. 65.000',
                  'lib/assets/images/bsd.png',
                  () => _findRoute('Ocean Park BSD City Serpong'),
                ),
                const SizedBox(width: 14),
                _placeCard(
                  context,
                  'Dunia Fantasi (DUFAN)',
                  'Ancol, Jakarta Utara',
                  'Rp. 200.000',
                  'lib/assets/images/dufan.png',
                  () => _findRoute('Dunia Fantasi (DUFAN)'),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
    bottomNavigationBar: EcoWalkBottomNav(
      selectedIndex: 1,
      onTap: (index) => _selectMainTab(context, index),
    ),
  );

  Widget _locationInput({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
  }) => Container(
    height: 42,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(25),
    ),
    child: TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
        prefixIcon: Icon(icon, color: Colors.black54, size: 22),
        border: InputBorder.none,
        contentPadding: const EdgeInsets.symmetric(vertical: 11),
      ),
    ),
  );
}

class RecommendationRouteScreen extends StatelessWidget {
  const RecommendationRouteScreen({
    super.key,
    required this.origin,
    required this.destination,
  });

  final String origin;
  final String destination;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: ecoWalkInfoAppBar(context, 'Rekomendasi'),
    body: ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _teal,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _routePoint('Titik Awal', origin),
              const Padding(
                padding: EdgeInsets.only(left: 5),
                child: Icon(Icons.more_vert, color: Colors.white70, size: 20),
              ),
              _routePoint('Titik Akhir', destination),
            ],
          ),
        ),
        const SizedBox(height: 24),
        const EcoWalkLogo(),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _modeTime(context, Icons.directions_walk, '13 menit', () {}),
            _modeTime(
              context,
              Icons.directions_car_filled_outlined,
              '5 menit',
              () => _openComparison(context, 'taxi'),
            ),
            _modeTime(
              context,
              Icons.two_wheeler,
              '4 menit',
              () => _openComparison(context, 'ojol'),
            ),
            _modeTime(
              context,
              Icons.directions_bus_filled_outlined,
              '18 menit',
              () => _openComparison(context, 'transit'),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _mapPreview('lib/assets/images/map jakpus.png', 210),
        const Padding(
          padding: EdgeInsets.only(top: 18, bottom: 10),
          child: Text(
            'Opsi Kendaraan',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Row(
          children: [
            _vehicleCard(
              context,
              'Ojek Online',
              'Nyaman dan cepat',
              'lib/assets/images/prank ojol.png',
              'ojol',
            ),
            _vehicleCard(
              context,
              'Transportasi Umum',
              'Hemat dan nyaman',
              'lib/assets/images/krl.png',
              'transit',
            ),
            _vehicleCard(
              context,
              'Taksi',
              'Efisien dan nyaman',
              'lib/assets/images/fake taxi.png',
              'taxi',
            ),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: _teal,
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Text(
            'Mau cepat & murah?  Ojek Online\nMau murah banget?  Kendaraan Umum\nMau nyaman & santai?  Taksi',
            style: TextStyle(color: Colors.white, height: 1.7, fontSize: 13),
          ),
        ),
      ],
    ),
  );

  void _openComparison(BuildContext context, String mode) {
    Navigator.pushNamed(context, '/transport_comparison', arguments: mode);
  }

  Widget _routePoint(String label, String value) => Row(
    children: [
      const Icon(Icons.location_on, color: Colors.white, size: 18),
      const SizedBox(width: 10),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(color: Colors.white70, fontSize: 9),
            ),
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    ],
  );

  Widget _modeTime(
    BuildContext context,
    IconData icon,
    String time,
    VoidCallback onTap,
  ) => InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(8),
    child: Padding(
      padding: const EdgeInsets.all(5),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 17),
          const SizedBox(width: 4),
          Text(time, style: const TextStyle(fontSize: 11)),
        ],
      ),
    ),
  );

  Widget _vehicleCard(
    BuildContext context,
    String title,
    String sub,
    String image,
    String mode,
  ) => Expanded(
    child: Padding(
      padding: const EdgeInsets.only(right: 10),
      child: InkWell(
        onTap: () => _openComparison(context, mode),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(9),
          child: SizedBox(
            height: 112,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  image,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) =>
                      Container(color: Colors.grey.shade300),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(height: 48, color: const Color(0xB3000000)),
                ),
                Positioned(
                  left: 6,
                  bottom: 6,
                  right: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        sub,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 7,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

class TransportComparisonScreen extends StatelessWidget {
  const TransportComparisonScreen({super.key, required this.mode});
  final String mode;

  bool get isTransit => mode == 'transit';
  String get title => isTransit
      ? 'TRANSPORTASI UMUM'
      : mode == 'taxi'
      ? 'TAKSI'
      : 'OJEK ONLINE';
  String get image => isTransit
      ? 'lib/assets/images/krl.png'
      : mode == 'taxi'
      ? 'lib/assets/images/fake taxi.png'
      : 'lib/assets/images/prank ojol.png';
  String get price => isTransit
      ? 'Rp. 0 - 20.000'
      : mode == 'taxi'
      ? 'Rp. 45.000 - 65.000'
      : 'Rp. 30.000 - 45.000';
  String get duration => isTransit
      ? '1 Jam 45 Menit'
      : mode == 'taxi'
      ? '25 Menit'
      : '20 Menit';
  String get badge => isTransit
      ? 'Termurah'
      : mode == 'taxi'
      ? 'Nyaman'
      : 'Tercepat';

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: ecoWalkInfoAppBar(context, 'Rekomendasi'),
    body: ListView(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
      children: [
        _hero(image, badge),
        const SizedBox(height: 10),
        Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        _iconInfo(Icons.payments_outlined, price),
        _iconInfo(Icons.access_time_rounded, duration),
        const SizedBox(height: 18),
        _mapPreview('lib/assets/images/map jakpus.png', 205),
        const SizedBox(height: 18),
        _analysisCard(isTransit),
        if (isTransit) ...[
          const Padding(
            padding: EdgeInsets.only(top: 22, bottom: 10),
            child: Text(
              'Opsi Transportasi Umum',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          _transitOptions(context),
        ],
      ],
    ),
  );

  Widget _transitOptions(BuildContext context) => Card(
    color: const Color(0xFFF4F4F4),
    child: Column(
      children: [
        _transitRow(
          context,
          'TransJakarta',
          '± 40 menit',
          'lib/assets/images/tj.png',
        ),
        _transitRow(
          context,
          'MRT Jakarta',
          '± 25 menit',
          'lib/assets/images/krl.png',
        ),
        _transitRow(
          context,
          'LRT Jabodetabek',
          '± 30 menit',
          'lib/assets/images/krl.png',
        ),
        _transitRow(
          context,
          'KRL Commuter Line',
          '± 35 menit',
          'lib/assets/images/krl.png',
        ),
        _transitRow(
          context,
          'Mikrotrans (JakLingko)',
          '± 50 menit',
          'lib/assets/images/tj.png',
        ),
      ],
    ),
  );

  Widget _transitRow(
    BuildContext context,
    String name,
    String time,
    String asset,
  ) => ListTile(
    dense: true,
    leading: ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: Image.asset(
        asset,
        width: 40,
        height: 40,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) =>
            Container(width: 40, height: 40, color: Colors.grey.shade300),
      ),
    ),
    title: Text(name, style: const TextStyle(fontSize: 13)),
    subtitle: Text(time, style: const TextStyle(color: _teal, fontSize: 11)),
    trailing: TextButton(
      onPressed: () => Navigator.pushNamed(
        context,
        '/transit_details',
        arguments: {'name': name, 'asset': asset},
      ),
      child: const Text('Detail'),
    ),
  );
}

class TransitDetailsScreen extends StatelessWidget {
  const TransitDetailsScreen({
    super.key,
    required this.name,
    required this.asset,
  });
  final String name;
  final String asset;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: ecoWalkInfoAppBar(context, 'Transportasi Umum'),
    body: ListView(
      padding: const EdgeInsets.only(bottom: 24),
      children: [
        _hero(asset, 'Rekomendasi'),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
          child: Text(
            name.toUpperCase(),
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              _accordion('Biaya', 'Rp. 3.500 (tarif flat TransJakarta)'),
              _accordion(
                'Estimasi',
                '±60–75 menit (tergantung kondisi lalu lintas dan waktu tunggu)',
              ),
              _accordion(
                'Keberangkatan',
                'Perkiraan keberangkatan dari Halte Duri Kepa:\nPukul 18.00 WIB',
                action: 'Selengkapnya',
                onTap: () => Navigator.pushNamed(context, '/departures'),
              ),
              _accordion(
                'Informasi Kepadatan',
                'Kepadatan di halte SSSSS tergolong Rendah/Sedang/Tinggi',
              ),
              _accordion(
                'Rute yang dilalui',
                'Dari Kedoya Selatan, naik mikrotrans atau ojek online menuju ke halte Kedoya Green Garden\n⋮\nNaik Koridor 8 TransJakarta menuju Halte Harmoni\n⋮\nTransit di Halte Harmoni, lalu naik ke Koridor 1 ke Halte Monas',
              ),
              _accordion(
                'Kelebihan & Kekurangan',
                'Kelebihan\n• Biaya terjangkau\n• Jalur khusus bus mengurangi risiko terjebak macet\n\nKekurangan\n• Perlu transit dan menunggu bus di setiap halte\n• Kepadatan penumpang pada jam sibuk',
                highlighted: true,
                initiallyExpanded: true,
              ),
            ],
          ),
        ),
      ],
    ),
  );

  Widget _accordion(
    String title,
    String content, {
    String? action,
    VoidCallback? onTap,
    bool highlighted = false,
    bool initiallyExpanded = false,
  }) => Card(
    margin: const EdgeInsets.only(bottom: 10),
    elevation: highlighted ? 2 : 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
      side: BorderSide(color: highlighted ? _teal : Colors.black87),
    ),
    child: ExpansionTile(
      initiallyExpanded: initiallyExpanded,
      collapsedBackgroundColor: Colors.white,
      backgroundColor: highlighted ? _teal : Colors.white,
      collapsedShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      iconColor: highlighted ? Colors.white : Colors.black54,
      collapsedIconColor: Colors.black54,
      textColor: highlighted ? Colors.white : Colors.black,
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
      ),
      childrenPadding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            content,
            style: TextStyle(
              color: highlighted ? Colors.white : Colors.black87,
              fontSize: 12,
              height: 1.4,
              fontStyle: title == 'Rute yang dilalui' || highlighted
                  ? FontStyle.normal
                  : FontStyle.italic,
            ),
          ),
        ),
        if (action != null)
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(onPressed: onTap, child: Text(action)),
          ),
      ],
    ),
  );
}

class DeparturesScreen extends StatelessWidget {
  const DeparturesScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: ecoWalkInfoAppBar(context, 'Keberangkatan'),
    backgroundColor: _teal,
    body: LayoutBuilder(
      builder: (context, constraints) {
        const sourceWidth = 393.0;
        const sourceHeight = 1221.0;
        const mapStart = 101.0;
        const mapEnd = 384.0;
        const cardStart = 384.0;
        final scale = constraints.maxWidth / sourceWidth;
        final mapHeight = (mapEnd - mapStart) * scale;

        return Stack(
          children: [
            Positioned.fill(child: ColoredBox(color: _teal)),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: mapHeight,
              child: ClipRect(
                child: OverflowBox(
                  alignment: Alignment.topCenter,
                  minWidth: constraints.maxWidth,
                  maxWidth: constraints.maxWidth,
                  minHeight: sourceHeight * scale,
                  maxHeight: sourceHeight * scale,
                  child: Transform.translate(
                    offset: Offset(0, -mapStart * scale),
                    child: Image.asset(
                      'lib/assets/images/MAPS.png',
                      width: constraints.maxWidth,
                      height: sourceHeight * scale,
                      fit: BoxFit.fill,
                      errorBuilder: (_, __, ___) => ColoredBox(
                        color: Colors.grey.shade300,
                        child: const SizedBox.expand(),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            ListView.builder(
              padding: EdgeInsets.fromLTRB(
                16,
                (cardStart - mapStart) * scale,
                16,
                24,
              ),
              itemCount: 6,
              itemBuilder: (context, index) => Card(
                margin: const EdgeInsets.only(bottom: 9),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(minHeight: 110),
                  child: Padding(
                    padding: const EdgeInsets.all(13),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Keberangkatan',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 3,
                                    ),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFFFA000),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Text(
                                      index == 0 ? 'Koridor' : 'Bus 2',
                                      style: const TextStyle(fontSize: 11),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Flexible(
                                    child: Text(
                                      index == 0
                                          ? 'Ta → Kota'
                                          : 'lorem ipsum → blablabla',
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(fontSize: 11),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5),
                              Text(
                                index == 0 ? 'Terlambat 11 mnt' : 'Dijadwalkan',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: index == 0
                                      ? Colors.red
                                      : Colors.black54,
                                ),
                              ),
                              const Text(
                                'Bisa berubah tergantung kepadatan lalu lintas',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontStyle: FontStyle.italic,
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          index == 0 ? '11\nmnt' : '23.23',
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 19),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    ),
  );
}

Widget _placeCard(
  BuildContext context,
  String name,
  String location,
  String price,
  String image,
  VoidCallback onTap,
) => GestureDetector(
  onTap: onTap,
  child: ClipRRect(
    borderRadius: BorderRadius.circular(10),
    child: SizedBox(
      width: 153,
      height: 220,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            image,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) =>
                Container(color: Colors.grey.shade300),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 76,
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
            left: 7,
            right: 6,
            bottom: 7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    const Icon(Icons.location_on, color: Colors.red, size: 10),
                    Expanded(
                      child: Text(
                        location,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 7,
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  'Mulai dari $price',
                  style: const TextStyle(color: Colors.white, fontSize: 7),
                ),
                const Text(
                  '★★★★★',
                  style: TextStyle(color: Colors.amber, fontSize: 11),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  ),
);

Widget _mapPreview(String asset, double height) => ClipRRect(
  borderRadius: BorderRadius.circular(10),
  child: Image.asset(
    asset,
    width: double.infinity,
    height: height,
    fit: BoxFit.cover,
    errorBuilder: (_, __, ___) =>
        Container(height: height, color: Colors.grey.shade300),
  ),
);

Widget _hero(String asset, String badge) => Stack(
  clipBehavior: Clip.none,
  children: [
    Image.asset(
      asset,
      width: double.infinity,
      height: 180,
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) =>
          Container(height: 180, color: Colors.grey.shade300),
    ),
    Positioned(
      right: 0,
      bottom: -12,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(7),
          boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 4)],
        ),
        child: Text(
          badge,
          style: const TextStyle(
            color: _teal,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ),
    ),
  ],
);

Widget _iconInfo(IconData icon, String value) => Padding(
  padding: const EdgeInsets.only(bottom: 5),
  child: Row(
    children: [
      Icon(icon, size: 17),
      const SizedBox(width: 8),
      Text(value, style: const TextStyle(fontSize: 14)),
    ],
  ),
);

Widget _analysisCard(bool transit) => Card(
  elevation: 2,
  color: const Color(0xFFF4F4F4),
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(11)),
  child: Padding(
    padding: const EdgeInsets.all(13),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Analisis Perjalanan',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 14),
        _comparisonGroup(
          transit ? 'Dibandingkan Naik Ojek Online' : 'Dibandingkan Naik Taxi',
          'Waktu',
          transit ? '30 mnt Lebih lambat' : '5 mnt Lebih cepat',
          'Hemat',
          transit ? 'Kendaraan Umum' : 'Ojek Online',
          'Kenyamanan',
          'Taxi',
        ),
        const Divider(),
        _comparisonGroup(
          transit ? 'Dibandingkan Taxi' : 'Dibandingkan Kendaraan Umum',
          'Waktu',
          transit ? '20-40 mnt Lebih cepat' : '15 mnt Lebih lambat',
          'Hemat',
          transit ? 'Kendaraan Umum' : 'Kendaraan Umum',
          'Kenyamanan',
          'Taxi',
        ),
      ],
    ),
  ),
);

Widget _comparisonGroup(
  String title,
  String label1,
  String value1,
  String label2,
  String value2,
  String label3,
  String value3,
) => Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Text(
      title,
      style: const TextStyle(
        color: _teal,
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
    ),
    _comparisonRow(label1, value1),
    _comparisonRow(label2, value2),
    _comparisonRow(label3, value3),
  ],
);

Widget _comparisonRow(String label, String value) => Padding(
  padding: const EdgeInsets.symmetric(vertical: 8),
  child: Row(
    children: [
      Expanded(child: Text(label, style: const TextStyle(fontSize: 12))),
      Text(value, style: const TextStyle(fontSize: 12)),
    ],
  ),
);
