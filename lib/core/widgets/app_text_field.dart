import 'package:flutter/material.dart';

enum DataType { string, double }

class AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final String errorText;
  final String mainLabel;
  final String? subLabel;
  final DataType dataType;
  final String? Function()? specialValidator;

  const AppTextField({
    super.key,
    required this.controller,
    required this.errorText,
    required this.mainLabel,
    this.subLabel,
    this.dataType = DataType.string,
    this.specialValidator,
  });

  @override
  Widget build(BuildContext context) {
    const double fontSize = 32;

    return Column(
      children: [
        Row(
          mainAxisAlignment: subLabel != null ? MainAxisAlignment.spaceBetween : MainAxisAlignment.start,
          children: [
            Text(
              mainLabel,
              style: const TextStyle(
                fontSize: fontSize,
              ),
            ),
            subLabel != null
                ? Text(
                    subLabel!,
                    style: const TextStyle(
                      fontSize: fontSize,
                    ),
                  )
                : const SizedBox(),
          ],
        ),
        const SizedBox(height: 12.0),
        TextFormField(
          controller: controller,
          style: const TextStyle(
            fontSize: fontSize,
          ),
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0XFFd1d1d1), width: 2),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0XFF275492), width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: Colors.red,
                width: 2,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: Colors.red,
                width: 2,
              ),
            ),
            errorStyle: const TextStyle(
              color: Colors.red,
              fontSize: fontSize,
            ),
            contentPadding: const EdgeInsets.all(16.0),
          ),
          validator: (value) {
            if (dataType == DataType.string) {
              if (value == null || value.trim().isEmpty) {
                return errorText;
              }
            } else {
              if (value == null || value.trim().isEmpty || double.tryParse(value.trim()) == null) {
                return errorText;
              }
            }

            if (specialValidator != null) {
              return specialValidator!();
            } else {
              return null;
            }
          },
        ),
      ],
    );
  }
}
