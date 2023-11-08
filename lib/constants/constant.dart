import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tracker_payment/models/category_item_model.dart';
import 'package:tracker_payment/services/share_preference_services.dart';

import '../models/input_model.dart';

Color green = const Color.fromRGBO(57, 157, 3, 1),
    red = const Color.fromRGBO(217, 89, 89, 1),
    white = const Color.fromRGBO(255, 255, 255, 1),
    blue1 = const Color.fromRGBO(210, 234, 251, 1),
    blue2 = const Color.fromRGBO(139, 205, 254, 1),
    blue3 = const Color.fromRGBO(89, 176, 222, 1),
    grey = Colors.grey;

List<Color> chartPieColors = [
  // 19
  const Color.fromRGBO(100, 202, 254, 1),
  const Color.fromRGBO(80, 157, 253, 1),
  const Color.fromRGBO(7, 156, 193, 1),
  const Color.fromRGBO(89, 129, 163, 1),

  const Color.fromRGBO(79, 94, 120, 1),
  const Color.fromRGBO(196, 199, 216, 1),
  const Color.fromRGBO(255, 206, 161, 1),
  const Color.fromRGBO(255, 183, 121, 1),
  const Color.fromRGBO(237, 156, 128, 1),
  const Color.fromRGBO(126, 180, 166, 1),
  const Color.fromRGBO(212, 216, 140, 1),
  const Color.fromRGBO(144, 192, 106, 1),
  const Color.fromRGBO(128, 186, 76, 1),
  const Color.fromRGBO(224, 217, 255, 1),
  const Color.fromRGBO(202, 164, 255, 1),
  const Color.fromRGBO(197, 156, 240, 1),
  const Color.fromRGBO(241, 197, 211, 1),
  const Color.fromRGBO(244, 151, 178, 1),
  const Color.fromRGBO(218, 145, 176, 1),

  // 20
  const Color.fromRGBO(141, 190, 255, 1),
  const Color.fromRGBO(160, 217, 254, 1),
  const Color.fromRGBO(117, 216, 228, 1),
  const Color.fromRGBO(120, 217, 192, 1),
  const Color.fromRGBO(172, 198, 152, 1),
  const Color.fromRGBO(162, 193, 115, 1),
  const Color.fromRGBO(112, 164, 112, 1),
  const Color.fromRGBO(65, 174, 223, 1),
  const Color.fromRGBO(71, 131, 192, 1),
  const Color.fromRGBO(32, 225, 188, 1),
  const Color.fromRGBO(53, 136, 143, 1),
  const Color.fromRGBO(139, 178, 193, 1),
  const Color.fromRGBO(125, 150, 191, 1),
  const Color.fromRGBO(119, 131, 148, 1),
  const Color.fromRGBO(243, 210, 122, 1),
  const Color.fromRGBO(254, 203, 94, 1),
  const Color.fromRGBO(244, 186, 106, 1),
  const Color.fromRGBO(217, 165, 105, 1),
  const Color.fromRGBO(214, 142, 96, 1),
  const Color.fromRGBO(190, 119, 112, 1),
  const Color.fromRGBO(194, 94, 78, 1),
  const Color.fromRGBO(192, 72, 42, 1),
  const Color.fromRGBO(176, 29, 51, 1),

  // 18
  const Color.fromRGBO(198, 180, 251, 1),
  const Color.fromRGBO(155, 128, 217, 1),
  const Color.fromRGBO(112, 130, 212, 1),
  const Color.fromRGBO(78, 123, 216, 1),
  const Color.fromRGBO(139, 205, 254, 1),
  const Color.fromRGBO(89, 176, 222, 1),
  const Color.fromRGBO(81, 155, 194, 1),
  const Color.fromRGBO(4, 135, 192, 1),
  const Color.fromRGBO(50, 128, 171, 1),
  const Color.fromRGBO(44, 110, 119, 1),
  const Color.fromRGBO(41, 147, 134, 1),
  const Color.fromRGBO(95, 155, 71, 1),
  const Color.fromRGBO(179, 217, 37, 1),
  const Color.fromRGBO(237, 178, 135, 1),
  const Color.fromRGBO(198, 157, 100, 1),
  const Color.fromRGBO(194, 140, 112, 1),
  const Color.fromRGBO(214, 138, 88, 1),
  const Color.fromRGBO(225, 123, 66, 1),
];

String format(double number) {
  return NumberFormat("#, ###, ###, ###, ###, ###.##", "en_US").format(number);
}

IconData iconData(CategoryItemModel item) {
  return IconData(item.iconCodePoint, fontPackage: item.iconFontPackage, fontFamily: item.iconFontFamily);
}

CategoryItemModel categoryItemModel(IconData icon, String name) {
  return CategoryItemModel(
    iconCodePoint: icon.codePoint,
    iconFontPackage: icon.fontPackage!,
    iconFontFamily: icon.fontFamily!,
    text: name,
    description: '',
  );
}

Widget? connectionUI(AsyncSnapshot<List<InputModel>> snapshot) {
  if (snapshot.connectionState == ConnectionState.none) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
  if (snapshot.hasError) {
    print("${snapshot.error}");
    return const Center(child: CircularProgressIndicator());
  }
}

List<CategoryItemModel> createItemList({
  List<InputModel>? transactions,
  required bool forAnalysisPage,
  isIncomeType,
  forSelectIconPage,
}) {
  List<CategoryItemModel> itemList = [], items = [], expenseItems = [];
  sharePrefs.getAllExpenseItemsLists().forEach((parentExpenseItem) {
    parentExpenseItem.forEach((expenseItem) {
      expenseItems.add(expenseItem);
    });
  });
  if (forAnalysisPage) {
    items = isIncomeType ? incomeItems : expenseItems;
  } else {
    items = [...incomeItems, ...expenseItems];
  }

  if (forSelectIconPage) {
    return items;
  } else {
    // ignore: unused_local_variable
    for (InputModel transaction in transactions!) {
      for (int i = 0; i < items.length; i++) {
        if (transaction.category == items[i].text) {
          itemList.add(items[i]);
          break;
        }
        if (i == items.length - 1) {
          CategoryItemModel itemElse = CategoryItemModel(
            iconCodePoint: Icons.category_outlined.codePoint,
            iconFontPackage: Icons.category_outlined.fontPackage!,
            iconFontFamily: Icons.category_outlined.fontFamily!,
            text: transaction.category,
            description: transaction.description,
          );
          itemList.add(itemElse);
        }
      }
    }
    return itemList;
  }
}

final DateTime now = DateTime.now(),
    todayDT = DateTime(now.year, now.month, now.day),
    startOfThisWeek = todayDT.subtract(Duration(days: todayDT.weekday - 1)),
    startOfThisMonth = DateTime(todayDT.year, todayDT.month, 1),
    startOfThisYear = DateTime(todayDT.year, 1, 1),
    startOfThisQuarter = DateTime(todayDT.year, quarterStartMonth, 1);

final int thisQuarter = (todayDT.month + 2 ~/ 3), quarterStartMonth = 3 * thisQuarter - 2;

final List<String> timeline = [
  'Today',
  'This week',
  'This month',
  'This quarter',
  'This year',
  'All',
];

InputModel inputModel(data) {
  return InputModel(
    id: data.id,
    type: data.type,
    amount: data.amount!,
    category: data.category!,
    description: data.description!,
    date: data.date,
    time: data.time,
  );
}

List<InputModel> filterData(BuildContext context, List<InputModel> data, String selectedDate) {
  return (data
          .map((data) {
            DateTime dateSelectedDT = DateFormat('dd/MM/yyyy').parse(data.date);
            if (selectedDate == 'Today') {
              if (dateSelectedDT.isAfter(todayDT.subtract(const Duration(days: 1))) && dateSelectedDT.isBefore(todayDT.add(const Duration(days: 1)))) {
                return inputModel(data);
              }
            } else if (selectedDate == 'This week') {
              if (dateSelectedDT.isAfter(startOfThisWeek.subtract(const Duration(days: 1))) && dateSelectedDT.isBefore(startOfThisWeek.add(const Duration(days: 7)))) {
                return inputModel(data);
              }
            } else if (selectedDate == 'This month') {
              if (dateSelectedDT.isAfter(startOfThisMonth.subtract(const Duration(days: 1))) && dateSelectedDT.isBefore(DateTime(todayDT.year, todayDT.month + 1, 1))) {
                return inputModel(data);
              }
            } else if (selectedDate == 'This quarter') {
              if (dateSelectedDT.isAfter(startOfThisQuarter.subtract(const Duration(days: 1))) && dateSelectedDT.isBefore(DateTime(startOfThisQuarter.year, startOfThisQuarter.month + 3, 1))) {
                return inputModel(data);
              }
            } else if (selectedDate == 'This year') {
              if (dateSelectedDT.isAfter(startOfThisYear.subtract(const Duration(days: 1))) && dateSelectedDT.isBefore(DateTime(todayDT.year + 1, 1, 1))) {
                return inputModel(data);
              }
            } else {
              return inputModel(data);
            }
          })
          .where((element) => element != null)
          .toList())
      .cast<InputModel>();
}
