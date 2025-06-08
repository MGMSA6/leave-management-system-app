import 'package:flutter/material.dart';
import 'package:manam_leave_management/core/theme/font_family.dart';

import '../../core/theme/app_colors.dart';

class CustomSegmentedControl extends StatelessWidget {
  final int currentIndex;
  final Function(int) onValueChanged;
  final List<String> titles;

  const CustomSegmentedControl({
    super.key,
    required this.currentIndex,
    required this.onValueChanged,
    required this.titles,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      padding: const EdgeInsets.all(4),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: AppColors.backColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final segmentWidth = constraints.maxWidth / titles.length;

          return Stack(
            children: [
              // Animated thumb background
              AnimatedPositioned(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                left: segmentWidth * currentIndex,
                top: 0,
                bottom: 0,
                width: segmentWidth,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                ),
              ),

              // Text Buttons
              Row(
                children: List.generate(titles.length, (index) {
                  final selected = index == currentIndex;
                  return Expanded(
                    child: GestureDetector(
                      onTap: () => onValueChanged(index),
                      child: Center(
                        child: Text(
                          titles[index],
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: FontFamily.poppins,
                            fontWeight: FontWeight.w500,
                            color: selected
                                ? AppColors.textColor1
                                : Colors.black54,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              )
            ],
          );
        },
      ),
    );
  }
}
