import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import '../controllers/incomeProvider.dart';
import '../controllers/categoryProvider.dart';

class AddExpenseScreen extends StatefulWidget {
  final String categoryId;

  const AddExpenseScreen({
    super.key,
    required this.categoryId,
  });

  @override
  State<AddExpenseScreen> createState() =>
      _AddExpenseScreenState();
}

class _AddExpenseScreenState
    extends State<AddExpenseScreen> {
  final TextEditingController _amountController =
      TextEditingController();
  final TextEditingController
  _descriptionController =
      TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final categoryProvider = context
        .read<CategoryProvider>();
    final category = categoryProvider.findById(
      widget.categoryId,
    );
    final incomeProvider = context
        .read<Incomeprovider>();
    final income = incomeProvider.totalIncome;

    return Scaffold(
      backgroundColor: const Color(0xFFF3F6FB),
      appBar: AppBar(
        title: Text("add_expense".tr()),
        backgroundColor: const Color(0xFF3A7BD5),
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(22),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              // 🔹 Danh mục đang chọn
              Container(
                padding: const EdgeInsets.all(18),
                margin: const EdgeInsets.only(
                  bottom: 24,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey
                          .withOpacity(0.15),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: category
                          .color
                          .withOpacity(0.15),
                      radius: 28,
                      child: Icon(
                        category.icon,
                        color: category.color,
                        size: 30,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment
                                .start,
                        children: [
                          Text(
                            "adding_to_category"
                                .tr(),
                            style:
                                const TextStyle(
                                  fontSize: 14,
                                  color:
                                      Colors.grey,
                                ),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            category.label,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight:
                                  FontWeight.bold,
                              color:
                                  category.color,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              Text(
                "expense_amount".tr(),
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: Color(0xFF1E355B),
                ),
              ),
              const SizedBox(height: 10),

              TextFormField(
                controller: _amountController,
                keyboardType:
                    TextInputType.number,
                decoration: InputDecoration(
                  hintText: "example_amount".tr(),
                  prefixIcon: const Icon(
                    Icons.attach_money_rounded,
                    color: Color(0xFF3A7BD5),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                ),
                validator: (value) {
                  if (value == null ||
                      value.isEmpty) {
                    return 'enter_amount_error'
                        .tr();
                  }
                  final num? parsed =
                      num.tryParse(
                        value
                            .replaceAll('.', '')
                            .replaceAll(',', ''),
                      );
                  if (parsed == null ||
                      parsed <= 0) {
                    return 'invalid_amount_error'
                        .tr();
                  }
                  return null;
                },
              ),

              const SizedBox(height: 25),

              Text(
                "expense_purpose".tr(),
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: Color(0xFF1E355B),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller:
                    _descriptionController,
                maxLines: 2,
                decoration: InputDecoration(
                  hintText: "example_description"
                      .tr(),
                  prefixIcon: const Icon(
                    Icons.notes_rounded,
                    color: Color(0xFF3A7BD5),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                ),
                validator: (value) {
                  if (value == null ||
                      value.isEmpty) {
                    return 'enter_purpose_error'
                        .tr();
                  }
                  return null;
                },
              ),

              const SizedBox(height: 40),

              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () =>
                          Navigator.pop(context),
                      icon: const Icon(
                        Icons.close_rounded,
                        color: Color(0xFF3A7BD5),
                      ),
                      label: Text(
                        "cancel".tr(),
                        style: const TextStyle(
                          fontSize: 16,
                          color: Color(
                            0xFF3A7BD5,
                          ),
                          fontWeight:
                              FontWeight.w600,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                          color: Color(
                            0xFF3A7BD5,
                          ),
                        ),
                        padding:
                            const EdgeInsets.symmetric(
                              vertical: 14,
                            ),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(
                                16,
                              ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: ElevatedButton.icon(
                      icon: const Icon(
                        Icons
                            .check_circle_outline_rounded,
                        color: Colors.white,
                      ),
                      label: Text(
                        "confirm".tr(),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight:
                              FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color(
                              0xFF3A7BD5,
                            ),
                        padding:
                            const EdgeInsets.symmetric(
                              vertical: 14,
                            ),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(
                                16,
                              ),
                        ),
                        shadowColor: Colors
                            .blueAccent
                            .withOpacity(0.3),
                        elevation: 6,
                      ),
                      onPressed: () {
                        if (_formKey.currentState!
                            .validate()) {
                          final value =
                              double.tryParse(
                                _amountController
                                    .text
                                    .replaceAll(
                                      '.',
                                      '',
                                    )
                                    .replaceAll(
                                      ',',
                                      '',
                                    ),
                              ) ??
                              0;

                          final description =
                              _descriptionController
                                  .text
                                  .trim();

                          categoryProvider
                              .addExpenseToCategory(
                                context,
                                widget.categoryId,
                                value,
                                description,
                                income,
                              );

                          Navigator.pop(context);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
