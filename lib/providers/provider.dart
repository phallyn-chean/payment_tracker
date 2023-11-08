import 'package:flutter/material.dart';
import 'package:tracker_payment/models/category_item_model.dart';
import 'package:tracker_payment/models/input_model.dart';
import 'package:tracker_payment/services/share_preference_services.dart';
import 'package:tracker_payment/services/sqlite_service.dart';

class ChangeCategoryA with ChangeNotifier {
  CategoryItemModel? categoryItemA;

  void changeCategory(CategoryItemModel? newItem) {
    categoryItemA = newItem ?? categoryItemA;
    notifyListeners();
  }
}

class ChangeModelType with ChangeNotifier {
  String? modelType;
  void changeModelType(String newType) {
    modelType = newType;
    notifyListeners();
  }
}

class ChangeSelelectedDate with ChangeNotifier {
  String? selectedAnalysisDate;
  String? selectedReportDate;

  void changeSelectedAnalysisDate({String? newSelectDate}) {
    selectedAnalysisDate = newSelectDate;
    notifyListeners();
  }

  void changeSelectedReportDate({String? newSelectedDate}) {
    selectedReportDate = newSelectedDate;
    notifyListeners();
  }
}

// report
class InputModelList with ChangeNotifier {
  Future<List<InputModel>> inputModelList = DB.inputModelList();
  void changeInputModelList() {
    inputModelList = DB.inputModelList();
    notifyListeners();
  }
}

// expense_category
class ChangeExpenseItem with ChangeNotifier {
  var exItemsLists = sharePrefs.getAllExpenseItemsLists();
  void getAllExpenseItems() {
    exItemsLists = sharePrefs.getAllExpenseItemsLists();
    notifyListeners();
  }
}

class ChangeExpenseItemEdit with ChangeNotifier {
  var exItemsLists = sharePrefs.getAllExpenseItemsLists();
  void getAllExpenseItems() {
    exItemsLists = sharePrefs.getAllExpenseItemsLists();
    notifyListeners();
  }
}

// income_category
class ChangeIncomeItem with ChangeNotifier {
  var incomeItems = sharePrefs.getItems('income items');
  void getIncomeItems() {
    incomeItems = sharePrefs.getItems('income items');
    notifyListeners();
  }
}

class ChangeIncomeItemEdit with ChangeNotifier {
  var incomeItems = sharePrefs.getItems('income items');
  void getIncomeItems() {
    incomeItems = sharePrefs.getItems('income items');
    notifyListeners();
  }
}

// add_category
class ChangeCategory with ChangeNotifier {
  IconData? selectedCategoryIcon;
  CategoryItemModel? parentItem;

  void changeCategoryIcon(IconData? selectedIcon) {
    selectedCategoryIcon = selectedIcon;
    notifyListeners();
  }

  void changeParentIcon(CategoryItemModel? newParentItem) {
    parentItem = newParentItem;
    notifyListeners();
  }
}

// other
class OnSwitch with ChangeNotifier {
  bool isPasscodeOn = sharePrefs.isPasscodeOn;

  void onSwitch() {
    sharePrefs.isPasscodeOn = !sharePrefs.isPasscodeOn;
    isPasscodeOn = sharePrefs.isPasscodeOn;
    notifyListeners();
  }
}

// select language
class OnLanguageSelected with ChangeNotifier {
  String languageCode = sharePrefs.getLocale().languageCode;
  void onSelect(String newLanguageCode) {
    languageCode = newLanguageCode;
    notifyListeners();
  }
}

// select currency
class OnCurrencySelected with ChangeNotifier {
  String appCurrency = sharePrefs.appCurrency;
  void onCurrencySelected(String newCurrency) {
    appCurrency = newCurrency;
    sharePrefs.appCurrency = newCurrency;
    sharePrefs.getCurrency();
    notifyListeners();
  }
}

// select date format
class OnDateFormatSelected with ChangeNotifier {
  String dateFormat = sharePrefs.dateFormat;
  void onDateFormatSelected(String newDateFormat) {
    dateFormat = newDateFormat;
    sharePrefs.dateFormat = newDateFormat;
    notifyListeners();
  }
}
