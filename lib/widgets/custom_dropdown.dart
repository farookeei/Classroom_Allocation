import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../themes/color_variables.dart';

class SelectFieldType {
  final String label;
  final String value;
  SelectFieldType({required this.label, required this.value});
}

enum Variant { filled, outlined }

class CustomSelectField extends StatefulWidget {
  final String label;
  final Widget? labelWidget;
  final String hintText;
  final Function handleChange;
  final List<SelectFieldType> listOptions;
  final Color labelColor;
  final Color inputColor;
  final Color fillColor;
  final Color borderColor;
  final String? errorText;
  final Variant variant;
  final String? choosenValue;
  final Function(String?)? onSaved;
  const CustomSelectField({
    Key? key,
    required this.label,
    this.labelWidget,
    required this.hintText,
    required this.handleChange,
    required this.listOptions,
    this.choosenValue,
    this.errorText,
    this.labelColor = ReplyColors.neutralBold,
    this.inputColor = ReplyColors.neutralBold,
    this.fillColor = ReplyColors.neutralLight,
    this.borderColor = ReplyColors.neutral50,
    this.onSaved,
    required this.variant,
  }) : super(key: key);

  @override
  State<CustomSelectField> createState() => _CustomSelectFieldState();
}

class _CustomSelectFieldState extends State<CustomSelectField> {
  String? chosenValue;

  @override
  void initState() {
    chosenValue = widget.choosenValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.labelWidget == null
            ? CustomLabel(label: widget.label, labeColor: widget.labelColor)
            : widget.labelWidget!,
        const SizedBox(height: 8),
        DropdownButtonHideUnderline(
          child: DropdownButtonFormField<String>(
            borderRadius: BorderRadius.circular(5.r),
            hint: Text(widget.hintText,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: ReplyColors.neutral50)),
            decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(vertical: 16.h, horizontal: 12.w),
              errorText: widget.errorText,
              errorStyle: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: ReplyColors.red25,
                  ),
              border: const OutlineInputBorder(),
              filled: widget.variant == Variant.filled ? true : false,
              fillColor: widget.fillColor,
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.r),
                borderSide: widget.variant == Variant.filled
                    ? BorderSide.none
                    : BorderSide(width: 1.5, color: ReplyColors.red25),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.r),
                borderSide: widget.variant == Variant.filled
                    ? BorderSide.none
                    : BorderSide(width: 1.5, color: widget.borderColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.r),
                borderSide: widget.variant == Variant.filled
                    ? BorderSide(width: 1.5, color: widget.borderColor)
                    : const BorderSide(width: 1.5, color: ReplyColors.blue75),
              ),
            ),
            value: chosenValue,
            icon: const Icon(Icons.keyboard_arrow_down_rounded),
            elevation: 16,
            style: Theme.of(context).textTheme.labelLarge!.copyWith(
                color: ReplyColors.neutralBold, fontWeight: FontWeight.w500),
            onChanged: (String? newValue) {
              onChange(newValue);
            },
            onSaved: widget.onSaved,
            isExpanded: true,
            menuMaxHeight: 300.h,
            dropdownColor: widget.fillColor,
            items: widget.listOptions
                .map<DropdownMenuItem<String>>((SelectFieldType value) {
              return DropdownMenuItem<String>(
                value: value.value,
                child: Text(
                  value.label,
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      color: ReplyColors.neutralBold,
                      fontWeight: FontWeight.w500),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  void onChange(String? newValue) {
    widget.handleChange(newValue);
    setState(() {
      chosenValue = newValue;
    });
  }
}

class CustomLabel extends StatelessWidget {
  final String label;
  final Color labeColor;
  const CustomLabel(
      {Key? key, required this.label, this.labeColor = ReplyColors.neutralBold})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: Theme.of(context)
          .textTheme
          .labelLarge!
          .copyWith(color: labeColor, fontWeight: FontWeight.w500),
    );
  }
}
