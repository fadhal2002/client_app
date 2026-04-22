import 'package:client_app/controller/home/custom_map_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LocationSearchBar extends GetView<CustomMapControllerImp> {
  const LocationSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 50,
      left: 15,
      right: 15,
      child: Column(
        children: [
          Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: TextField(
              controller: controller.searchController,
              decoration: InputDecoration(
                hintText: "ابحث في النجف عبر OSM...",
                prefixIcon: const Icon(Icons.search, color: Colors.green),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () => controller.clearSearch(),
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 20,
                ),
              ),
              onChanged: controller.getOSMSuggestions,
            ),
          ),
          if (controller.suggestions.isNotEmpty)
            Container(
              margin: const EdgeInsets.only(top: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(color: Colors.black26, blurRadius: 5),
                ],
              ),
              constraints: const BoxConstraints(maxHeight: 300),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: controller.suggestions.length,
                itemBuilder: (context, index) {
                  final item = controller.suggestions[index];
                  return ListTile(
                    leading: const Icon(
                      Icons.map_outlined,
                      color: Colors.blueGrey,
                    ),
                    title: Text(
                      item['display_name'],
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    onTap: () => controller.selectLocation(item),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
