import 'package:client_app/core/servers/app_servers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileSection extends StatelessWidget {
  const ProfileSection({super.key});

  @override
  Widget build(BuildContext context) {
    AppServices appServices = Provider.of<AppServices>(context, listen: false);
    
    // Get account type from shared preferences
    String accountType = appServices.shared.getString('accountType') ?? 'غير محدد';
    String accountTypeDisplay = '';
    IconData accountTypeIcon = Icons.person_outline;
    Color accountTypeColor = const Color(0xFF4158D0);
    String accountTypeBadge = '';
    
    // Set display text and icon based on account type
    if (accountType == 'business') {
      accountTypeDisplay = 'حساب تجاري';
      accountTypeIcon = Icons.business_center;
      accountTypeColor = const Color(0xFF4158D0);
      accountTypeBadge = '⭐ مميز';
    } else if (accountType == 'personal') {
      accountTypeDisplay = 'حساب فردي';
      accountTypeIcon = Icons.person_outline;
      accountTypeColor = const Color(0xFFC850C0);
      accountTypeBadge = '📌 أساسي';
    } else {
      accountTypeDisplay = 'نوع الحساب غير محدد';
      accountTypeIcon = Icons.help_outline;
      accountTypeColor = Colors.grey;
      accountTypeBadge = '⚠️ غير محدد';
    }
    
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/EditProfileScreen');
      },
      child: Container(
        padding: const EdgeInsets.all(0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.05),
              spreadRadius: 2,
              blurRadius: 10,
            ),
          ],
        ),
        child: Column(
          children: [
            // Top Section: Cover with gradient
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    const Color(0xFF4158D0),
                    const Color(0xFFC850C0),
                  ],
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: Row(
                children: [
                  // Avatar with border
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white,
                        width: 3,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: Center(
                        child: Icon(
                          Icons.person,
                          size: 32,
                          color: const Color(0xFF4158D0),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${appServices.shared.getString("firstName")} ${appServices.shared.getString("lastName")}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(
                              Icons.phone,
                              size: 14,
                              color: Colors.white70,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              appServices.shared.getString("phoneNumber")!,
                              textDirection: TextDirection.ltr,
                              style: const TextStyle(
                                fontSize: 13,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.edit_outlined,
                      size: 18,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            
            // Bottom Section: Account Type Info
            Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  // Account Type Icon with Circle Background
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          accountTypeColor.withValues(alpha: 0.1),
                          accountTypeColor.withValues(alpha: 0.2),
                        ],
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      accountTypeIcon,
                      size: 24,
                      color: accountTypeColor,
                    ),
                  ),
                  const SizedBox(width: 14),
                  // Account Type Details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'نوع الحساب',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[500],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          accountTypeDisplay,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1A1E2C),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Badge
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          accountTypeColor,
                          accountTypeColor.withValues(alpha: 0.7),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      accountTypeBadge,
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}