import 'package:flutter/material.dart';
import '../app_state.dart';

class TrackingPage extends StatelessWidget {
  final AppState appState;
  final VoidCallback onStateChanged;

  const TrackingPage({
    super.key,
    required this.appState,
    required this.onStateChanged,
  });

  @override
  Widget build(BuildContext context) {
    final order = appState.currentOrder;

    if (order == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Tracking')),
        body: const Center(
          child: Text(
            'Chưa có đơn hàng nào để theo dõi',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ),
      );
    }

    final steps = [
      'Preparing',
      'Picked Up',
      'On The Way',
      'Delivered',
    ];

    final currentIndex = steps.indexOf(order.status);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Track Order'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: const Color(0xFFCDEAAF),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Order Code: ${order.orderCode}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text('Payment: ${order.paymentMethod}'),
                  const SizedBox(height: 6),
                  Text('Total: \$${order.totalAmount.toStringAsFixed(2)}'),
                  const SizedBox(height: 6),
                  Text('Status: ${order.status}'),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Order Progress',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: steps.length,
                itemBuilder: (_, index) {
                  final done = index <= currentIndex;
                  final isCurrent = index == currentIndex;

                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              color: done ? Colors.green : Colors.grey.shade300,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              done ? Icons.check : Icons.circle,
                              size: 14,
                              color: Colors.white,
                            ),
                          ),
                          if (index != steps.length - 1)
                            Container(
                              width: 3,
                              height: 60,
                              color: done ? Colors.green : Colors.grey.shade300,
                            ),
                        ],
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                steps[index],
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: isCurrent
                                      ? FontWeight.w700
                                      : FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                done
                                    ? 'Đã hoàn thành bước này'
                                    : 'Đang chờ xử lý',
                                style: const TextStyle(color: Colors.black54),
                              ),
                              const SizedBox(height: 24),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: FilledButton(
                onPressed: () {
                  appState.advanceOrderStatus();
                  onStateChanged();
                  (context as Element).markNeedsBuild();
                },
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(
                  order.status == 'Delivered'
                      ? 'Order Delivered'
                      : 'Next Status',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}