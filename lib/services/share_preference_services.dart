import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:icofont_flutter/icofont_flutter.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tracker_payment/localization/lang/method.dart';
import 'package:tracker_payment/models/category_item_model.dart';
import 'package:tracker_payment/constants/constant.dart';

final sharePrefs = SharePrefs();
late String currency;

class SharePrefs {
  static SharedPreferences? _sharePrefs;

  sharePrefsInit() async {
    _sharePrefs ??= await SharedPreferences.getInstance();
  }

  String get selectDate {
    return _sharePrefs!.getString('selectedDate')!;
  }

  set selectedDate(String value) {
    _sharePrefs!.setString('selectedDate', value);
  }

  String get appCurrency {
    return _sharePrefs!.getString('appCurrency') ?? Platform.localeName;
  }

  set appCurrency(String appCurrency) {
    _sharePrefs!.setString('appCurrency', appCurrency);
  }

  String get dateFormat {
    return _sharePrefs!.getString('dateFormat') ?? 'dd/MM/yyyy';
  }

  set dateFormat(String dateFormat) {
    _sharePrefs!.setString('dateFormat', dateFormat);
  }

  bool get isPasscodeOn {
    return _sharePrefs!.getBool('isPasscodeOn') ?? false;
  }

  set isPasscodeOn(bool value) {
    _sharePrefs!.setBool('isPasscodeOn', value);
  }

  String get passcodeScreenLock {
    return _sharePrefs!.getString('passcodeScreenLock')!;
  }

  set passcodeScreenLock(String value) {
    _sharePrefs!.setString('passcodeScreenLock', value);
  }

  List<String> get parentExpenseItemNames {
    return _sharePrefs!.getStringList('parent expense item names')!;
  }

  set parentExpenseItemNames(List<String> parentExpenseItemNames) {
    _sharePrefs!.setStringList('parentExpanseItemName', parentExpenseItemNames);
  }

  Locale setLocale(String languageCode) {
    _sharePrefs!.setString('languageCode', languageCode);
    return local(languageCode);
  }

  Locale getLocale() {
    String languageCode = _sharePrefs!.getString('languageCode') ?? "en";
    return local(languageCode);
  }

  void getCurrency() {
    if (_sharePrefs!.containsKey('appCurrency')) {
      var format = NumberFormat.simpleCurrency(locale: sharePrefs.appCurrency);
      currency = format.currencySymbol;
    } else {
      var format = NumberFormat.simpleCurrency(locale: Platform.localeName);
      currency = format.currencySymbol;
    }
  }

  List<CategoryItemModel> getItems(String parentItemName) {
    List<String> itemsEncoded = _sharePrefs!.getStringList(parentItemName)!;
    List<CategoryItemModel> items = itemsEncoded
        .map((item) => CategoryItemModel.fromJson(
              jsonDecode(item),
            ))
        .toList();

    return items;
  }

  void saveItems(String parentItemName, List<CategoryItemModel> items) {
    List<String> itemsEncoded = items
        .map((item) => jsonEncode(
              item.toJson(),
            ))
        .toList();
    _sharePrefs!.setStringList(parentItemName, itemsEncoded);
  }

  List<List<CategoryItemModel>> getAllExpenseItemsLists() {
    List<List<CategoryItemModel>> expenseItemsLists = [];
    for (int i = 0; i < parentExpenseItemNames.length; i++) {
      var parentExpenseItem = sharePrefs.getItems(parentExpenseItemNames[i]);
      expenseItemsLists.add(parentExpenseItem);
    }
    return expenseItemsLists;
  }

  void removeItem(String itemName) {
    _sharePrefs!.remove(itemName);
  }

  void setItems({required bool setCategoriesToDefault}) {
    if (!_sharePrefs!.containsKey('parent expense item names') || setCategoriesToDefault) {
      _sharePrefs!.setStringList('parent expense item names', [
        'Food & Beverages',
        'Transport',
        'Personal Development',
        'Shopping',
        'Entertainment',
        'Home',
        'Utility Bills',
        'Health',
        'Gift & Donations',
        'Kids',
        'OtherExpense',
      ]);

      saveItems('income items', [
        categoryItemModel(MdiIcons.accountCash, 'Salary'),
        categoryItemModel(Icons.business_center_rounded, "InvestmentIncome"),
        categoryItemModel(IcoFontIcons.moneyBag, 'Bonus'),
        categoryItemModel(IcoFontIcons.searchJob, 'Side job'),
        categoryItemModel(IcoFontIcons.gift, "GiftsIncome"),
        categoryItemModel(MdiIcons.cashPlus, 'OtherIncome'),
      ]);
    }
  }
}
