import 'package:flutter/material.dart';
import '../app_state.dart';
import 'tracking_page.dart';

class CheckoutPage extends StatefulWidget {
  final AppState appState;
  final VoidCallback onStateChanged;

  const CheckoutPage({
    super.key,
    required this.appState,
    required this.onStateChanged,
  });

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  String selectedPayment = 'Cash';

  @override
  Widget build(BuildContext context) {
    final appState = widget.appState;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Payment Method',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 14),
            _paymentTile('Cash', Icons.payments_outlined),
            _paymentTile('Card', Icons.credit_card_outlined),
            _paymentTile('Momo', Icons.account_balance_wallet_outlined),
            const SizedBox(height: 24),
            const Text(
              'Summary',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 14),
            _summaryRow('Subtotal', appState.cartTotal),
            _summaryRow('Delivery Fee', appState.deliveryFee),
            _summaryRow('Tax', appState.taxFee),
            const Divider(height: 28),
            _summaryRow('Grand Total', appState.grandTotal, isBold: true),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: FilledButton(
                onPressed: () {
                  appState.checkout(selectedPayment);
                  widget.onStateChanged();

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => TrackingPage(
                        appState: appState,
                        onStateChanged: widget.onStateChanged,
                      ),
                    ),
                  );
                },
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text('Place Order'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _paymentTile(String title, IconData icon) {
    final selected = selectedPayment == title;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () {
          setState(() {
            selectedPayment = title;
          });
        },
        borderRadius: BorderRadius.circular(18),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: selected ? const Color(0xFFCDEAAF) : Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: Colors.black12),
          ),
          child: Row(
            children: [
              Icon(icon),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Icon(
                selected
                    ? Icons.radio_button_checked
                    : Icons.radio_button_off,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _summaryRow(String label, double amount, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: isBold ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ),
          Text(
            '\$${amount.toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: 16,
              fontWeight: isBold ? FontWeight.w700 : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}