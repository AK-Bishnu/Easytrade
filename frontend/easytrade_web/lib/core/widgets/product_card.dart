import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/favourites/favourite_provider.dart';
import '../../features/home/products/data/product_model.dart';
import '../constants/api_constants.dart';

class ProductCard extends ConsumerStatefulWidget {
  final Product product;
  final VoidCallback onTap;
  final bool isMyProduct;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const ProductCard({
    super.key,
    required this.product,
    required this.onTap,
    required this.isMyProduct,
    this.onEdit,
    this.onDelete,
  });

  @override
  ConsumerState<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends ConsumerState<ProductCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final favSet = ref.watch(favouriteProvider);
    final isFav = favSet.contains(widget.product.id);
    final favNotifier = ref.read(favouriteProvider.notifier);

    final thumbnailUrl = widget.product.images.isNotEmpty
        ? ApiConstants.imageBaseUrl + widget.product.images.first.image
        : null;

    return InkWell(
      onTap: widget.onTap,
      borderRadius: BorderRadius.circular(10),
      onHover: (value) {
        if (mounted) {
          setState(() => isHovered = value);
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isHovered ? Colors.black54 : Colors.grey,
          ),
          boxShadow: [
            BoxShadow(
              color: isHovered? Colors.black54 : Colors.white,
              blurRadius: 12,
              offset: Offset(0,6),
            )
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// IMAGE
              Stack(
                children: [
                  AspectRatio(
                    aspectRatio: 1.15,
                    child: thumbnailUrl != null
                        ? Image.network(
                      thumbnailUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => _buildNoImage(),
                    )
                        : _buildNoImage(),
                  ),

                  /// ACTION BUTTON
                  Positioned(
                    top: 6,
                    right: 6,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.9),
                        shape: BoxShape.circle,
                      ),
                      child: widget.isMyProduct
                          ? PopupMenuButton(
                        icon: const Icon(Icons.more_vert, size: 18),
                        itemBuilder: (context) => [
                          const PopupMenuItem(
                            value: 'edit',
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Edit'),
                                Icon(Icons.edit)
                              ],
                            ),
                          ),
                          const PopupMenuItem(
                            value: 'delete',
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Delete'),
                                Icon(Icons.delete,color: Colors.red,)
                              ],
                            ),
                          ),
                        ],
                        onSelected: (value) {
                          if (value == 'edit') widget.onEdit?.call();
                          if (value == 'delete') widget.onDelete?.call();
                        },
                      )
                          : IconButton(
                        icon: Icon(
                          isFav
                              ? Icons.favorite
                              : Icons.favorite_border,
                          size: 18,
                          color:
                          isFav ? Colors.red : Colors.grey.shade600,
                        ),
                        onPressed: () {
                          favNotifier.toggleFavourite(
                              widget.product.id);
                        },
                      ),
                    ),
                  ),
                ],
              ),

              /// DETAILS
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    /// TITLE
                    Text(
                      widget.product.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        height: 1.3,
                      ),
                    ),

                    const SizedBox(height: 6),

                    /// PRICE
                    Text(
                      "৳ ${widget.product.price.toStringAsFixed(0)}",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade800,
                      ),
                    ),

                    const SizedBox(height: 4),

                    /// LOCATION
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          size: 12,
                          color: Colors.grey.shade500,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            widget.product.location,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 2),

                    /// TIME
                    Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          size: 12,
                          color: Colors.grey.shade400,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          _formatDate(widget.product.createdAt),
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNoImage() {
    return Center(
      child: Icon(
        Icons.image_not_supported_outlined,
        size: 28,
        color: Colors.grey.shade300,
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);

    if (diff.inDays == 0) return "Today";
    if (diff.inDays == 1) return "Yesterday";
    if (diff.inDays < 7) return "${diff.inDays} days ago";
    return "${date.day}/${date.month}/${date.year}";
  }
}