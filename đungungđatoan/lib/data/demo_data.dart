import 'package:flutter/material.dart';
import '../models/food_item.dart';

const List<FoodItem> demoFoods = [
  FoodItem(
    id: '1',
    name: 'Burger Bò Phô Mai',
    category: 'Burger',
    price: 8.20,
    rating: 4.6,
    kcal: 110,
    discount: 40,
    minutes: 20,
    color: Color(0xFFCDEAAF),
    emoji: '🍔',
    description:
    'Burger bò phô mai thơm ngon với thịt nướng mềm, rau tươi và nước sốt đậm vị, mang đến trải nghiệm hấp dẫn cho người dùng.',
    deliveryMan: 'Nguyễn Văn An',
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
    'Pizza truyền thống với sốt cà chua, phô mai mozzarella và hương vị thơm ngon dễ ăn.',
    deliveryMan: 'Trần Minh Khoa',
  ),
  FoodItem(
    id: '3',
    name: 'Thịt Nướng',
    category: 'Thịt',
    price: 9.40,
    rating: 4.7,
    kcal: 180,
    discount: 15,
    minutes: 30,
    color: Color(0xFFFFE4C8),
    emoji: '🍖',
    description:
    'Món thịt nướng thơm mềm, đậm đà gia vị, phù hợp cho người thích món ăn nhiều năng lượng.',
    deliveryMan: 'Lê Quốc Bảo',
  ),
  FoodItem(
    id: '4',
    name: 'Bánh Mì Xúc Xích',
    category: 'Hotdog',
    price: 6.50,
    rating: 4.3,
    kcal: 95,
    discount: 10,
    minutes: 18,
    color: Color(0xFFFFF0BE),
    emoji: '🌭',
    description:
    'Bánh mì xúc xích với rau và sốt ngon miệng, là lựa chọn nhanh gọn và tiện lợi.',
    deliveryMan: 'Phạm Anh Tú',
  ),
];