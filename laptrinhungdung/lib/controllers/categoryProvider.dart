import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'incomeProvider.dart';

class CategoryItem {
  final String id;
  final String label;
  final IconData icon;
  final Color color;
  double totalAmount;
  double budgetAmount;

  CategoryItem({
    required this.id,
    required this.label,
    required this.icon,
    required this.color,
    this.totalAmount = 0.0,
    this.budgetAmount = 0.0,
  });
}

class ExpenseHistoryItem {
  final String id;
  final String label;
  final String description;
  final double amount;
  final DateTime date;

  ExpenseHistoryItem({
    required this.id,
    required this.label,
    required this.description,
    required this.amount,
    required this.date,
  });
}

class CategoryProvider with ChangeNotifier {
  final List<CategoryItem> _categories = [
    CategoryItem(
      id: '1',
      label: 'Ăn uống',
      icon: Icons.fastfood,
      color: const Color(0xFFFFA726),
      totalAmount: 1200000,
      budgetAmount: 2000000,
    ),
    CategoryItem(
      id: '2',
      label: 'Mua sắm',
      icon: Icons.shopping_bag,
      color: const Color(0xFFF06292),
      totalAmount: 2200000,
      budgetAmount: 3000000,
    ),
    CategoryItem(
      id: '3',
      label: 'Nhà ở',
      icon: Icons.home,
      color: const Color(0xFF26C6DA),
      totalAmount: 3500000,
      budgetAmount: 4000000,
    ),
    CategoryItem(
      id: '4',
      label: 'Đi lại',
      icon: Icons.directions_car,
      color: const Color(0xFF7E57C2),
      totalAmount: 400000,
      budgetAmount: 1000000,
    ),
  ];

  Incomeprovider incomeProvider =
      Incomeprovider();

  final List<ExpenseHistoryItem> _history = [];
  List<ExpenseHistoryItem> get history =>
      _history;
  List<CategoryItem> get categories =>
      _categories;
  void addCategory(CategoryItem category) {
    _categories.add(category);
    notifyListeners();
  }

  void updateCategory(
    CategoryItem updatedCategory,
  ) {
    final index = _categories.indexWhere(
      (cat) => cat.id == updatedCategory.id,
    );
    if (index != -1) {
      _categories[index] = updatedCategory;
      notifyListeners();
    }
  }

  void deleteCategory(String id) {
    _categories.removeWhere(
      (cat) => cat.id == id,
    );
    notifyListeners();
  }

  double get totalBudget {
    return _categories.fold(
      0.0,
      (sum, cat) => sum + cat.budgetAmount,
    );
  }

  double get totalSpent {
    return _categories.fold(
      0.0,
      (sum, cat) => sum + cat.totalAmount,
    );
  }

  void addExpenseToCategory(
    BuildContext context,
    String id,
    double amount,
    String description,
    double totalIncome, // ✅ truyền vào từ ngoài
  ) {
    final category = _categories.firstWhere(
      (cat) => cat.id == id,
      orElse: () => throw Exception(
        "Không tìm thấy danh mục có id: $id",
      ),
    );

    // ✅ Tính tổng chi tiêu hiện tại (trước khi cộng thêm)
    final totalCurrentExpense = _categories.fold(
      0.0,
      (sum, cat) => sum + cat.totalAmount,
    );

    // ⚠️ Nếu thêm chi tiêu này khiến tổng chi > thu nhập
    if (totalCurrentExpense + amount >
        totalIncome) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            '⚠️ Cảnh báo: Tổng chi tiêu của bạn đã vượt quá tổng thu nhập! Khoản chi này không được thêm.',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
          ),
          backgroundColor: Colors.redAccent,
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 10,
          ),
          duration: Duration(seconds: 4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              10,
            ),
          ),
        ),
      );
      return; // ❌ Dừng tại đây, không thêm chi tiêu
    }

    // ✅ Nếu hợp lệ → cộng chi tiêu
    category.totalAmount += amount;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Đã thêm ${amount.toStringAsFixed(0)} đ cho "$description" trong danh mục "${category.label}"',
        ),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.only(
          bottom: 20,
          left: 16,
          right: 16,
        ),
        backgroundColor: Colors.green,
      ),
    );
    // ✅ Ghi vào lịch sử
    _history.insert(
      0,
      ExpenseHistoryItem(
        id: category.id,
        label: category.label,
        description: description,
        amount: amount,
        date: DateTime.now(),
      ),
    );

    // ⚠️ Kiểm tra vượt ngân sách riêng
    if (category.totalAmount >
            category.budgetAmount &&
        category.budgetAmount > 0) {
      final exceeded =
          category.totalAmount -
          category.budgetAmount;
      final percent =
          (category.totalAmount /
                  category.budgetAmount -
              1) *
          100;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '⚠️ Danh mục "${category.label}" đã vượt ngân sách ${exceeded.toStringAsFixed(0)} đ (${percent.toStringAsFixed(1)}%)',
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
          ),
          backgroundColor: Colors.orangeAccent,
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 10,
          ),
          duration: const Duration(seconds: 4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              10,
            ),
          ),
        ),
      );
    }

    notifyListeners();
  }

  CategoryItem findById(String id) {
    return _categories.firstWhere(
      (cat) => cat.id == id,
    );
  }

  Future<void> _checkAndResetIfNewMonth() async {
    final prefs =
        await SharedPreferences.getInstance();
    final lastResetString =
        prefs.getInt('lastMonth') ?? 11;
    final currentMonth = DateTime.now().month;
    if (lastResetString != currentMonth) {
      for (var category in _categories) {
        category.totalAmount = 0.0;
      }
      prefs.setInt('lastMonth', currentMonth);
      notifyListeners();
    }
  }

  Future<void> checkAndResetIfNewMonth() async {
    await _checkAndResetIfNewMonth();
  }
}
