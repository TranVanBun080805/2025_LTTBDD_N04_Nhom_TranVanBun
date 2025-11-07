import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../controllers/dashBoardController.dart';
import '../../controllers/incomeProvider.dart';
import '../../controllers/categoryProvider.dart';
import '../../widgets/addExpenseScreen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat(
      "#,##0",
      "vi_VN",
    );
    final dashboardController =
        DashboardController();
    final incomeProvider = context
        .watch<Incomeprovider>();
    final categoryProvider = context
        .watch<CategoryProvider>();

    WidgetsBinding.instance.addPostFrameCallback((
      _,
    ) {
      categoryProvider.checkAndResetIfNewMonth();
    });

    final totalIncome =
        incomeProvider.totalIncome;
    final totalExpense =
        categoryProvider.totalSpent;
    final spendingLimit =
        categoryProvider.totalBudget;
    final balance = dashboardController
        .getBalance(context, totalExpense);

    double progress =
        totalExpense /
        (spendingLimit == 0 ? 1 : spendingLimit);
    progress = progress > 1 ? 1 : progress;

    final categories =
        categoryProvider.categories;

    return Scaffold(
      backgroundColor: const Color(0xFFF3F6FB),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 22,
        ),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Text(
              "financial_overview".tr(),
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w800,
                color: Color(0xFF1E355B),
              ),
            ),
            const SizedBox(height: 18),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF3A7BD5),
                    Color(0xFF00D2FF),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius:
                    BorderRadius.circular(26),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blueAccent
                        .withOpacity(0.25),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    "current_balance".tr(),
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "${formatter.format(balance)} đ",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: _miniStatBox(
                          context: context,
                          icon: Icons
                              .arrow_downward_rounded,
                          label: "income".tr(),
                          value: formatter.format(
                            totalIncome,
                          ),
                          color:
                              Colors.greenAccent,
                          onEditPressed: () =>
                              dashboardController
                                  .showUpdateIncomeDialog(
                                    context,
                                  ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _miniStatBox(
                          context: context,
                          icon: Icons
                              .arrow_upward_rounded,
                          label: "expense".tr(),
                          value: formatter.format(
                            totalExpense,
                          ),
                          color: Colors.redAccent,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            _totalLimitBox(
              formatter,
              totalExpense,
              spendingLimit,
              progress,
            ),
            const SizedBox(height: 30),
            Text(
              "categories".tr(),
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1E355B),
              ),
            ),
            const SizedBox(height: 14),
            GridView.builder(
              itemCount: categories.length,
              shrinkWrap: true,
              physics:
                  const NeverScrollableScrollPhysics(),
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 14,
                    mainAxisSpacing: 14,
                    childAspectRatio: 0.95,
                  ),
              itemBuilder: (context, index) {
                final cat = categories[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            AddExpenseScreen(
                              categoryId: cat.id,
                            ),
                      ),
                    );
                  },
                  child: _categoryCard(
                    formatter,
                    cat,
                    context,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _miniStatBox({
    required BuildContext context,
    required IconData icon,
    required String label,
    required String value,
    required Color color,
    VoidCallback? onEditPressed,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 14,
        horizontal: 12,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Colors.white.withOpacity(0.2),
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: color.withOpacity(
              0.25,
            ),
            radius: 16,
            child: Icon(
              icon,
              color: color,
              size: 20,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        label,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 13,
                        ),
                        overflow:
                            TextOverflow.ellipsis,
                      ),
                    ),
                    if (onEditPressed != null)
                      GestureDetector(
                        onTap: onEditPressed,
                        child: const Icon(
                          Icons.edit,
                          size: 14,
                          color: Colors.white70,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  "$value đ",
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _totalLimitBox(
    NumberFormat formatter,
    double totalExpense,
    double spendingLimit,
    double progress,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        vertical: 18,
        horizontal: 20,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Text(
            "monthly_spending_limit".tr(),
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1E355B),
            ),
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(
              10,
            ),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 12,
              backgroundColor:
                  Colors.grey.shade200,
              valueColor:
                  AlwaysStoppedAnimation<Color>(
                    progress < 0.6
                        ? Colors.greenAccent
                        : progress < 0.9
                        ? Colors.orangeAccent
                        : Colors.redAccent,
                  ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${(progress * 100).toStringAsFixed(0)}% ${"used".tr()}",
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                "${formatter.format(totalExpense)} / ${formatter.format(spendingLimit)} ₫",
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1E355B),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _categoryCard(
    NumberFormat formatter,
    CategoryItem cat,
    BuildContext context,
  ) {
    double amount = cat.totalAmount;
    double limit = cat.budgetAmount > 0
        ? cat.budgetAmount
        : 1;
    double ratio = (amount / limit).clamp(
      0.0,
      1.0,
    );

    return Consumer<CategoryProvider>(
      builder: (context, provider, _) {
        return Stack(
          children: [
            AnimatedContainer(
              duration: const Duration(
                milliseconds: 200,
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
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: cat.color
                        .withOpacity(0.15),
                    radius: 26,
                    child: Icon(
                      cat.icon,
                      color: cat.color,
                      size: 28,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    cat.label,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      color: Color(0xFF1E355B),
                    ),
                    overflow:
                        TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "${formatter.format(amount)} đ",
                    style: const TextStyle(
                      color: Colors.redAccent,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ClipRRect(
                    borderRadius:
                        BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: ratio,
                      minHeight: 8,
                      backgroundColor:
                          Colors.grey.shade200,
                      valueColor:
                          AlwaysStoppedAnimation<
                            Color
                          >(
                            ratio < 0.6
                                ? Colors
                                      .greenAccent
                                : ratio < 0.9
                                ? Colors
                                      .orangeAccent
                                : Colors
                                      .redAccent,
                          ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "${formatter.format(amount)} / ${formatter.format(limit)} ₫",
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xFF1E355B),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 4,
              right: 6,
              child: GestureDetector(
                onTap: () => _confirmDelete(
                  context,
                  provider,
                  cat,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.redAccent
                        .withOpacity(0.15),
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(
                    6,
                  ),
                  child: const Icon(
                    Icons.delete_outline,
                    size: 18,
                    color: Colors.redAccent,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _confirmDelete(
    BuildContext context,
    CategoryProvider provider,
    CategoryItem cat,
  ) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          "delete_category".tr(),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          "delete_category_confirm".tr(
            args: [cat.label],
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text("cancel".tr()),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(10),
              ),
            ),
            onPressed: () {
              provider.deleteCategory(cat.id);
              Navigator.pop(ctx);
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(
                SnackBar(
                  content: Text(
                    "deleted_category_message".tr(
                      args: [cat.label],
                    ),
                  ),
                  backgroundColor:
                      Colors.redAccent,
                  behavior:
                      SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(10),
                  ),
                  margin: const EdgeInsets.only(
                    bottom: 20,
                    left: 16,
                    right: 16,
                  ),
                ),
              );
            },
            child: Text("delete".tr()),
          ),
        ],
      ),
    );
  }
}
