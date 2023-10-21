import 'package:contact_app/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ActionBtn extends StatelessWidget {
  final String icons;
  final Function() callback;
  const ActionBtn({required this.icons,required this.callback,super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callback,
      child: Container(
                          width: 40,
                          height: 40,
                          padding: const EdgeInsets.all(9),
                          decoration: BoxDecoration(
                            color: AppTheme.btnColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: SvgPicture.string(icons),
                        ),
    );
  }
}