import 'package:client_app/models/map_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MapSearchBar extends StatelessWidget {
  const MapSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    final mapModel = context.read<MapModelImpl>();

    return Positioned(
      top: 48,
      left: 16,
      right: 16,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Search Bar - Very Noticeable
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white,
                  Colors.grey.shade50,
                ],
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF4F46E5).withOpacity(0.2),
                  blurRadius: 25,
                  spreadRadius: 5,
                  offset: const Offset(0, 8),
                ),
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 12,
                  spreadRadius: 2,
                  offset: const Offset(0, 4),
                ),
              ],
              border: Border.all(
                color: Colors.white,
                width: 2,
              ),
            ),
            child: TextField(
              controller: mapModel.searchController,
              textAlign: TextAlign.right,
              decoration: InputDecoration(
                hintText: "📍 ابحث عن موقعك...",
                hintStyle: TextStyle(
                  color: Colors.grey.shade500,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                prefixIcon: Container(
                  margin: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xFF4F46E5),
                        const Color(0xFF7C3AED),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.search_rounded,
                    color: Colors.white,
                    size: 22,
                  ),
                ),
                suffixIcon: mapModel.searchController.text.isNotEmpty
                    ? Container(
                        margin: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          icon: Icon(
                            Icons.close_rounded,
                            color: Colors.grey.shade700,
                            size: 20,
                          ),
                          onPressed: () {
                            mapModel.clearSuggestions();
                          },
                        ),
                      )
                    : null,
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 16,
                ),
                filled: true,
                fillColor: Colors.transparent,
              ),
              onChanged: mapModel.getOSMSuggestions,
            ),
          ),

          // Suggestions
          if (mapModel.suggestions.isNotEmpty)
            Container(
              margin: const EdgeInsets.only(top: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.12),
                    blurRadius: 20,
                    spreadRadius: 2,
                    offset: const Offset(0, 8),
                  ),
                ],
                border: Border.all(
                  color: Colors.grey.shade100,
                  width: 1,
                ),
              ),
              constraints: const BoxConstraints(maxHeight: 260),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  itemCount: mapModel.suggestions.length,
                  itemBuilder: (context, index) {
                    final item = mapModel.suggestions[index];
                    final isLast = index == mapModel.suggestions.length - 1;
                    
                    return Column(
                      children: [
                        ListTile(
                          leading: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  const Color(0xFF4F46E5).withOpacity(0.1),
                                  const Color(0xFF7C3AED).withOpacity(0.1),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(
                              Icons.location_on_rounded,
                              color: const Color(0xFF4F46E5),
                              size: 20,
                            ),
                          ),
                          title: Text(
                            item['display_name'] ?? 'موقع غير معروف',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color(0xFF1A1E2C),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          trailing: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF0F4FF),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: const Color(0xFF4F46E5),
                              size: 14,
                            ),
                          ),
                          onTap: () => mapModel.selectLocation(item),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 2,
                          ),
                        ),
                        if (!isLast)
                          Divider(
                            height: 0,
                            thickness: 1,
                            color: Colors.grey.shade100,
                            indent: 16,
                            endIndent: 16,
                          ),
                      ],
                    );
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }
}