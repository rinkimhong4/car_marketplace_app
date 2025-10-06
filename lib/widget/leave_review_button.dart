import 'package:flutter/material.dart';

class LeaveReviewButton extends StatelessWidget {
  final VoidCallback onPressed;
  final double width;
  final double height;

  const LeaveReviewButton({
    super.key,
    required this.onPressed,
    this.width = 160,
    this.height = 40,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
        ),
        onPressed: onPressed,
        child: const Text(
          'Leave Review',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
