import 'package:flutter/material.dart';

class DropDownField extends StatelessWidget {
  final String? labelText;
  final String? value;
  final List<String>? items;
  final Function(String?)? onChanged;

  const DropDownField({this.labelText, this.value, this.items, this.onChanged});
  @override
  Widget build(BuildContext context) {
    double longestSide = MediaQuery.of(context).size.longestSide;
    bool landscape = MediaQuery.of(context).size.aspectRatio > 1.5;

    double labelSize = landscape ? longestSide * 0.015 : longestSide * 0.03;
    return Container(
        child: Container(
      child: DropdownButtonFormField<String>(
        isExpanded: true,
        decoration: InputDecoration(
            labelText: labelText,
            labelStyle: TextStyle(fontSize: labelSize),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blueGrey),
              borderRadius: const BorderRadius.all(
                const Radius.circular(10.0),
              ),
            )),
        value: value,
        items: items!.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: new SizedBox(
              // width: screenWidth-80,
              child: Text(value,
                  style: TextStyle(fontSize: labelSize),
                  overflow: TextOverflow.ellipsis),
            ),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    ));
  }
}
