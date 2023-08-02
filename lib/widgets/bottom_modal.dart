import 'package:flutter/material.dart';
import 'package:flutter_mobile_bx/const/color.dart';
import 'package:flutter_mobile_bx/helpers/navigation_context.dart';
import 'package:flutter_mobile_bx/helpers/sizes.dart';

class CommonDialogs {
  static bottomDialog(Widget widget,
      {double height = 200,
      bool dismissable = true,
      Color color = Colors.white}) {
    // Size size = MediaQuery.of(Navigation().context).size;
    return showModalBottomSheet(
      enableDrag: dismissable,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      isDismissible: dismissable,
      context: Navigation().context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      backgroundColor: color,
      isScrollControlled: true,
      builder: (ctx) {
        return Wrap(children: [
          SingleChildScrollView(
            padding: EdgeInsets.only(
                bottom:
                    MediaQuery.of(Navigation().context).viewInsets.bottom + 10),
            child: Container(
              //height: height,
              padding: const EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 30,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      padding: const EdgeInsets.symmetric(
                        vertical: 1,
                        horizontal: 2,
                      ),
                      decoration: const BoxDecoration(
                        color: ConstColor.greyColor,
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                    ),
                  ),
                  sh(height: 25),
                  widget
                ],
              ),
            ),
          ),
        ]);
      },
    );
  }

  static bottomDialogWithHeight(Widget widget,
      {double height = 400,
      bool dismissable = true,
      Color color = Colors.white}) {
    // Size size = MediaQuery.of(Navigation().context).size;
    return showModalBottomSheet(
      enableDrag: dismissable,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      isDismissible: dismissable,
      context: Navigation().context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      backgroundColor: color,
      isScrollControlled: true,
      builder: (ctx) {
        return Container(
          height: height,
          padding: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 30,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  padding: const EdgeInsets.symmetric(
                    vertical: 1,
                    horizontal: 2,
                  ),
                  decoration: const BoxDecoration(
                    color: ConstColor.greyColor,
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                ),
              ),
              sh(height: 25),
              widget
            ],
          ),
        );
      },
    );
  }

  static dialog({required Widget widget, bool dismissable = true}) {
    return showDialog(
      context: Navigation().context,
      barrierDismissible: dismissable,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          contentPadding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          content: widget,
        );
      },
    );
  }
}
