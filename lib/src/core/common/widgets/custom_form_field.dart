import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_manager/src/app/theme/app_colors.dart';

class CustomFormField extends StatefulWidget {
  CustomFormField({
    Key? key,
    this.title = 'title',
    this.prefixIcon,
    required this.hintText,
    this.suffixIcon,
    this.suffix,
    this.prefix,
    this.obscureText = false,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.autoValidate = true,
    this.onChange,
    this.isPassword,
    required this.validator,
    this.readOnly = false,
    this.onTap,
    this.maxLength = 30,
  }) : super(key: key);
  final bool autoValidate;
  final Widget? prefixIcon;
  final Widget? suffix;
  final String hintText;
  final String title;
  final IconData? suffixIcon;
  final TextInputType keyboardType;
  final bool obscureText;
  final bool readOnly;
  final TextEditingController? controller;
  final Function(String)? onChange;
  late bool? isPassword;
  final Function()? onTap;
  final FormFieldValidator<String?> validator;
  final Widget? prefix;
  final int? maxLength;

  @override
  State<CustomFormField> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.all(2.0),
          child: Text(
            widget.title,
            style: Theme.of(context).textTheme.bodyText2?.copyWith(color: AppColors.blue),
          ),
        ),
        TextFormField(
          onTap: widget.onTap,
          maxLength: widget.maxLength,
          cursorHeight: 25.0,
          validator: widget.validator != null ? widget.validator : null,
          onChanged: widget.onChange,
          readOnly: widget.readOnly,
          keyboardType: widget.keyboardType,
          controller: widget.controller,
          autovalidateMode: widget.autoValidate ? AutovalidateMode.always : AutovalidateMode.disabled,
          obscureText: widget.isPassword!,
          style: Theme.of(context).textTheme.subtitle1,
          decoration: InputDecoration(
            errorMaxLines: 3,
            filled: false,
            border: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.blue, width: 1.5),
              borderRadius: BorderRadius.circular(10.r),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.blue, width: 1.5),
              borderRadius: BorderRadius.circular(10.r),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.blue, width: 1.5),
              borderRadius: BorderRadius.circular(10.r),
            ),
            prefixIcon: widget.prefixIcon == null
                ? null
                : Padding(
                    padding: EdgeInsetsDirectional.only(
                      start: 18.w,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        widget.prefixIcon!,
                      ],
                    ),
                  ),
            suffix: widget.suffix,
            isCollapsed: true,
            hintText: widget.hintText,
            hintStyle: TextStyle(
              color: AppColors.blue,
            ),
            contentPadding: const EdgeInsets.all(15),
            prefix: widget.prefix,
            suffixIcon: widget.suffixIcon != null
                ? Padding(
                    padding: EdgeInsetsDirectional.only(start: 25.w, end: 12.w),
                    child: IconButton(
                      icon: widget.isPassword!
                          ? const Icon(
                              Icons.visibility_off,
                              color: AppColors.blue,
                            )
                          : const Icon(
                              Icons.visibility,
                              color: AppColors.blue,
                            ),
                      onPressed: () {
                        setState(() {
                          widget.isPassword = !widget.isPassword!;
                        });
                      },
                    ),
                  )
                : null,
          ),
        ),
      ],
    );
  }
}
