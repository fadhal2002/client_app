import 'package:client_app/core/servers/app_servers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileSection extends StatelessWidget {
  const ProfileSection({super.key});

  @override
  Widget build(BuildContext context) {
    AppServices appServices = Provider.of<AppServices>(context, listen: false);
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/EditProfileScreen');
      },

      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.05),
              spreadRadius: 2,
              blurRadius: 10,
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF4158D0), Color(0xFFC850C0)],
                ),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '${appServices.shared.getString("firstName")!.substring(0, 1)}${appServices.shared.getString("lastName")!.substring(0, 1)}'
                      .toUpperCase(),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
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
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1A1E2C),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    appServices.shared.getString("phoneNumber")!,
                    style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFF4158D0).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.edit_outlined,
                size: 18,
                color: Color(0xFF4158D0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
