import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RequirementsListWidget extends StatelessWidget {
  final List<String> requirements;
  final Function(int index) onRemove;

  const RequirementsListWidget({
    super.key,
    required this.requirements,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    if (requirements.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Wrap(
        spacing: 8.w,
        runSpacing: 4.h,
        children: requirements.asMap().entries.map((entry) {
          int index = entry.key;
          String value = entry.value;

          return Chip(
            label: Text(
              value,
              style: TextStyle(
                fontSize: 12.sp,
                color: const Color(0xFF3B67E1),
                fontWeight: FontWeight.w500,
              ),
            ),
            backgroundColor: const Color(0xFFF0F4FF),
            deleteIcon: Icon(
              Icons.cancel,
              size: 18.sp,
              color: const Color(0xFF3B67E1),
            ),
            onDeleted: () => onRemove(index),
            side: BorderSide.none,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r),
            ),
          );
        }).toList(),
      ),
    );
  }
}