import 'package:client_app/screen/view/home/HomePage/AddDelivery/package_details_screen.dart';
import 'package:flutter/material.dart';

class PackageDestinationScreen extends StatefulWidget {
  const PackageDestinationScreen({super.key});

  @override
  State<PackageDestinationScreen> createState() =>
      _PackageDestinationScreenState();
}

class _PackageDestinationScreenState extends State<PackageDestinationScreen> {
  // Selected values (non-functional)
  String? _selectedGovernorate;
  String? _selectedArea;
  String? _selectedDeliveryType;
  String? _selectedVehicleType;

  // Controllers (non-functional)
  final TextEditingController _recipientNameController =
      TextEditingController();
  final TextEditingController _primaryPhoneController = TextEditingController();
  final TextEditingController _secondaryPhoneController =
      TextEditingController();
  final TextEditingController _addressDetailsController =
      TextEditingController();

  // Sample data
  final List<String> _governorates = [
    'بغداد',
    'الأنبار',
    'البصرة',
    'نينوى',
    'النجف',
    'كربلاء',
    'ديالى',
    'صلاح الدين',
    'ذي قار',
    'ميسان',
    'المثنى',
    'الديوانية',
    'واسط',
    'بابل',
    'كركوك',
  ];

  final List<String> _areas = [
    'الكرادة',
    'المنصور',
    'الجادرية',
    'الزعفرانية',
    'بغداد الجديدة',
    'الاعظمية',
    'الكاظمية',
    'الحرية',
    'اليرموك',
    'المستنصرية',
  ];

  final List<Map<String, dynamic>> _deliveryTypes = [
    {
      'title': 'توصيل لبيت المستلم',
      'subtitle': 'Last Mile Delivery',
      'icon': Icons.home_rounded,
      'description': 'يتم توصيل الطرد إلى عنوان المستلم',
    },
    {
      'title': 'استلام من الكراج',
      'subtitle': 'Pickup from Warehouse',
      'icon': Icons.warehouse_rounded,
      'description': 'يستلم المستلم الطرد من الكراج',
    },
  ];

  final List<String> _vehicleTypes = [
    'سيارة صغيرة',
    'سيارة متوسطة',
    'شاحنة صغيرة',
    'شاحنة كبيرة',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FC),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'وجهة الطرد والمستلم',
          style: TextStyle(
            color: Color(0xFF1A1E2C),
            fontWeight: FontWeight.w600,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          color: const Color(0xFF1A1E2C),
          onPressed: () => Navigator.pop(context),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Row(
              children: [
                _buildStepIndicator(1, 'المصدر', false),
                _buildStepConnector(true),
                _buildStepIndicator(2, 'الوجهة', true),
                _buildStepConnector(false),
                _buildStepIndicator(3, 'التأكيد', false),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Step label
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFF4F46E5).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'الخطوة 2 من 3',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF4F46E5),
                ),
              ),
            ),
            const SizedBox(height: 16),

            const Text(
              'معلومات الوجهة والمستلم',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A1E2C),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'أدخل معلومات المستلم وتفاصيل العنوان',
              style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
            ),
            const SizedBox(height: 24),

            // ===== Location Section =====
            _buildSectionTitle('الموقع', 'اختر المحافظة والمنطقة'),
            const SizedBox(height: 12),

            // Governorate Dropdown
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 10,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Governorate
                  ListTile(
                    leading: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color(0xFF4F46E5).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.location_city_rounded,
                        color: Color(0xFF4F46E5),
                        size: 20,
                      ),
                    ),
                    title: const Text(
                      'المحافظة',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                      ),
                    ),
                    subtitle: Text(
                      _selectedGovernorate ?? 'اختر المحافظة',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: _selectedGovernorate != null
                            ? const Color(0xFF1A1E2C)
                            : Colors.grey.shade400,
                      ),
                    ),
                    trailing: const Icon(
                      Icons.arrow_drop_down_rounded,
                      color: Colors.grey,
                      size: 28,
                    ),
                    onTap: () => _showGovernoratePicker(context),
                  ),
                  Divider(
                    height: 1,
                    thickness: 1,
                    color: Colors.grey.shade100,
                    indent: 16,
                    endIndent: 16,
                  ),

                  // Area
                  ListTile(
                    leading: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color(0xFF4F46E5).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.map_rounded,
                        color: Color(0xFF4F46E5),
                        size: 20,
                      ),
                    ),
                    title: const Text(
                      'المنطقة',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                      ),
                    ),
                    subtitle: Text(
                      _selectedArea ?? 'اختر المنطقة',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: _selectedArea != null
                            ? const Color(0xFF1A1E2C)
                            : Colors.grey.shade400,
                      ),
                    ),
                    trailing: const Icon(
                      Icons.arrow_drop_down_rounded,
                      color: Colors.grey,
                      size: 28,
                    ),
                    onTap: () => _showAreaPicker(context),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Address Details
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 10,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: TextField(
                controller: _addressDetailsController,
                maxLines: 3,
                textAlign: TextAlign.right,
                decoration: InputDecoration(
                  hintText: 'تفاصيل العنوان (شارع، بناء، طابق، ملاحظات)',
                  hintStyle: TextStyle(
                    color: Colors.grey.shade400,
                    fontSize: 14,
                  ),
                  prefixIcon: const Icon(
                    Icons.note_add_rounded,
                    color: Colors.grey,
                    size: 22,
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 16,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // ===== Recipient Section =====
            _buildSectionTitle('المستلم', 'أدخل معلومات المستلم'),
            const SizedBox(height: 12),

            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 10,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Recipient Name
                  ListTile(
                    leading: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.person_rounded,
                        color: Colors.blue,
                        size: 20,
                      ),
                    ),
                    title: const Text(
                      'اسم المستلم',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                      ),
                    ),
                    subtitle: SizedBox(
                      width: 200,
                      child: TextField(
                        controller: _recipientNameController,
                        textAlign: TextAlign.right,
                        decoration: const InputDecoration(
                          hintText: 'أدخل اسم المستلم',
                          hintStyle: TextStyle(fontSize: 14),
                          border: InputBorder.none,
                          isDense: true,
                        ),
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF1A1E2C),
                        ),
                      ),
                    ),
                  ),
                  Divider(
                    height: 1,
                    thickness: 1,
                    color: Colors.grey.shade100,
                    indent: 16,
                    endIndent: 16,
                  ),

                  // Primary Phone
                  ListTile(
                    leading: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.phone_android_rounded,
                        color: Colors.green,
                        size: 20,
                      ),
                    ),
                    title: const Text(
                      'رقم أساسي',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                      ),
                    ),
                    subtitle: SizedBox(
                      width: 200,
                      child: TextField(
                        controller: _primaryPhoneController,
                        textAlign: TextAlign.right,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          hintText: 'أدخل رقم الهاتف الأساسي',
                          hintStyle: TextStyle(fontSize: 14),
                          border: InputBorder.none,
                          isDense: true,
                        ),
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF1A1E2C),
                        ),
                      ),
                    ),
                  ),
                  Divider(
                    height: 1,
                    thickness: 1,
                    color: Colors.grey.shade100,
                    indent: 16,
                    endIndent: 16,
                  ),

                  // Secondary Phone
                  ListTile(
                    leading: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.orange.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.phone_rounded,
                        color: Colors.orange,
                        size: 20,
                      ),
                    ),
                    title: const Text(
                      'رقم ثاني (احتياطي)',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                      ),
                    ),
                    subtitle: SizedBox(
                      width: 200,
                      child: TextField(
                        controller: _secondaryPhoneController,
                        textAlign: TextAlign.right,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          hintText: 'أدخل رقم احتياطي (اختياري)',
                          hintStyle: TextStyle(fontSize: 14),
                          border: InputBorder.none,
                          isDense: true,
                        ),
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF1A1E2C),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // ===== Delivery Type Section =====
            _buildSectionTitle('نوع التسليم', 'اختر طريقة التسليم'),
            const SizedBox(height: 12),

            Row(
              children: _deliveryTypes.map((type) {
                final isSelected = _selectedDeliveryType == type['title'];
                return Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedDeliveryType = type['title'];
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: EdgeInsets.only(
                        right: type == _deliveryTypes.first ? 0 : 6,
                        left: type == _deliveryTypes.last ? 0 : 6,
                      ),
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFF4F46E5).withOpacity(0.08)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: isSelected
                              ? const Color(0xFF4F46E5)
                              : Colors.grey.shade200,
                          width: isSelected ? 2 : 1.5,
                        ),
                        boxShadow: isSelected
                            ? [
                                BoxShadow(
                                  color: const Color(
                                    0xFF4F46E5,
                                  ).withOpacity(0.15),
                                  blurRadius: 12,
                                  spreadRadius: 2,
                                ),
                              ]
                            : [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.04),
                                  blurRadius: 8,
                                  spreadRadius: 1,
                                ),
                              ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? const Color(0xFF4F46E5)
                                  : Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              type['icon'],
                              color: isSelected
                                  ? Colors.white
                                  : Colors.grey.shade600,
                              size: 24,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            type['title'],
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: isSelected
                                  ? const Color(0xFF4F46E5)
                                  : const Color(0xFF1A1E2C),
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            type['subtitle'],
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.grey.shade500,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            type['description'],
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.grey.shade400,
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 24),

            // ===== Vehicle Type Section =====
            _buildSectionTitle('نوع المركبة', 'اختر المركبة المناسبة'),
            const SizedBox(height: 12),

            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 10,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: Column(
                children: _vehicleTypes.map((vehicle) {
                  final isLast = vehicle == _vehicleTypes.last;
                  final isSelected = _selectedVehicleType == vehicle;
                  return Column(
                    children: [
                      ListTile(
                        leading: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? const Color(0xFF4F46E5).withOpacity(0.1)
                                : Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(
                            Icons.directions_car_rounded,
                            color: isSelected
                                ? const Color(0xFF4F46E5)
                                : Colors.grey.shade600,
                            size: 20,
                          ),
                        ),
                        title: Text(
                          vehicle,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: isSelected
                                ? FontWeight.w600
                                : FontWeight.w500,
                            color: isSelected
                                ? const Color(0xFF4F46E5)
                                : const Color(0xFF1A1E2C),
                          ),
                        ),
                        trailing: isSelected
                            ? Container(
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF4F46E5),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.check_rounded,
                                  color: Colors.white,
                                  size: 14,
                                ),
                              )
                            : null,
                        onTap: () {
                          setState(() {
                            _selectedVehicleType = vehicle;
                          });
                        },
                      ),
                      if (!isLast)
                        Divider(
                          height: 1,
                          thickness: 1,
                          color: Colors.grey.shade100,
                          indent: 16,
                          endIndent: 16,
                        ),
                    ],
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 32),

            // ===== Continue Button =====
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PackageDetailsScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4F46E5),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'متابعة',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1A1E2C),
          ),
        ),
        const SizedBox(height: 2),
        Text(
          subtitle,
          style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
        ),
      ],
    );
  }

  Widget _buildStepIndicator(int number, String label, bool isActive) {
    return Expanded(
      child: Column(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: isActive ? const Color(0xFF4F46E5) : Colors.grey.shade200,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                number.toString(),
                style: TextStyle(
                  color: isActive ? Colors.white : Colors.grey.shade500,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
              color: isActive ? const Color(0xFF4F46E5) : Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepConnector(bool isActive) {
    return Expanded(
      child: Container(
        height: 2,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        color: isActive ? const Color(0xFF4F46E5) : Colors.grey.shade200,
      ),
    );
  }

  void _showGovernoratePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          height: 300,
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'اختر المحافظة',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: ListView.builder(
                  itemCount: _governorates.length,
                  itemBuilder: (context, index) {
                    final governorate = _governorates[index];
                    return ListTile(
                      title: Text(governorate),
                      trailing: _selectedGovernorate == governorate
                          ? const Icon(Icons.check, color: Color(0xFF4F46E5))
                          : null,
                      onTap: () {
                        setState(() {
                          _selectedGovernorate = governorate;
                        });
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showAreaPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          height: 300,
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'اختر المنطقة',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: ListView.builder(
                  itemCount: _areas.length,
                  itemBuilder: (context, index) {
                    final area = _areas[index];
                    return ListTile(
                      title: Text(area),
                      trailing: _selectedArea == area
                          ? const Icon(Icons.check, color: Color(0xFF4F46E5))
                          : null,
                      onTap: () {
                        setState(() {
                          _selectedArea = area;
                        });
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
