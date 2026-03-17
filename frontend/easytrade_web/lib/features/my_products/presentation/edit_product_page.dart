import 'package:easytrade_web/features/home/products/data/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'myproduct_provider.dart';

class EditProductPage extends ConsumerStatefulWidget {
  final Product product;

  const EditProductPage({super.key, required this.product});

  @override
  ConsumerState<EditProductPage> createState() => _EditProductPageState();
}

class _EditProductPageState extends ConsumerState<EditProductPage> {
  final titleController = TextEditingController();
  final priceController = TextEditingController();
  final descController = TextEditingController();
  final locationController = TextEditingController();

  bool loading = false;

  final FocusNode _titleFocus = FocusNode();
  final FocusNode _priceFocus = FocusNode();
  final FocusNode _descFocus = FocusNode();
  final FocusNode _locationFocus = FocusNode();

  @override
  void initState() {
    super.initState();

    titleController.text = widget.product.title;
    priceController.text = widget.product.price.toString();
    descController.text = widget.product.description;
    locationController.text = widget.product.location;
  }

  @override
  void dispose() {
    titleController.dispose();
    priceController.dispose();
    descController.dispose();
    locationController.dispose();

    _titleFocus.dispose();
    _priceFocus.dispose();
    _descFocus.dispose();
    _locationFocus.dispose();

    super.dispose();
  }

  Future<void> updateProduct() async {
    if (titleController.text.isEmpty) {
      _showMsg("Please enter a title", isError: true);
      return;
    }

    if (priceController.text.isEmpty) {
      _showMsg("Please enter a price", isError: true);
      return;
    }

    if (descController.text.isEmpty) {
      _showMsg("Please enter a description", isError: true);
      return;
    }

    if (locationController.text.isEmpty) {
      _showMsg("Please enter location", isError: true);
      return;
    }

    setState(() => loading = true);

    try {
      await ref.read(myProductsProvider.notifier).updateProduct(
        widget.product.id,
        {
          "title": titleController.text.trim(),
          "price": priceController.text.trim(),
          "description": descController.text.trim(),
          "location": locationController.text.trim(),
          "category": widget.product.category, // keep previous category
        },
      );

      if (!mounted) return;

      Navigator.pop(context);

      _showMsg("Product updated successfully", isError: false);
    } catch (e) {
      if (!mounted) return;

      _showMsg("Update failed: ${e.toString()}", isError: true);
    } finally {
      if (mounted) {
        setState(() => loading = false);
      }
    }
  }

  void _showMsg(String msg, {required bool isError}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: isError ? Colors.red.shade700 : Colors.green.shade700,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  Widget buildField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    int maxLines = 1,
    TextInputType? type,
    FocusNode? focusNode,
    String? hint,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        keyboardType: type,
        focusNode: focusNode,
        style: const TextStyle(fontSize: 15),
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          prefixIcon: Icon(icon, size: 20),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.blue.shade700, width: 2),
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isTablet = size.width > 700;

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text(
          "Edit Product",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.blue.shade700,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            color: Colors.grey.shade200,
            height: 1,
          ),
        ),
      ),
      body: Center(
        child: Container(
          width: isTablet ? 600 : double.infinity,
          margin: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withValues(alpha: 0.1),
                blurRadius: 20,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ListView(
            padding: const EdgeInsets.all(24),
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.edit_note_outlined,
                      color: Colors.blue.shade700,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Edit Product",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          "ID: #${widget.product.id}",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              buildField(
                label: "Product Title",
                controller: titleController,
                icon: Icons.title_outlined,
                focusNode: _titleFocus,
                hint: "Enter product title",
              ),

              buildField(
                label: "Price (৳)",
                controller: priceController,
                icon: Icons.attach_money_outlined,
                type: TextInputType.number,
                focusNode: _priceFocus,
                hint: "Enter price",
              ),

              buildField(
                label: "Location",
                controller: locationController,
                icon: Icons.location_on_outlined,
                focusNode: _locationFocus,
                hint: "Enter product location",
              ),

              buildField(
                label: "Description",
                controller: descController,
                icon: Icons.description_outlined,
                maxLines: 4,
                focusNode: _descFocus,
                hint: "Enter product description",
              ),

              const SizedBox(height: 24),

              SizedBox(
                height: 56,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: loading ? null : updateProduct,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade700,
                    foregroundColor: Colors.white,
                    elevation: loading ? 0 : 4,
                    shadowColor: Colors.blue.withValues(alpha: 0.3),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: loading
                      ? const SizedBox(
                    height: 24,
                    width: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor:
                      AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                      : const Text(
                    "Update Product",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              Center(
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.grey.shade600,
                  ),
                  child: const Text("Cancel"),
                ),
              ),

              const SizedBox(height: 8),

              Center(
                child: Text(
                  "Listed on ${_formatDate(widget.product.createdAt)}",
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey.shade400,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}