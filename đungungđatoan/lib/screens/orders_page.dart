import 'package:flutter/material.dart';
import '../app_state.dart';
import 'checkout_page.dart';
import 'tracking_page.dart';
import '../widgets/circle_icon_button.dart';
import '../widgets/food_emoji_art.dart';
import '../widgets/food_detail_page.dart';
import '../widgets/quantity_button.dart';

class OrdersPage extends StatelessWidget {
  final AppState appState;
  final VoidCallback onStateChanged;

  const OrdersPage({
    super.key,
    required this.appState,
    required this.onStateChanged,
  });

  @override
  Widget build(BuildContext context) {
    final orderedFoods = appState.orderedFoods;

    return Padding(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleIconButton(
                icon: Icons.arrow_back_ios_new,
                onTap: () {},
              ),
              const Spacer(),
              const Text(
                'Orders',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Spacer(),
              CircleIconButton(
                icon: Icons.more_vert,
                onTap: () {},
              ),
            ],
          ),
          const SizedBox(height: 20),
          Expanded(
            child: orderedFoods.isEmpty
                ? const Center(
              child: Text(
                'Chưa có món nào trong giỏ hàng',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            )
                : ListView.separated(
              itemCount: orderedFoods.length,
              separatorBuilder: (_, __) => const SizedBox(height: 14),
              itemBuilder: (_, index) {
                final food = orderedFoods[index];
                final qty = appState.getFoodQuantity(food.id);

                return GestureDetector(
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => FoodDetailPage(
                          food: food,
                          onAddToCart: (quantity) {
                            appState.addToCart(food, quantity: quantity);
                            onStateChanged();
                          },
                        ),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: food.color,
                      borderRadius: BorderRadius.circular(26),
                    ),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        food.emoji,
                                        style: const TextStyle(
                                          fontSize: 28,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          food.name,
                                          style: const TextStyle(
                                            fontSize: 26,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 8,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.75),
                                      borderRadius:
                                      BorderRadius.circular(18),
                                    ),
                                    child: Text(
                                      '\$${food.price.toStringAsFixed(2)}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                const SizedBox(height: 12),
                                FoodEmojiArt(
                                  emoji: food.emoji,
                                  size: 88,
                                ),
                                const SizedBox(height: 8),
                                Text('-${food.discount}%'),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.85),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              const CircleAvatar(
                                backgroundColor: Colors.black12,
                                child: Icon(
                                  Icons.person,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      food.deliveryMan,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    const Text(
                                      'Delivery Man',
                                      style: TextStyle(
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              QuantityButton(
                                icon: Icons.remove,
                                onTap: () {
                                  appState.decreaseQuantity(food.id);
                                  onStateChanged();
                                },
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                ),
                                child: Text(
                                  '$qty',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              QuantityButton(
                                icon: Icons.add,
                                onTap: () {
                                  appState.increaseQuantity(food.id);
                                  onStateChanged();
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          if (orderedFoods.isNotEmpty) ...[
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
              ),
              child: Column(
                children: [
                  _priceRow('Subtotal', appState.cartTotal),
                  const SizedBox(height: 8),
                  _priceRow('Delivery Fee', appState.deliveryFee),
                  const SizedBox(height: 8),
                  _priceRow('Tax', appState.taxFee),
                  const Divider(height: 24),
                  _priceRow('Grand Total', appState.grandTotal, isBold: true),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                if (appState.currentOrder != null)
                  Expanded(
                    child: SizedBox(
                      height: 54,
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => TrackingPage(
                                appState: appState,
                                onStateChanged: onStateChanged,
                              ),
                            ),
                          );
                        },
                        child: const Text('Track Order'),
                      ),
                    ),
                  ),
                if (appState.currentOrder != null) const SizedBox(width: 12),
                Expanded(
                  child: SizedBox(
                    height: 54,
                    child: FilledButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => CheckoutPage(
                              appState: appState,
                              onStateChanged: onStateChanged,
                            ),
                          ),
                        );
                      },
                      style: FilledButton.styleFrom(
                        backgroundColor: Colors.black,
                      ),
                      child: const Text('Checkout'),
                    ),
                  ),
                ),
              ],
            ),
          ] else if (appState.currentOrder != null) ...[
            SizedBox(
              width: double.infinity,
              height: 54,
              child: FilledButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => TrackingPage(
                        appState: appState,
                        onStateChanged: onStateChanged,
                      ),
                    ),
                  );
                },
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.black,
                ),
                child: const Text('Track Current Order'),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _priceRow(String label, double value, {bool isBold = false}) {
    return Row(
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
          '\$${value.toStringAsFixed(2)}',
          style: TextStyle(
            fontSize: 16,
            fontWeight: isBold ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
      ],
    );
  }
}