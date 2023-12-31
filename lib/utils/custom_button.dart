import 'package:contact_app/utils/app_theme.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final bool removePadding;
  final String label;
  final Function() onTap;
  const CustomButton({super.key,required this.label,required this.onTap, this.removePadding = false});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData().copyWith(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent
      ),
      child: InkWell(
        onTap: onTap,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal:removePadding?0: 24),
          alignment: Alignment.center,
                width: double.maxFinite,
                height: 55,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: AppTheme.btnColor
                ),
                child: Text(label,style: AppTheme.headerTextStyle.override(fontSize: 17),),
              ),
      ),
    );
  }
}