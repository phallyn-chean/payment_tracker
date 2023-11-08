import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tracker_payment/localization/lang/method.dart';

Future<void> iosAlertDialog(BuildContext context, String content, String action, Function onAction) async {
  showCupertinoDialog(
    context: context,
    builder: (context) {
      return CupertinoAlertDialog(
        title: Padding(
          padding: EdgeInsets.only(bottom: 8.h),
          child: Text(
            getTranslated(context, 'Please Confirm') ?? 'Please Confirm',
            style: TextStyle(fontSize: 21.sp),
          ),
        ),
        content: Text(
          getTranslated(context, content) ?? content,
          style: TextStyle(fontSize: 15.5.sp),
        ),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: false,
            isDestructiveAction: false,
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 3.w),
              child: Text(
                getTranslated(context, "Cancel") ?? "Cancel",
                style: TextStyle(
                  fontSize: 19.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          CupertinoDialogAction(
            isDefaultAction: true,
            isDestructiveAction: true,
            onPressed: () {
              onAction();
              Navigator.of(context).pop();
            },
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 3.w),
              child: Text(
                getTranslated(context, action) ?? action,
                style: TextStyle(
                  fontSize: 19.5.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      );
    },
  );
}

Future<void> androidDialog(BuildContext context, String content, String action, Function onAction) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(getTranslated(context, 'Please Confirm')!),
        content: Text(getTranslated(context, content) ?? content),
        actions: [
          TextButton(
            onPressed: () {
              onAction();
              Navigator.of(context).pop();
            },
            child: Text(getTranslated(context, 'Cancel') ?? 'Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(getTranslated(context, action) ?? action),
          ),
        ],
      );
    },
  );
}
