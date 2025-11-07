import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../controllers/categoryProvider.dart';

class AddCategoryScreen extends StatefulWidget {
  const AddCategoryScreen({super.key});

  @override
  State<AddCategoryScreen> createState() =>
      _AddCategoryScreenState();
}

class _AddCategoryScreenState
    extends State<AddCategoryScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _limitController =
      TextEditingController();

  Color _selectedColor = Colors.blueAccent;
  IconData _selectedIcon = Icons.category;

  // ✅ Không dùng .tr() ở đây, để tránh lỗi Dropdown
  final String _selectedType = "expense";

  final _colorOptions = [
    Colors.blueAccent,
    Colors.orangeAccent,
    Colors.green,
    Colors.purple,
    Colors.redAccent,
    Colors.teal,
    Colors.indigo,
  ];

  final _iconOptions = [
    Icons.fastfood,
    Icons.shopping_bag,
    Icons.directions_car,
    Icons.home,
    Icons.attach_money,
    Icons.favorite,
    Icons.school,
    Icons.flight_takeoff,
  ];

  void _saveCategory() {
    if (_formKey.currentState!.validate()) {
      final limit =
          double.tryParse(
            _limitController.text
                .replaceAll('.', '')
                .replaceAll(',', ''),
          ) ??
          0;

      final newCategory = CategoryItem(
        id: Random().nextInt(999999).toString(),
        label: _nameController.text.trim(),
        color: _selectedColor,
        icon: _selectedIcon,
        budgetAmount: limit,
        totalAmount: 0,
      );

      Provider.of<CategoryProvider>(
        context,
        listen: false,
      ).addCategory(newCategory);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'added_category_message'.tr(
              args: [newCategory.label],
            ),
          ),
          backgroundColor: Colors.green.shade600,
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.only(
            bottom: 20,
            left: 16,
            right: 16,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              10,
            ),
          ),
        ),
      );

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F6FB),
      appBar: AppBar(
        backgroundColor: const Color(0xFF3A7BD5),
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 3,
        title: Text(
          "add_new_category".tr(),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              _buildCardSection(
                title: "category_name".tr(),
                child: _buildTextField(
                  controller: _nameController,
                  hint: "enter_category_name"
                      .tr(),
                  validatorMsg:
                      "enter_category_name_error"
                          .tr(),
                ),
              ),
              _buildCardSection(
                title: "spending_limit".tr(),
                child: _buildTextField(
                  controller: _limitController,
                  hint: "enter_limit_hint".tr(),
                  keyboardType:
                      TextInputType.number,
                  validatorMsg:
                      "enter_valid_amount_error"
                          .tr(),
                ),
              ),
              _buildCardSection(
                title: "choose_color".tr(),
                child: Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: _colorOptions.map((
                    color,
                  ) {
                    final isSelected =
                        _selectedColor == color;
                    return GestureDetector(
                      onTap: () => setState(
                        () => _selectedColor =
                            color,
                      ),
                      child: AnimatedContainer(
                        duration: const Duration(
                          milliseconds: 250,
                        ),
                        padding:
                            const EdgeInsets.all(
                              3,
                            ),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isSelected
                                ? color
                                : Colors
                                      .grey
                                      .shade300,
                            width: isSelected
                                ? 3
                                : 1.5,
                          ),
                        ),
                        child: CircleAvatar(
                          backgroundColor: color,
                          radius: 22,
                          child: isSelected
                              ? const Icon(
                                  Icons.check,
                                  color: Colors
                                      .white,
                                  size: 20,
                                )
                              : null,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              _buildCardSection(
                title: "choose_icon".tr(),
                child: SizedBox(
                  height: 70,
                  child: ListView.separated(
                    scrollDirection:
                        Axis.horizontal,
                    itemCount:
                        _iconOptions.length,
                    separatorBuilder: (_, __) =>
                        const SizedBox(width: 12),
                    itemBuilder: (_, index) {
                      final icon =
                          _iconOptions[index];
                      final isSelected =
                          _selectedIcon == icon;
                      return GestureDetector(
                        onTap: () => setState(
                          () => _selectedIcon =
                              icon,
                        ),
                        child: AnimatedContainer(
                          duration:
                              const Duration(
                                milliseconds: 250,
                              ),
                          padding:
                              const EdgeInsets.all(
                                10,
                              ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? _selectedColor
                                : Colors.white,
                            borderRadius:
                                BorderRadius.circular(
                                  14,
                                ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors
                                    .black
                                    .withOpacity(
                                      0.08,
                                    ),
                                blurRadius: 5,
                                offset:
                                    const Offset(
                                      2,
                                      3,
                                    ),
                              ),
                            ],
                          ),
                          child: Icon(
                            icon,
                            color: isSelected
                                ? Colors.white
                                : Colors
                                      .grey
                                      .shade700,
                            size: 26,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 28),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saveCategory,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(
                      0xFF3A7BD5,
                    ),
                    padding:
                        const EdgeInsets.symmetric(
                          vertical: 16,
                        ),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(
                            14,
                          ),
                    ),
                    elevation: 4,
                  ),
                  child: Text(
                    "save_category".tr(),
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCardSection({
    required String title,
    required Widget child,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Card(
        elevation: 1.5,
        shadowColor: Colors.black12,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        margin: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: Color(0xFF1E355B),
                ),
              ),
              const SizedBox(height: 10),
              child,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    TextInputType keyboardType =
        TextInputType.text,
    required String validatorMsg,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: _inputDecoration(hint: hint),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return validatorMsg;
        }
        if (keyboardType ==
                TextInputType.number &&
            double.tryParse(
                  value
                      .replaceAll('.', '')
                      .replaceAll(',', ''),
                ) ==
                null) {
          return "invalid_amount_error".tr();
        }
        return null;
      },
    );
  }

  InputDecoration _inputDecoration({
    String? hint,
  }) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 14,
      ),
    );
  }
}
