import 'package:client_app/core/servers/app_servers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CityDropdownField extends StatefulWidget {
  final String label;
  final String hint;
  final IconData icon;
  final String? selectedValue;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  const CityDropdownField({
    super.key,
    required this.label,
    required this.hint,
    required this.icon,
    required this.selectedValue,
    required this.items,
    required this.onChanged,
  });

  @override
  State<CityDropdownField> createState() => _CityDropdownFieldState();
}

class _CityDropdownFieldState extends State<CityDropdownField> {
  List<String> filteredCities = [];
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredCities = widget.items;
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void _filterCities(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredCities = widget.items;
      } else {
        filteredCities = widget.items
            .where((city) => city.contains(query))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(widget.icon, size: 16, color: const Color(0xFF1A1E2C)),
            const SizedBox(width: 8),
            Text(
              widget.label,
              style: const TextStyle(
                color: Color(0xFF1A1E2C),
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () {
            _showCityPicker(context);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFFF8F9FC),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: widget.selectedValue != null
                    ? const Color(0xFF1A1E2C)
                    : const Color(0xFFE0E0E0),
                width: widget.selectedValue != null ? 2 : 1,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    widget.selectedValue ?? widget.hint,
                    style: TextStyle(
                      color: widget.selectedValue != null
                          ? const Color(0xFF1A1E2C)
                          : Colors.grey[400],
                      fontSize: 14,
                      fontWeight: widget.selectedValue != null
                          ? FontWeight.w500
                          : FontWeight.w400,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1A1E2C).withOpacity(0.06),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: Colors.grey[600],
                    size: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _showCityPicker(BuildContext context) {
    // Reset search when opening
    searchController.clear();
    filteredCities = widget.items;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      isDismissible: true,
      enableDrag: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Container(
              // Increased height to 85% for better visibility
              height: MediaQuery.of(context).size.height * 0.85,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: Column(
                children: [
                  // Handle bar
                  Container(
                    margin: const EdgeInsets.only(top: 12),
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Header
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'اختر المحافظة',
                          style: TextStyle(
                            color: Color(0xFF1A1E2C),
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'إلغاء',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Search bar
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8F9FC),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: const Color(0xFFE0E0E0),
                          width: 1,
                        ),
                      ),
                      child: TextField(
                        controller: searchController,
                        onChanged: (value) {
                          setState(() {
                            _filterCities(value);
                          });
                        },
                        decoration: InputDecoration(
                          hintText: 'ابحث عن المحافظة...',
                          hintStyle: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 14,
                          ),
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.grey[400],
                            size: 20,
                          ),
                          suffixIcon: searchController.text.isNotEmpty
                              ? IconButton(
                                  icon: Icon(
                                    Icons.clear,
                                    color: Colors.grey[400],
                                    size: 20,
                                  ),
                                  onPressed: () {
                                    searchController.clear();
                                    setState(() {
                                      filteredCities = widget.items;
                                    });
                                  },
                                )
                              : null,
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 12,
                          ),
                        ),
                        style: const TextStyle(
                          color: Color(0xFF1A1E2C),
                          fontSize: 14,
                        ),
                        textInputAction: TextInputAction.done,
                        onSubmitted: (value) {
                          // Dismiss keyboard on done
                          FocusScope.of(context).unfocus();
                        },
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Result count
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Text(
                          '${filteredCities.length} محافظة',
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Spacer(),
                        if (searchController.text.isNotEmpty)
                          Text(
                            'نتائج البحث',
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 8),

                  // City list - with more space
                  Expanded(
                    child: filteredCities.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.search_off,
                                  color: Colors.grey[400],
                                  size: 48,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'لا توجد نتائج',
                                  style: TextStyle(
                                    color: Colors.grey[500],
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  'حاول البحث بكلمة مختلفة',
                                  style: TextStyle(
                                    color: Colors.grey[400],
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : ListView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            itemCount: filteredCities.length,
                            itemBuilder: (context, index) {
                              final city = filteredCities[index];
                              final isSelected = city == widget.selectedValue;
                              return GestureDetector(
                                onTap: () {
                                  widget.onChanged(city);
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(bottom: 4),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 14,
                                  ),
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? const Color(
                                            0xFF1A1E2C,
                                          ).withOpacity(0.06)
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: isSelected
                                          ? const Color(0xFF1A1E2C)
                                          : Colors.transparent,
                                      width: 1.5,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          city,
                                          style: TextStyle(
                                            color: isSelected
                                                ? const Color(0xFF1A1E2C)
                                                : const Color(
                                                    0xFF1A1E2C,
                                                  ).withOpacity(0.7),
                                            fontSize: 16,
                                            fontWeight: isSelected
                                                ? FontWeight.w600
                                                : FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                      if (isSelected)
                                        Container(
                                          width: 22,
                                          height: 22,
                                          decoration: const BoxDecoration(
                                            color: Color(0xFF1A1E2C),
                                            shape: BoxShape.circle,
                                          ),
                                          child: const Icon(
                                            Icons.check,
                                            color: Colors.white,
                                            size: 14,
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            );
          },
        );
      },
    ).then((_) {
      // Reset search when bottom sheet is closed
      searchController.clear();
      filteredCities = widget.items;
    });
  }
}
