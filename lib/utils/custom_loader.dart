import 'dart:async';

import 'package:contact_app/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CustomLoader {
  static BuildContext? _context;
  CustomLoader();

  static showLoader(BuildContext context, [List<String>? messages]) {
    showDialog(
      barrierDismissible: false,
      useRootNavigator: true,
      barrierColor: Colors.black.withOpacity(0.8),
      context: context,
      builder: (pageContext) {
        _context = pageContext;
        return _Loader(messages: messages);
      },
    );
  }

  static Future<void> dismissLoader() async {
    await Future.delayed(const Duration(milliseconds: 200));
    //checking if the context is still mounted and is not null
    if (_context != null && _context!.mounted) {
      Navigator.pop(_context!);
    }
  }
}

class _Loader extends StatefulWidget {
  final List<String>? messages;
  const _Loader({this.messages});

  @override
  State<_Loader> createState() => __LoaderState();
}

class __LoaderState extends State<_Loader> {
  int index = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    if (widget.messages != null && widget.messages!.isNotEmpty) {
      _startTimer();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      int newIndex = index + 1;
      if (newIndex == widget.messages!.length) {
        _timer?.cancel();
      } else {
        setState(() {
          index = newIndex;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async => false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (widget.messages != null && widget.messages!.isNotEmpty)
            Material(
              color: Colors.transparent,
              child: Container(
                margin: const EdgeInsets.only(bottom: 20),
                child: Text(
                  widget.messages![index],
                  textAlign: TextAlign.center,
                  style: AppTheme.headerTextStyle.copyWith(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          SizedBox(
            height: 0.15 * width,
            width: 0.15 * width,
            child: SpinKitChasingDots(
              itemBuilder: (context, index) {
                return DecoratedBox(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color:
                        index % 2 == 0 ? Colors.white : AppTheme.btnColor,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
