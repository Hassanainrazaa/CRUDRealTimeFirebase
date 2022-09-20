import "package:flutter/material.dart";

class RoundedButton extends StatelessWidget {
  String? title;
  VoidCallback? onTap;
  RoundedButton({Key? key, required this.onTap, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            color: Colors.purple,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Text(
              title!,
              style: const TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ),
      ),
    );
  }
}
