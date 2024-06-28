import 'package:flutter/material.dart';

class PriceSlider extends StatelessWidget {
  final String label;
  final TextEditingController min;
  final TextEditingController max;

  PriceSlider({
    required this.label,
    required this.min,
    required this.max,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Color.fromARGB(255, 255, 255, 255),
            fontSize: 12,
            fontWeight: FontWeight.w300,
          ),
        ),
        Row(
          children: [
            Expanded(
              child: buildValueInput("min", min),
            ),
            SizedBox(width: 10),
            Expanded(
              child: buildValueInput("max", max),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildValueInput(String label, TextEditingController controller) {
    String formatValue(String value) {
      if (value.isEmpty) return value;
      final intValue = int.tryParse(value.replaceAll('.', ''));
      if (intValue == null) return value;
      return intValue.toString().replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (match) => '.');
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: Colors.white,
            hintText: label,
            hintStyle: TextStyle(fontSize: 12, color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.7)),
            contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            isDense: true,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide.none,
            ),
          ),
          keyboardType: TextInputType.number,
          onChanged: (value) {
            final formattedValue = formatValue(value);
            controller.value = TextEditingValue(
              text: formattedValue,
              selection: TextSelection.collapsed(offset: formattedValue.length),
            );
          },
          controller: controller,
          style: TextStyle(fontSize: 14),
        ),
      ],
    );
  }
}
