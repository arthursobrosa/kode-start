import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:rick_morty/widgets/sliver_app_bar_widget.dart';

class TextFieldWidget extends StatelessWidget {
  TextFieldWidget({
    super.key,
    required this.onChanged,
    required this.onEditingComplete,
    required this.controller,
    required this.focusNode,
    required this.backgroundColor,
    required this.cursorColor,
    required this.inputStyle,
    required this.placeholderStyle
  });

  final ValueChanged<String> onChanged;
  final Function() onEditingComplete;
  final TextEditingController controller;
  final FocusNode focusNode;
  final double toolbarHeight = SliverAppBarWidget.toolbarHeight;
  final Color backgroundColor;
  final Color cursorColor;
  final TextStyle inputStyle;
  final TextStyle placeholderStyle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 50, left: 10, top: 20),
      child: SizedBox(
        height: toolbarHeight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(height: toolbarHeight * 0.52),

            Stack(
              children: [
                Container(
                  height: toolbarHeight * 0.48,
                  decoration: BoxDecoration(
                    color: backgroundColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: SizedBox(
                    height: toolbarHeight * 0.48,
                    child: TextField(
                      controller: controller,
                      focusNode: focusNode,
                      style: inputStyle,
                      onChanged: onChanged,
                      onEditingComplete: onEditingComplete,
                      onSubmitted: (value) => Void,
                      cursorHeight: toolbarHeight * 0.2,
                      cursorColor: cursorColor,
                      textAlignVertical: TextAlignVertical.center,
                      maxLength: 42,
                      buildCounter:
                          (
                            BuildContext context, {
                            required int currentLength,
                            required int? maxLength,
                            required bool isFocused,
                          }) => null,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Search...',
                        hintStyle: placeholderStyle,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
