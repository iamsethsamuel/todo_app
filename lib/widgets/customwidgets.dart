import 'package:flutter/material.dart';
import 'package:shammo/shammo.dart';
import 'package:todo_app/utils/theme.dart';

class Button extends StatelessWidget {
  const Button(
      {super.key,
      required this.onPressed,
      this.child,
      this.text,
      this.padding,
      this.color,
      this.textStyle});

  final void Function() onPressed;
  final Widget? child;
  final String? text;
  final EdgeInsets? padding;
  final Color? color;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: color,
        gradient: color != null
            ? null
            : LinearGradient(
                colors: [
                  AppColors.primary,
                  AppColors.primary,
                  AppColors.secondary
                ],
              ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          textStyle: const TextStyle(color: Colors.white),
        ),
        onPressed: onPressed,
        child: text != null
            ? Text(
                text!,
                style: textStyle ??
                    const TextStyle(
                      color: Colors.white,
                    ),
              )
            : child,
      ),
    );
  }
}

class ScaffoldSkeleton extends StatelessWidget {
  const ScaffoldSkeleton(
      {super.key,
      required this.body,
      this.title,
      this.appBarBottom,
      this.fab,
      this.actions,
      this.backgroundColor,
      this.disenablePadding,
      this.appBar,
      this.drawer});
  final String? title;
  final Widget body;
  final PreferredSizeWidget? appBarBottom;
  final Widget? fab;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final bool? disenablePadding;
  final AppBar? appBar;
  final Drawer? drawer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: title != null || actions != null
          ? AppBar(
              title: Text(title!),
              bottom: appBarBottom,
              actions: actions,
              centerTitle: true,
            )
          : appBar,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: disenablePadding == true ? 0 : 10,
          ),
          child: body,
        ),
      ),
      floatingActionButton: fab,
      drawer: drawer
    );
  }
}

class CustomTextField extends StatefulWidget {
  const CustomTextField(
      {super.key,
      this.label,
      required this.controller,
      this.prefix,
      this.suffix,
      this.hint,
      this.color,
      this.border,
      this.keyboardType,
      this.autoFocus,
      this.textCapitalization,
      this.maxLines,
      this.obscureText,
      this.onChanged,
      this.onTap});

  final String? label;
  final TextEditingController controller;
  final Widget? suffix;
  final Widget? prefix;
  final String? hint;
  final Color? color;
  final InputBorder? border;
  final TextInputType? keyboardType;
  final bool? autoFocus;
  final TextCapitalization? textCapitalization;
  final int? maxLines;
  final bool? obscureText;
  final Function(String)? onChanged;
  final Function()? onTap;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool focused = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.label != null)
          SizedBox(
            width: width(context),
            child: Text(widget.label!),
          ),
        TextFormField(
          autofocus: widget.autoFocus == true,
          focusNode: widget.autoFocus != null ? FocusNode() : null,
          controller: widget.controller,
          keyboardType: widget.keyboardType,
          onTap: () {
            if (widget.onTap != null) {
              widget.onTap!();
            }
            setState(() {
              focused = true;
            });
          },
          onChanged: widget.onChanged,
          onTapOutside: (_) {
            setState(() {
              focused = false;
            });
          },
          maxLines: widget.maxLines ?? 1,
          obscureText: widget.obscureText ?? false,
          textCapitalization:
              widget.textCapitalization ?? TextCapitalization.sentences,
          decoration: widget.maxLines != null
              ? InputDecoration(
                  fillColor: Colors.grey.shade200,
                  filled: true,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey.shade500,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText: widget.hint,
                  contentPadding: const EdgeInsets.all(10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                )
              : InputDecoration(
                  fillColor: Colors.grey.shade200,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ).copyWith(
                    borderSide: widget.border?.borderSide,
                  ),
                  hintText: widget.hint,
                  hintStyle: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                  suffixStyle: TextStyle(color: widget.color),
                  prefixStyle: TextStyle(color: widget.color),
                  prefixIcon: widget.prefix,
                  suffixIcon: widget.suffix,
                ),
        )
      ],
    );
  }
}
