import 'package:flutter/material.dart';

class DropDownField extends StatelessWidget {
  final String labelText;
  final String value;
  final List<String> items;
  final Function(String?) onChanged;

  const DropDownField({
    Key? key,
    required this.labelText,
    required this.value,
    required this.items,
    required this.onChanged,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double labelSize = MediaQuery.of(context).size.width * 0.015;
    return Container(
        child: Container(
      child: DropdownButtonFormField<String>(
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
        items: items.map<DropdownMenuItem<String>>((String value) {
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
