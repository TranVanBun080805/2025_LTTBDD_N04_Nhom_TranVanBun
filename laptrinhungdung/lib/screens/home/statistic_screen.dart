import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../controllers/incomeProvider.dart';
import '../../controllers/categoryProvider.dart';
import 'package:intl/intl.dart';

class StatisticScreen extends StatelessWidget {
  const StatisticScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final incomeProvider = context
        .watch<Incomeprovider>();
    final categoryProvider = context
        .watch<CategoryProvider>();

    final formatter = NumberFormat(
      "#,##0",
      "vi_VN",
    );

    double totalIncome =
        incomeProvider.totalIncome;
    double totalExpense = categoryProvider
        .categories
        .fold(0.0, (s, e) => s + e.totalAmount);
    double balance = totalIncome - totalExpense;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("financial_statistics".tr()),
        centerTitle: true,
        backgroundColor: const Color(0xFF3A7BD5),
        foregroundColor: Colors.white,
      ),
      backgroundColor: const Color(0xFFF5F7FA),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            _buildSummaryCard(
              totalIncome,
              totalExpense,
              balance,
              formatter,
            ),
            const SizedBox(height: 25),
            Text(
              "spending_ratio_by_category".tr(),
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 14),
            _buildPieChart(categoryProvider),
            const SizedBox(height: 30),
            Text(
              "expense_by_category".tr(),
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 14),
            _buildBarChart(
              categoryProvider,
              formatter,
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard(
    double income,
    double expense,
    double balance,
    NumberFormat formatter,
  ) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF3A7BD5),
            Color(0xFF00D2FF),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.blueAccent.withOpacity(
              0.25,
            ),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
            children: [
              _buildSummaryTile(
                Icons.trending_up,
                "income".tr(),
                formatter.format(income),
                Colors.greenAccent,
              ),
              _buildSummaryTile(
                Icons.trending_down,
                "expense".tr(),
                formatter.format(expense),
                Colors.redAccent,
              ),
            ],
          ),
          const SizedBox(height: 14),
          Container(
            height: 1,
            color: Colors.white30,
          ),
          const SizedBox(height: 14),
          _buildSummaryTile(
            Icons.account_balance_wallet,
            "balance".tr(),
            formatter.format(balance),
            Colors.white,
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryTile(
    IconData icon,
    String label,
    String value,
    Color color,
  ) {
    return Column(
      children: [
        Icon(icon, color: color, size: 28),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 15,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          "$value đ",
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ],
    );
  }

  Widget _buildPieChart(
    CategoryProvider provider,
  ) {
    final categories = provider.categories;
    final totalExpense = categories.fold(
      0.0,
      (s, e) => s + e.totalAmount,
    );

    if (totalExpense == 0) {
      return _buildEmptyPlaceholder(
        "no_expense_data".tr(),
      );
    }

    return Column(
      children: [
        SizedBox(
          height: 240,
          child: PieChart(
            PieChartData(
              sectionsSpace: 2,
              centerSpaceRadius: 50,
              sections: categories.map((cat) {
                final percent =
                    (cat.totalAmount /
                        totalExpense) *
                    100;
                return PieChartSectionData(
                  color: cat.color,
                  value: cat.totalAmount,
                  title:
                      "${percent.toStringAsFixed(1)}%",
                  radius: 70,
                  titleStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                );
              }).toList(),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 10,
          runSpacing: 6,
          children: categories.map((cat) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 12,
                  height: 12,
                  color: cat.color,
                ),
                const SizedBox(width: 6),
                Text(
                  cat.label,
                  style: const TextStyle(
                    fontSize: 13,
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildBarChart(
    CategoryProvider provider,
    NumberFormat formatter,
  ) {
    final categories = provider.categories;

    if (categories.isEmpty) {
      return _buildEmptyPlaceholder(
        "no_category_data".tr(),
      );
    }

    return Column(
      children: [
        SizedBox(
          height: 250,
          child: BarChart(
            BarChartData(
              borderData: FlBorderData(
                show: false,
              ),
              gridData: const FlGridData(
                show: false,
              ),
              titlesData: FlTitlesData(
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      final index = value.toInt();
                      if (index <
                          categories.length) {
                        return Padding(
                          padding:
                              const EdgeInsets.only(
                                top: 6,
                              ),
                          child: Text(
                            categories[index]
                                .label,
                            style:
                                const TextStyle(
                                  fontSize: 10,
                                ),
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ),
              ),
              barGroups: categories
                  .asMap()
                  .entries
                  .map((entry) {
                    final index = entry.key;
                    final cat = entry.value;
                    return BarChartGroupData(
                      x: index,
                      barRods: [
                        BarChartRodData(
                          toY: cat.totalAmount,
                          color: cat.color,
                          width: 22,
                          borderRadius:
                              BorderRadius.circular(
                                6,
                              ),
                        ),
                      ],
                    );
                  })
                  .toList(),
            ),
          ),
        ),
        const SizedBox(height: 16),
        ...categories.map((cat) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                12,
              ),
            ),
            elevation: 2,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: cat.color,
                radius: 8,
              ),
              title: Text(cat.label),
              trailing: Text(
                "${formatter.format(cat.totalAmount)} đ",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        }),
      ],
    );
  }

  Widget _buildEmptyPlaceholder(String text) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
