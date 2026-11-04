import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'destination.dart';

class RecentlyViewedDestinations {
  RecentlyViewedDestinations._();

  static const _storageKey = 'destinations.recently_viewed';
  static final ValueNotifier<List<Destination>> items =
      ValueNotifier<List<Destination>>([]);

  static Future<void> load() async {
    final preferences = await SharedPreferences.getInstance();
    final encoded = preferences.getString(_storageKey);
    if (encoded == null) return;

    try {
      final data = jsonDecode(encoded) as List<dynamic>;
      items.value = List<Destination>.unmodifiable(
        data.map(
          (entry) => Destination.fromJson(entry as Map<String, dynamic>),
        ),
      );
    } on FormatException {
      await preferences.remove(_storageKey);
      items.value = [];
    } on TypeError {
      await preferences.remove(_storageKey);
      items.value = [];
    }
  }

  static Future<void> add(Destination destination) async {
    final next = [...items.value]
      ..removeWhere((item) => item.name == destination.name)
      ..insert(0, destination);

    items.value = List<Destination>.unmodifiable(next);
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(
      _storageKey,
      jsonEncode(next.map((item) => item.toJson()).toList()),
    );
  }
}
