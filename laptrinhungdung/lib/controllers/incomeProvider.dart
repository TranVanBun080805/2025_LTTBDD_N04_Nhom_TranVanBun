import 'package:flutter/foundation.dart';

class Incomeprovider with ChangeNotifier {
  double _totalIncome = 13500000;

  double get totalIncome => _totalIncome;
  //Hàm giúp cập nhật thu nhập với của người dùng
  void updateIncome(double amount) {
    _totalIncome = amount;
    notifyListeners();
  }
}
