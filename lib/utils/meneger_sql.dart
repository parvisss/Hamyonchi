import 'package:exam_6/data/models/cahrt_data.dart';
import 'package:exam_6/data/models/expense.dart';

class MenegerSql {
  //! calculates total summ from data
  Future<double> calculateTotalExpense(List<Expense> expense) async {
    double sum = 0;
    for (var i in expense) {
      sum += double.parse(i.summ);
    }
    return sum;
  }

//! gets categories from list of data
  Future<List<String>> getCategories(List<Expense> expenses) async {
    Set<String> categories = {};
    for (var i in expenses) {
      categories.add(i.category);
    }
    return categories.toList();
  }

  //! gets a values like percent and amount from data
  Future<List<ChartData>> totalExValue(List<Expense> expenses) async {
    final double totalSumm = await calculateTotalExpense(expenses);
    List<ChartData> data = [];
    Map<String, double> separate = {};

    for (var expense in expenses) {
      double expenseSumm = double.parse(expense.summ);
      if (separate.containsKey(expense.category)) {
        separate[expense.category] = separate[expense.category]! + expenseSumm;
      } else {
        separate[expense.category] = expenseSumm;
      }
    }

    separate.forEach((category, totalCategorySumm) {
      double percent = (totalCategorySumm * 100) / totalSumm;
      data.add(
        ChartData(
          category,
          percent,
          totalCategorySumm,
        ),
      );
    });

    return data;
  }
}
