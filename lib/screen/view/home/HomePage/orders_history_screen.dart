// order_history_screen.dart
import 'package:flutter/material.dart';

class OrdersHistoryScreen extends StatelessWidget {
  const OrdersHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F9FC),
        appBar: AppBar(
          title: const Text(
            'طلباتي السابقة',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          foregroundColor: Colors.black,
          centerTitle: true,
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: _BuildFilterTabs(),
          ),
        ),
        body: const TabBarView(
          children: [
            _OrdersList(showAll: true),
            _OrdersList(statusFilter: 'قيد التوصيل'),
            _OrdersList(statusFilter: 'مكتملة'),
            _OrdersList(statusFilter: 'ملغية'),
          ],
        ),
      ),
    );
  }
}

class _BuildFilterTabs extends StatelessWidget {
  const _BuildFilterTabs();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: const TabBar(
        tabs: [
          Tab(text: 'الكل'),
          Tab(text: 'قيد التوصيل'),
          Tab(text: 'مكتملة'),
          Tab(text: 'ملغية'),
        ],
        indicatorWeight: 3,
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorPadding: EdgeInsets.symmetric(horizontal: 16),
        indicatorColor: Color(0xFF2563EB),
        labelColor: Color(0xFF2563EB),
        unselectedLabelColor: Colors.grey,
        labelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        unselectedLabelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
      ),
    );
  }
}

class _OrdersList extends StatelessWidget {
  final String? statusFilter;
  final bool showAll;

  const _OrdersList({
    this.statusFilter,
    this.showAll = false,
  });

  @override
  Widget build(BuildContext context) {
    // Sample orders data using the actual structure
    final allOrders = [
      OrderData(
        orderId: '1778035196731',
        orderDate: '6 مايو 2026',
        orderTime: '05:39',
        customerName: 'فاضل عباس',
        customerPhone: '783 782 2558',
        pickupAddress: 'حي العدالة, ناحية مرکز قضاء النجف, قضاء النجف, محافظة النجف, 54003, العراق',
        dropoffAddress: 'حي السلام, ناحية مرکز قضاء النجف, قضاء النجف, محافظة النجف, 54001, العراق',
        distance: '3.8 كم',
        duration: '5 دقيقة',
        estimatedPrice: '8750',
        orderStatus: 'قيد الانتظار',
        paymentMethod: 'cash',
        selectedVehicleType: 'fast',
        driverName: 'مرتضى',
        driverPhone: '07837822557',
        createdAt: '6 مايو 2026',
      ),
      // Additional sample orders for variety
      OrderData(
        orderId: '1778035123456',
        orderDate: '3 مايو 2026',
        orderTime: '14:20',
        customerName: 'فاضل عباس',
        customerPhone: '783 782 2558',
        pickupAddress: 'مدينة الصدر, بغداد',
        dropoffAddress: 'شارع الكفاح, بغداد',
        distance: '12.5 كم',
        duration: '25 دقيقة',
        estimatedPrice: '12500',
        orderStatus: 'مكتملة',
        paymentMethod: 'cash',
        selectedVehicleType: 'fast',
        driverName: 'أحمد رضا',
        driverPhone: '07701234567',
        createdAt: '3 مايو 2026',
      ),
      OrderData(
        orderId: '1778035098765',
        orderDate: '28 أبريل 2026',
        orderTime: '09:15',
        customerName: 'فاضل عباس',
        customerPhone: '783 782 2558',
        pickupAddress: 'الكرادة, بغداد',
        dropoffAddress: 'المنصور, بغداد',
        distance: '8.2 كم',
        duration: '18 دقيقة',
        estimatedPrice: '9500',
        orderStatus: 'ملغية',
        paymentMethod: 'cash',
        selectedVehicleType: 'fast',
        driverName: 'حسين علي',
        driverPhone: '07709876543',
        createdAt: '28 أبريل 2026',
      ),
      OrderData(
        orderId: '1778035076543',
        orderDate: '20 أبريل 2026',
        orderTime: '16:45',
        customerName: 'فاضل عباس',
        customerPhone: '783 782 2558',
        pickupAddress: 'الزعفرانية, بغداد',
        dropoffAddress: 'الحرية, بغداد',
        distance: '6.7 كم',
        duration: '15 دقيقة',
        estimatedPrice: '8000',
        orderStatus: 'مكتملة',
        paymentMethod: 'cash',
        selectedVehicleType: 'fast',
        driverName: 'مهدي كريم',
        driverPhone: '07811223344',
        createdAt: '20 أبريل 2026',
      ),
    ];

    // Filter orders based on tab
    List<OrderData> filteredOrders;
    if (showAll) {
      filteredOrders = allOrders;
    } else if (statusFilter != null) {
      filteredOrders = allOrders.where((order) {
        if (statusFilter == 'مكتملة') {
          return order.orderStatus == 'مكتملة';
        } else if (statusFilter == 'ملغية') {
          return order.orderStatus == 'ملغية';
        } else if (statusFilter == 'قيد التوصيل') {
          return order.orderStatus == 'قيد الانتظار';
        }
        return false;
      }).toList();
    } else {
      filteredOrders = allOrders;
    }

    if (filteredOrders.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.inbox_outlined,
              size: 80,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              'لا توجد طلبات',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'سجل الطلبات الخاصة بك سيظهر هنا',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[500],
              ),
            ),
          ],
        ),
      );
    }

    return ListView(
      padding: const EdgeInsets.all(16),
      children: filteredOrders.map((order) => _buildOrderCard(order)).toList(),
    );
  }

  Widget _buildOrderCard(OrderData order) {
    // Determine status color and display text
    Color statusColor;
    String statusText;
    
    if (order.orderStatus == 'مكتملة') {
      statusColor = Colors.green;
      statusText = 'تم التسليم';
    } else if (order.orderStatus == 'ملغية') {
      statusColor = Colors.red;
      statusText = 'ملغي';
    } else {
      statusColor = Colors.orange;
      statusText = 'قيد التوصيل';
    }

    // Format package info
    String packageInfo = 'طرود';
    if (order.selectedVehicleType == 'fast') {
      packageInfo = 'توصيل سريع';
    }

    // Extract short addresses
    String shortPickup = _getShortAddress(order.pickupAddress);
    String shortDropoff = _getShortAddress(order.dropoffAddress);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: null, // Non-functional
          borderRadius: BorderRadius.circular(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey.withOpacity(0.15),
                      width: 1,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              '#${order.orderId}',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: order.paymentMethod == 'cash'
                                    ? Colors.amber.withOpacity(0.1)
                                    : Colors.blue.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                order.paymentMethod == 'cash' ? 'كاش' : 'بطاقة',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                  color: order.paymentMethod == 'cash'
                                      ? Colors.amber[800]
                                      : Colors.blue[700],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${order.orderDate} • ${order.orderTime}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: statusColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        statusText,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: statusColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Route info
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Column(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle,
                          ),
                        ),
                        Container(
                          width: 2,
                          height: 30,
                          color: Colors.grey[300],
                        ),
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            shortPickup,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 20),
                          Text(
                            shortDropoff,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '${order.estimatedPrice} د.ع',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2563EB),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${order.distance} • ${order.duration}',
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.blue.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            packageInfo,
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: Colors.blue[700],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Driver info
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 16,
                          backgroundColor: Colors.grey[300],
                          child: const Icon(
                            Icons.person_outline,
                            size: 16,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              order.driverName,
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: Colors.black87,
                              ),
                            ),
                            Text(
                              order.driverPhone,
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.star_border,
                          size: 16,
                          color: Colors.grey[600],
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'تقييم',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(width: 16),
                        Icon(
                          Icons.receipt_outlined,
                          size: 16,
                          color: Colors.grey[600],
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'إعادة الطلب',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
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
  }

  String _getShortAddress(String fullAddress) {
    // Extract first part of the address
    List<String> parts = fullAddress.split(',');
    if (parts.isNotEmpty) {
      return parts[0].trim();
    }
    return fullAddress;
  }
}

// Data model for orders
class OrderData {
  final String orderId;
  final String orderDate;
  final String orderTime;
  final String customerName;
  final String customerPhone;
  final String pickupAddress;
  final String dropoffAddress;
  final String distance;
  final String duration;
  final String estimatedPrice;
  final String orderStatus;
  final String paymentMethod;
  final String selectedVehicleType;
  final String driverName;
  final String driverPhone;
  final String createdAt;

  OrderData({
    required this.orderId,
    required this.orderDate,
    required this.orderTime,
    required this.customerName,
    required this.customerPhone,
    required this.pickupAddress,
    required this.dropoffAddress,
    required this.distance,
    required this.duration,
    required this.estimatedPrice,
    required this.orderStatus,
    required this.paymentMethod,
    required this.selectedVehicleType,
    required this.driverName,
    required this.driverPhone,
    required this.createdAt,
  });
}