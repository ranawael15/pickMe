
import 'package:flutter/material.dart';
import 'trip_primary_button.dart';
import 'trip_theme_constants.dart';

class TripSuccessDialog extends StatelessWidget {
  final String destination;
  final VoidCallback onCancel;
  final VoidCallback onBookNow;

  const TripSuccessDialog({
    super.key,
    required this.destination,
    required this.onCancel,
    required this.onBookNow,
  });

  static Future<void> show(
      BuildContext context, {
        required String destination,
        required VoidCallback onCancel,
        required VoidCallback onBookNow,
      }) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => TripSuccessDialog(
        destination: destination,
        onCancel: onCancel,
        onBookNow: onBookNow,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
      elevation: 0,
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 84,
              height: 84,
              decoration: BoxDecoration(
                color: const Color(0xFFFBE7A1),
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 4),
              ),
              child: const Center(
                child: Icon(
                  Icons.check_circle,
                  color: Color(0xFF5D4807),
                  size: 44,
                ),
              ),
            ),

            const SizedBox(height: 20),

            Text(
              "Yalla, You're Going to\n$destination! 🇪🇬",
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: TripColors.textDark,
                height: 1.25,
              ),
            ),

            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: TripColors.peachBanner,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.cloud_outlined,
                    size: 16,
                    color: TripColors.textMuted,
                  ),
                ),
                const SizedBox(width: 10),
                const Flexible(
                  child: Text(
                    'Your trip has been saved successfully!',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: TripColors.textMuted,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 28),

            TripPrimaryButton(
              text: 'Go to Book Now',
              icon: Icons.arrow_forward,
              onPressed: onBookNow,
            ),

            const SizedBox(height: 12),

            TripPrimaryButton(
              text: 'Cancel',
              isSecondary: true,
              onPressed: onCancel,
            ),
          ],
        ),
      ),
    );
  }
}
