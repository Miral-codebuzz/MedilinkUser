// ignore_for_file: file_names

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class Searchcontroller extends GetxController {
  TextEditingController search = TextEditingController();
  RxList<String> recentSearches =
      <String>[
        'Snake Skin Bag',
        'Casual Shirt',
        'Black Nike Shoes',
        'Airtight Microphone',
        'Headphones White',
        'Nikon Camera',
        'Silver Watch',
        'Kitchen Appliances',
      ].obs;

  RxList<String> searchResults = <String>[].obs;
  RxBool showDropdown = false.obs;
  RxBool onhide = false.obs;

  void performSearch(String query) {
    onhide.value = true;
    if (query.isEmpty) return;

    if (!recentSearches.contains(query)) {
      recentSearches.insert(0, query);
    }

    // Dummy results
    searchResults.assignAll([
      "$query Result 1",
      "$query Result 2",
      "$query Result 3",
    ]);

    showDropdown.value = false;
  }

  void clearRecentSearches() {
    recentSearches.clear();
  }
}
