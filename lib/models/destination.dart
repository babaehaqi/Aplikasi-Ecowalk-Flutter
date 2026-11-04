class Destination {
  const Destination({
    required this.name,
    required this.location,
    required this.price,
    required this.distanceKm,
    required this.rating,
    required this.imageAsset,
    required this.description,
  });

  final String name;
  final String location;
  final int price;
  final double distanceKm;
  final double rating;
  final String imageAsset;
  final String description;

  Map<String, Object> toJson() => {
    'name': name,
    'location': location,
    'price': price,
    'distanceKm': distanceKm,
    'rating': rating,
    'imageAsset': imageAsset,
    'description': description,
  };

  factory Destination.fromJson(Map<String, dynamic> json) => Destination(
    name: json['name'] as String,
    location: json['location'] as String,
    price: json['price'] as int,
    distanceKm: (json['distanceKm'] as num).toDouble(),
    rating: (json['rating'] as num).toDouble(),
    imageAsset: json['imageAsset'] as String,
    description: json['description'] as String,
  );

  String get formattedPrice => 'Rp. ${_formatThousands(price)}';

  static String _formatThousands(int value) {
    final digits = value.toString();
    final result = StringBuffer();
    for (var i = 0; i < digits.length; i++) {
      if (i > 0 && (digits.length - i) % 3 == 0) result.write('.');
      result.write(digits[i]);
    }
    return result.toString();
  }
}

const dufanDestination = Destination(
  name: 'Dunia Fantasi (DUFAN)',
  location: 'Ancol, Jakarta Utara',
  price: 200000,
  distanceKm: 1.68,
  rating: 4.75,
  imageAsset: 'lib/assets/images/dufan.png',
  description: 'Dufan (Dunia Fantasi) adalah taman hiburan yang terletak di kawasan Taman Impian Ancol...',
);

const destinations = <Destination>[dufanDestination];

const dufanAddress =
    'Jl. Lodan Timur No.7, Ancol, Kec. Pademangan, Jkt Utara, Daerah Khusus Ibukota Jakarta 14430';
