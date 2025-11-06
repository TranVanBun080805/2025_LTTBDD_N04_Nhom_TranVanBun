import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/categoryProvider.dart';
import 'package:intl/intl.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context
        .watch<CategoryProvider>();
    final history = provider.history;
    final categories = provider.categories;

    final formatter = NumberFormat(
      "#,##0",
      "vi_VN",
    );

    return Scaffold(
      backgroundColor: const Color(0xFFF3F6FB),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "Lịch sử chi tiêu",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF3A7BD5),
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 3,
      ),
      body: history.isEmpty
          ? const Center(
              child: Text(
                "Chưa có khoản chi tiêu nào 💤",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: history.length,
              itemBuilder: (context, index) {
                final item = history[index];

                // 🔹 Lấy danh mục tương ứng để hiển thị icon và màu
                final category = categories
                    .firstWhere(
                      (c) => c.id == item.id,
                      orElse: () => CategoryItem(
                        id: '0',
                        label: 'Khác',
                        icon: Icons.category,
                        color:
                            Colors.grey.shade400,
                      ),
                    );

                return _buildHistoryCard(
                  formatter,
                  item,
                  category,
                );
              },
            ),
    );
  }

  Widget _buildHistoryCard(
    NumberFormat formatter,
    dynamic item,
    CategoryItem category,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.12),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
        border: Border(
          left: BorderSide(
            color: category.color.withOpacity(
              0.9,
            ),
            width: 5,
          ),
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: category.color
                .withOpacity(0.2),
            radius: 24,
            child: Icon(
              category.icon,
              color: category.color,
              size: 26,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  item.label,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1E355B),
                  ),
                ),
                if (item.description.isNotEmpty)
                  Padding(
                    padding:
                        const EdgeInsets.only(
                          top: 4,
                        ),
                    child: Text(
                      item.description,
                      style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 14,
                      ),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 6,
                  ),
                  child: Text(
                    DateFormat(
                      'dd/MM/yyyy HH:mm',
                    ).format(item.date),
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Text(
            "-${formatter.format(item.amount)} đ",
            style: const TextStyle(
              color: Colors.redAccent,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
