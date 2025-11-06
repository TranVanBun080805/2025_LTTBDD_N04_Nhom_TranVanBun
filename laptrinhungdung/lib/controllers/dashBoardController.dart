import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'incomeProvider.dart';

class DashboardController {
  // ✅ Tính số dư
  double getBalance(
    BuildContext context,
    double totalExpense,
  ) {
    final income = Provider.of<Incomeprovider>(
      context,
      listen: false,
    ).totalIncome;
    return income - totalExpense;
  }

  // ✅ Hiển thị dialog cập nhật thu nhập
  void showUpdateIncomeDialog(
    BuildContext context,
  ) {
    final incomeProvider =
        Provider.of<Incomeprovider>(
          context,
          listen: false,
        );
    final TextEditingController controller =
        TextEditingController(
          text: incomeProvider.totalIncome
              .toStringAsFixed(0),
        );

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              16,
            ),
          ),
          title: const Text(
            'Cập nhật thu nhập',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText:
                  'Nhập thu nhập mới (VNĐ)',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () =>
                  Navigator.pop(context),
              child: const Text('Hủy'),
            ),
            ElevatedButton(
              onPressed: () {
                final value =
                    double.tryParse(
                      controller.text
                          .replaceAll('.', '')
                          .replaceAll(',', ''),
                    ) ??
                    incomeProvider.totalIncome;
                incomeProvider.updateIncome(
                  value,
                );
                Navigator.pop(context);
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(
                  const SnackBar(
                    content: Text(
                      '✅ Cập nhật thu nhập thành công!',
                    ),
                    behavior:
                        SnackBarBehavior.floating,
                    backgroundColor: Colors.green,
                  ),
                );
              },
              child: const Text('Xác nhận'),
            ),
          ],
        );
      },
    );
  }
}
