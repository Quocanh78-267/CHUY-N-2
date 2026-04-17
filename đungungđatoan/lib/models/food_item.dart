import 'package:flutter/material.dart';

class FoodItem {
  final String id;
  final String name;
  final String category;
  final double price;
  final double rating;
  final int kcal;
  final int discount;
  final int minutes;
  final Color color;
  final String emoji;
  final String description;
  final String deliveryMan;

  const FoodItem({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.rating,
    required this.kcal,
    required this.discount,
    required this.minutes,
    required this.color,
    required this.emoji,
    required this.description,
    required this.deliveryMan,
  });
}