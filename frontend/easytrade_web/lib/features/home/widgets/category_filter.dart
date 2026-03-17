import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../categories/presentation/category_provider.dart';

class CategoryFilter extends ConsumerWidget {
  const CategoryFilter({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(categoriesProvider);
    final selected = ref.watch(selectedCategoryProvider);

    return categories.when(
      data: (data) {
        return Container(
          height: 56,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.grey.shade200,
                width: 1,
              ),
            ),
          ),
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: data.length + 1, // +1 for "All"
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              if (index == 0) {
                // "All" button
                return _categoryButton(
                  label: "All",
                  icon: Icons.apps_outlined,
                  isSelected: selected == null,
                  onTap: () => ref.read(selectedCategoryProvider.notifier).state = null,
                );
              }

              final category = data[index - 1];
              return _categoryButton(
                label: category.name,
                icon: _getCategoryIcon(category.name),
                isSelected: selected == category.id,
                onTap: () => ref.read(selectedCategoryProvider.notifier).state = category.id,
              );
            },
          ),
        );
      },
      loading: () => const SizedBox(
        height: 56,
        child: Center(child: CircularProgressIndicator()),
      ),
      error: (e, _) => Container(
        height: 56,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            Icon(Icons.error_outline, color: Colors.red.shade400, size: 20),
            const SizedBox(width: 8),
            Text(
              "Failed to load categories",
              style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  Widget _categoryButton({
    required String label,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Center(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(28),
            splashColor: Colors.blue.withValues(alpha: 0.1),
            highlightColor: Colors.transparent,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                gradient: isSelected
                    ? LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.blue.shade600,
                    Colors.blue.shade700,
                  ],
                )
                    : null,
                color: isSelected ? null : Colors.grey.shade100,
                borderRadius: BorderRadius.circular(28),
                border: isSelected
                    ? null
                    : Border.all(
                  color: Colors.grey.shade300,
                  width: 1,
                ),
                boxShadow: isSelected
                    ? [
                  BoxShadow(
                    color: Colors.blue.withValues(alpha: 0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
                    : null,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    icon,
                    size: 16,
                    color: isSelected ? Colors.white : Colors.grey.shade700,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    label,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.grey.shade800,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  IconData _getCategoryIcon(String categoryName) {
    switch (categoryName.toLowerCase()) {

      case 'food':
        return Icons.fastfood;

      case 'clothing':
        return Icons.checkroom_outlined;

      case 'furniture':
        return Icons.chair_outlined;

      case 'vehicle':
        return Icons.directions_car_outlined;

      case 'electronics':
        return Icons.electrical_services_outlined;

      case 'device':
        return Icons.devices_outlined;

      case 'stationery':
        return Icons.edit_outlined;

      case 'lab equipment':
        return Icons.science_outlined;

      case 'books & notes':
        return Icons.menu_book_outlined;

      case 'sports':
        return Icons.sports_soccer_outlined;

      case 'others':
        return Icons.category_outlined;

      default:
        return Icons.category_outlined;
    }
  }
}