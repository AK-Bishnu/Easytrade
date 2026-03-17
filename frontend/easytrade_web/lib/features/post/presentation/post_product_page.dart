import 'package:easytrade_web/features/home/products/presentation/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:file_selector/file_selector.dart';
import '../../categories/data/category_model.dart';
import '../../categories/presentation/category_provider.dart';
import 'package:easytrade_web/core/layout/app_layout.dart';
import '../../my_products/presentation/myproduct_provider.dart';

class PostProductPage extends ConsumerStatefulWidget {
  const PostProductPage({super.key});

  @override
  ConsumerState<PostProductPage> createState() => _PostProductPageState();
}

class _PostProductPageState extends ConsumerState<PostProductPage> {
  final titleController = TextEditingController();
  final descController = TextEditingController();
  final priceController = TextEditingController();
  final locationController = TextEditingController();

  Category? selectedCategory;
  List<XFile> selectedImages = [];

  bool isLoading = false;

  final FocusNode _titleFocus = FocusNode();
  final FocusNode _descFocus = FocusNode();
  final FocusNode _priceFocus = FocusNode();
  final FocusNode _locationFocus = FocusNode();

  @override
  void dispose() {
    titleController.dispose();
    descController.dispose();
    priceController.dispose();
    locationController.dispose();
    _titleFocus.dispose();
    _descFocus.dispose();
    _priceFocus.dispose();
    _locationFocus.dispose();
    super.dispose();
  }

  Future<void> pickImages() async {
    try {
      final typeGroup = XTypeGroup(
        label: 'images',
        extensions: ['jpg', 'png', 'jpeg', 'webp'],
      );

      final files = await openFiles(
        acceptedTypeGroups: [typeGroup],
      );

      if (files.isNotEmpty) {
        setState(() {
          selectedImages = files;
        });

        _showMsg('${files.length} image(s) selected', isError: false);
      }
    } catch (e) {
      _showMsg('Error picking files: $e', isError: true);
    }
  }

  void _removeImage(int index) {
    setState(() {
      selectedImages.removeAt(index);
    });
  }

  Future<void> _submit() async {
    // Validation
    if (titleController.text.isEmpty) {
      _showMsg("Please enter a title", isError: true);
      return;
    }

    if (descController.text.isEmpty) {
      _showMsg("Please enter a description", isError: true);
      return;
    }

    if (priceController.text.isEmpty) {
      _showMsg("Please enter a price", isError: true);
      return;
    }

    if (locationController.text.isEmpty) {
      _showMsg("Please enter a location", isError: true);
      return;
    }

    if (selectedCategory == null) {
      _showMsg("Please select a category", isError: true);
      return;
    }

    if (selectedImages.isEmpty) {
      _showMsg("Please select at least one image", isError: true);
      return;
    }

    setState(() => isLoading = true);

    try {
      final res = await ref.read(myProductsProvider.notifier).createProduct(
        title: titleController.text.trim(),
        description: descController.text.trim(),
        price: priceController.text.trim(),
        location: locationController.text.trim(),
        categoryId: selectedCategory!.id,
        images: selectedImages,
      );

      if (res && mounted) {
        _showMsg("Product posted successfully!", isError: false);
        ref.invalidate(productsProvider);

        // Navigate back to my products
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const AppLayout()),
        );
      } else if (mounted) {
        _showMsg("Failed to post product", isError: true);
      }
    } catch (e) {
      if (mounted) {
        _showMsg("Error: ${e.toString()}", isError: true);
      }
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
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

  Widget buildTextField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    int maxLines = 1,
    TextInputType? keyboardType,
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
        keyboardType: keyboardType,
        focusNode: focusNode,
        style: const TextStyle(fontSize: 15),
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          prefixIcon: Icon(icon, size: 20),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300),
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
    final categoriesAsync = ref.watch(categoriesProvider);
    final size = MediaQuery.of(context).size;
    final isTablet = size.width > 700;

    return Scaffold(
      backgroundColor: Colors.grey.shade50,

      appBar: AppBar(
        title: const Text(
          "Post New Product",
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
              // Header with icon
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.add_business_outlined,
                      color: Colors.blue.shade700,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    "Product Information",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              /// TITLE FIELD
              buildTextField(
                label: "Product Title",
                controller: titleController,
                icon: Icons.title_outlined,
                focusNode: _titleFocus,
                hint: "e.g., iPhone 12, Sony Camera, etc.",
              ),

              /// DESCRIPTION FIELD
              buildTextField(
                label: "Description",
                controller: descController,
                icon: Icons.description_outlined,
                maxLines: 4,
                focusNode: _descFocus,
                hint: "Describe your product in detail...",
              ),

              /// PRICE FIELD
              buildTextField(
                label: "Price (৳)",
                controller: priceController,
                icon: Icons.attach_money_outlined,
                keyboardType: TextInputType.number,
                focusNode: _priceFocus,
                hint: "e.g., 1500",
              ),

              /// LOCATION FIELD
              buildTextField(
                label: "Location",
                controller: locationController,
                icon: Icons.location_on_outlined,
                focusNode: _locationFocus,
                hint: "e.g., Dhaka, Chittagong",
              ),

              const SizedBox(height: 8),

              /// CATEGORY DROPDOWN
              categoriesAsync.when(
                data: (categories) => Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: DropdownButtonFormField<Category>(
                    initialValue: selectedCategory,
                    hint: Row(
                      children: [
                        Icon(Icons.category_outlined, size: 20, color: Colors.grey.shade600),
                        const SizedBox(width: 8),
                        Text(
                          "Select Category",
                          style: TextStyle(color: Colors.grey.shade600),
                        ),
                      ],
                    ),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 16),
                    ),
                    items: categories.map((c) {
                      return DropdownMenuItem(
                        value: c,
                        child: Text(c.name),
                      );
                    }).toList(),
                    onChanged: (val) => setState(() => selectedCategory = val),
                    icon: Icon(Icons.arrow_drop_down, color: Colors.blue.shade700),
                    dropdownColor: Colors.white,
                  ),
                ),
                loading: () => const Center(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: CircularProgressIndicator(),
                  ),
                ),
                error: (e, _) => Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.red.shade50,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.error_outline, color: Colors.red.shade700),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          "Failed to load categories",
                          style: TextStyle(color: Colors.red.shade700),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              /// IMAGE SECTION HEADER
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.image_outlined,
                      color: Colors.green.shade700,
                      size: 18,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    "Product Images",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    "${selectedImages.length}/5",
                    style: TextStyle(
                      color: selectedImages.length >= 5 ? Colors.orange.shade700 : Colors.grey.shade600,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              /// IMAGE PICKER BUTTON
              InkWell(
                onTap: selectedImages.length < 5 ? pickImages : null,
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    color: selectedImages.length < 5 ? Colors.blue.shade50 : Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: selectedImages.length < 5 ? Colors.blue.shade200 : Colors.grey.shade300,
                      width: 2,
                    ),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.add_photo_alternate_outlined,
                        size: 32,
                        color: selectedImages.length < 5 ? Colors.blue.shade700 : Colors.grey.shade500,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        selectedImages.length < 5
                            ? "Tap to select images"
                            : "Maximum 5 images reached",
                        style: TextStyle(
                          color: selectedImages.length < 5 ? Colors.blue.shade700 : Colors.grey.shade600,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "JPG, PNG (max 5)",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              /// IMAGE PREVIEW
              if (selectedImages.isNotEmpty)
                SizedBox(
                  height: 100,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: selectedImages.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.only(right: 12),
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                selectedImages[index].path,
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) => Container(
                                  width: 100,
                                  height: 100,
                                  color: Colors.grey.shade200,
                                  child: Icon(
                                    Icons.broken_image,
                                    color: Colors.grey.shade400,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 4,
                              right: 4,
                              child: GestureDetector(
                                onTap: () => _removeImage(index),
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withValues(alpha: 0.1),
                                        blurRadius: 4,
                                      ),
                                    ],
                                  ),
                                  child: const Icon(
                                    Icons.close,
                                    size: 14,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

              const SizedBox(height: 32),

              /// SUBMIT BUTTON
              SizedBox(
                height: 56,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: isLoading ? null : _submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade700,
                    foregroundColor: Colors.white,
                    elevation: isLoading ? 0 : 4,
                    shadowColor: Colors.blue.withValues(alpha: 0.3),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: isLoading
                      ? const SizedBox(
                    height: 24,
                    width: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                      : const Text(
                    "Post Product",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              /// CANCEL BUTTON
              Center(
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.grey.shade600,
                  ),
                  child: const Text("Cancel"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}