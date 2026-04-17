import 'package:flutter/material.dart';
import '../app_state.dart';
import '../models/food_item.dart';
import '../widgets/food_card.dart';
import '../widgets/food_detail_page.dart';
import '../widgets/food_emoji_art.dart';
import '../widgets/section_header.dart';

class HomePage extends StatelessWidget {
  final AppState appState;
  final VoidCallback onGoOrders;
  final VoidCallback onStateChanged;

  const HomePage({
    super.key,
    required this.appState,
    required this.onGoOrders,
    required this.onStateChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 22,
                backgroundColor: Color(0xFFEDEDED),
                child: Icon(Icons.person, color: Colors.black),
              ),
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.location_on_outlined, size: 18),
                    SizedBox(width: 6),
                    Text('Hà Nội'),
                    SizedBox(width: 4),
                    Icon(Icons.keyboard_arrow_down, size: 18),
                  ],
                ),
              ),
              const Spacer(),
              Stack(
                children: [
                  InkWell(
                    onTap: onGoOrders,
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Icon(Icons.shopping_cart_outlined),
                    ),
                  ),
                  if (appState.cartCount > 0)
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          '${appState.cartCount}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Text(
            'Ăn gì có đấy',
            style: TextStyle(
              fontSize: 34,
              fontWeight: FontWeight.w700,
              height: 1.1,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: TextField(
                  onChanged: (value) {
                    appState.searchText = value;
                    onStateChanged();
                  },
                  decoration: InputDecoration(
                    hintText: 'Search',
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(vertical: 0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(22),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: const Icon(Icons.tune),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            constraints: const BoxConstraints(minHeight: 130),
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFBFE59B), Color(0xFFF1E67A)],
              ),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Order a set With\n40% discount',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        height: 42,
                        child: FilledButton(
                          onPressed: onGoOrders,
                          style: FilledButton.styleFrom(
                            backgroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(22),
                            ),
                          ),
                          child: const Text('Order Now'),
                        ),
                      ),
                    ],
                  ),
                ),
                const FoodEmojiArt(emoji: '🍔', size: 86),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const SectionHeader(title: 'Category', actionLabel: 'See All'),
          const SizedBox(height: 10),
          SizedBox(
            height: 56,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: appState.categories.length,
              separatorBuilder: (_, __) => const SizedBox(width: 10),
              itemBuilder: (_, index) {
                final category = appState.categories[index];
                final selected = appState.selectedCategory == category;

                return GestureDetector(
                  onTap: () {
                    appState.selectedCategory = category;
                    onStateChanged();
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: selected
                          ? const Color(0xFFCDEAAF)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: Colors.black12),
                    ),
                    child: Row(
                      children: [
                        Text(
                          _categoryEmoji(category),
                          style: const TextStyle(fontSize: 22),
                        ),
                        const SizedBox(width: 8),
                        Text(category),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          const SectionHeader(title: 'Popular Food', actionLabel: 'See All'),
          const SizedBox(height: 10),
          GridView.builder(
            itemCount: appState.filteredFoods.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 14,
              crossAxisSpacing: 14,
              childAspectRatio: 0.82,
            ),
            itemBuilder: (_, index) {
              final food = appState.filteredFoods[index];
              return FoodCard(
                food: food,
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
                onAdd: () {
                  appState.addToCart(food);
                  onStateChanged();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${food.name} đã được thêm vào giỏ hàng'),
                      behavior: SnackBarBehavior.floating,
                      duration: const Duration(seconds: 1),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

String _categoryEmoji(String category) {
  switch (category) {
    case 'Burger':
      return '🍔';
    case 'Pizza':
      return '🍕';
    case 'Meat':
      return '🍖';
    case 'Hotdog':
      return '🌭';
    default:
      return '🍽️';
  }
}