
import 'package:contact_app/utils/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class CustomInputField extends StatefulWidget {
  final String fieldName;
  final void Function()? onTap;
  final String? Function(String?)? validator;
  final void Function(String?)? onChanged;
  final List<TextInputFormatter> inputFormatters;
  final TextCapitalization textCapitalization;
  final TextEditingController controller;
  final bool hasValidationError;
  final int? maxLength;
  final bool isPasswordField;
  final InputDecoration inputDecoration;
  final TextStyle? style;
  final TextInputType? keyboardType;
  final EdgeInsetsGeometry? contentPadding;
  final bool readOnly;
  final String? hintText;
  final Widget? suffixIcon;

  const CustomInputField({
    super.key,
    required this.fieldName,
    this.validator,
    required this.controller,
    this.hasValidationError = false,
    this.readOnly = false,
    this.inputFormatters = const [],
    this.textCapitalization = TextCapitalization.sentences,
    this.maxLength,
    this.onChanged,
    this.isPasswordField = false,
    this.keyboardType,
    this.inputDecoration = const InputDecoration(),
    this.onTap,
    this.contentPadding,
    this.style,
    this.hintText,
    this.suffixIcon,
  });

  @override
  State<CustomInputField> createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  bool hasError = false;
  bool showPassword = false;
  final FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    focusNode.addListener(listener);
  }

  @override
  void dispose() {
    focusNode.removeListener(listener);
    focusNode.dispose();
    super.dispose();
  }

  listener() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.fieldName.isNotEmpty)
            Text(
              widget.fieldName,
              style: AppTheme.mainTextStyle
            ),
          const SizedBox(
            height: 5,
          ),
          TextFormField(
            controller: widget.controller,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            focusNode: focusNode,
            enabled: !widget.readOnly || widget.onTap != null,
            textCapitalization: widget.textCapitalization,
            inputFormatters: widget.inputFormatters,
            maxLength: widget.maxLength,
            obscureText: !widget.isPasswordField ? false : !showPassword,
            obscuringCharacter: '*',
            readOnly: widget.readOnly,
            onTap: widget.onTap,
            keyboardType: widget.keyboardType ??
                (widget.inputFormatters
                        .contains(FilteringTextInputFormatter.digitsOnly)
                    ? TextInputType.number
                    : null),

            // textAlignVertical: widget.isPasswordField && !showPassword
            //     ? TextAlignVertical.bottom
            //     : TextAlignVertical.center,

            decoration: widget.inputDecoration.copyWith(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: Color(0xffCCD1D3),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: Color(0xff473767),
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: Color(0xffEA2626),
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: const Color(0xffEA2626).withOpacity(0.6),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: Color(0xffCCD1D3),
                ),
              ),
              hintText: widget.hintText,
              hintStyle: AppTheme.headerTextStyle.override(fontSize: 14,color: const Color.fromARGB(255, 110, 110, 110)),
              contentPadding: widget.contentPadding ??
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
              filled: false,
              fillColor: widget.hasValidationError || hasError
                  ? const Color(0xffEA2626).withOpacity(0.02)
                  : focusNode.hasFocus
                      ? Colors.white
                      : const Color(0xffF8F8F8),
              focusColor: Colors.white,
              counterText: '',
              suffixIcon: !widget.isPasswordField
                  ? widget.suffixIcon
                  : IconButton(
                      onPressed: () {
                        setState(() {
                          showPassword = !showPassword;
                        });
                      },
                      splashRadius: 0.1,
                      icon: showPassword
                          ? const Icon(
                              CupertinoIcons.eye_fill,
                              color: Color(0xff392F4E),
                            )
                          : const Icon(
                              CupertinoIcons.eye_slash_fill,
                              color: Color(0xffCECECE),
                            ),
                    ),
            ),
            onChanged: (val) {
              // resetTimer();
              if (widget.onChanged != null) {
                widget.onChanged!(val);
              } else {
                setState(() {
                  hasError = val.trim().isEmpty;
                });
              }
            },
            style: widget.style ??
                AppTheme.headerTextStyle.override(fontSize: 16),
            cursorColor: const Color(0xff222222),
            validator: widget.validator ??
                (val) {
                  var returnValue = val!.trim().isEmpty
                      ? '${widget.fieldName} cannot be empty'
                      : null;
                  return returnValue;
                },
          ),
        ],
      ),
    );
  }
}
