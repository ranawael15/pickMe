import 'package:flutter/material.dart';

class MockPaymentScreen extends StatefulWidget {
  final String destination;
  final double amount;

  const MockPaymentScreen({
    super.key,
    required this.destination,
    required this.amount,
  });

  @override
  State<MockPaymentScreen> createState() => _MockPaymentScreenState();
}

class _MockPaymentScreenState extends State<MockPaymentScreen> {
  String selectedMethod = 'Visa / Mastercard';
  bool isProcessing = false;

  static const Color background = Color(0xFFFFF8F4);
  static const Color yellow = Color(0xFFF8D967);
  static const Color darkBrown = Color(0xFF302318);
  static const Color secondaryBrown = Color(0xFF685744);

  Future<void> _payNow() async {
    if (isProcessing) return;

    setState(() => isProcessing = true);

    // Simulate payment processing.
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    setState(() => isProcessing = false);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.check_circle, color: Colors.green, size: 65),
              const SizedBox(height: 16),
              const Text(
                'Payment Successful!',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: darkBrown,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: yellow,
                    foregroundColor: darkBrown,
                  ),
                  onPressed: () {
                    Navigator.pop(dialogContext);

                    Navigator.popUntil(context, (route) => route.isFirst);
                  },
                  child: const Text('Done'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _paymentOption({
    required String title,
    required String subtitle,
    required IconData icon,
  }) {
    final isSelected = selectedMethod == title;

    return InkWell(
      onTap: () {
        setState(() => selectedMethod = title);
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? yellow : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(icon, size: 30, color: secondaryBrown),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: darkBrown,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(fontSize: 12, color: secondaryBrown),
                  ),
                ],
              ),
            ),
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: isSelected ? darkBrown : Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: background,
        elevation: 0,
        foregroundColor: darkBrown,
        title: const Text(
          'Book Now',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Complete Your Booking',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: darkBrown,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Choose your preferred payment method.',
                style: TextStyle(color: secondaryBrown),
              ),
              const SizedBox(height: 24),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Trip Summary',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: darkBrown,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Destination',
                          style: TextStyle(color: secondaryBrown),
                        ),
                        Flexible(
                          child: Text(
                            widget.destination,
                            textAlign: TextAlign.end,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: darkBrown,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Divider(height: 28),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total Amount',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: darkBrown,
                          ),
                        ),
                        Text(
                          '${widget.amount.toStringAsFixed(2)} EGP',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: darkBrown,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              const Text(
                'Payment Method',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: darkBrown,
                ),
              ),
              const SizedBox(height: 14),

              _paymentOption(
                title: 'Visa / Mastercard',
                subtitle: 'Credit or debit card (simulation)',
                icon: Icons.credit_card,
              ),

              _paymentOption(
                title: 'Fawry',
                subtitle: 'Pay through Fawry (simulation)',
                icon: Icons.store,
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: isProcessing ? null : _payNow,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: yellow,
                    foregroundColor: darkBrown,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: isProcessing
                      ? const CircularProgressIndicator(color: darkBrown)
                      : const Text(
                          'Pay Now',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
