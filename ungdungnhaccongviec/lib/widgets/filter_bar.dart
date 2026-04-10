import 'package:flutter/material.dart';

class FilterBar extends StatelessWidget {
  final TextEditingController searchController;
  final String selectedStatus;
  final Function(String) onStatusChanged;
  final VoidCallback onSearchChanged;

  const FilterBar({
    super.key,
    required this.searchController,
    required this.selectedStatus,
    required this.onStatusChanged,
    required this.onSearchChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: searchController,
          onChanged: (_) => onSearchChanged(),
          decoration: InputDecoration(
            hintText: 'Tìm theo tên, địa điểm...',
            prefixIcon: const Icon(Icons.search),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: DropdownButton<String>(
            value: selectedStatus,
            isExpanded: true,
            underline: const SizedBox(),
            items: const [
              DropdownMenuItem(value: 'Tất cả', child: Text('Tất cả')),
              DropdownMenuItem(value: 'Chưa xong', child: Text('Chưa xong')),
              DropdownMenuItem(
                value: 'Đã hoàn thành',
                child: Text('Đã hoàn thành'),
              ),
            ],
            onChanged: (value) {
              if (value != null) {
                onStatusChanged(value);
              }
            },
          ),
        ),
      ],
    );
  }
}