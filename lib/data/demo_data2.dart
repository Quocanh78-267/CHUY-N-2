import 'package:flutter/material.dart';
import '../models/food_item.dart';

const List<FoodItem> demoFoods = [
  FoodItem(
    id: '1',
    name: 'Burger Bang',
    category: 'Burger',
    price: 8.20,
    rating: 4.6,
    kcal: 110,
    discount: 40,
    minutes: 20,
    color: Color(0xFFCDEAAF),
    emoji: '🍔',
    description:
    'Burger Bang delivers mouthwatering, freshly grilled burgers packed with flavor. Enjoy juicy patties, fresh toppings, and signature sauces, all made to satisfy your cravings and bring you the ultimate burger experience.',
    deliveryMan: 'Alice Johnson',
  ),
  FoodItem(
    id: '2',
    name: 'Pizza Margarita',
    category: 'Pizza',
    price: 8.10,
    rating: 4.5,
    kcal: 135,
    discount: 20,
    minutes: 25,
    color: Color(0xFFCFE7FF),
    emoji: '🍕',
    description:
    'Classic pizza with rich tomato sauce, mozzarella cheese, and herbs. Crispy, cheesy, and perfect for any meal.',
    deliveryMan: 'Jack Carter',
  ),
  FoodItem(
    id: '3',
    name: 'Grilled Meat',
    category: 'Meat',
    price: 9.40,
    rating: 4.7,
    kcal: 180,
    discount: 15,
    minutes: 30,
    color: Color(0xFFFFE4C8),
    emoji: '🍖',
    description:
    'Tender grilled meat served hot and juicy with balanced spices. A perfect choice for meat lovers.',
    deliveryMan: 'Robert Stone',
  ),
  FoodItem(
    id: '4',
    name: 'Hot Dog Roll',
    category: 'Hotdog',
    price: 6.50,
    rating: 4.3,
    kcal: 95,
    discount: 10,
    minutes: 18,
    color: Color(0xFFFFF0BE),
    emoji: '🌭',
    description:
    'Soft bun, smoky sausage, crunchy vegetables, and tasty sauce. Simple but extremely satisfying.',
    deliveryMan: 'Emily Smith',
  ),
];