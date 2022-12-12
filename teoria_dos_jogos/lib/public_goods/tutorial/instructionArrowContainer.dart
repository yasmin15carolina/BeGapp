import 'package:flutter/material.dart';
import 'package:teoria_dos_jogos/classes/resize.dart';

class InstructionArrow extends StatelessWidget {
  final String instructiontxt;
  final double top;
  final double left;
  final double right;
  final double bottom;
  final bool column;
  final IconData? icon;
  final double? width;
  final Alignment? alignment;

  InstructionArrow(this.instructiontxt, this.column, this.icon,
      {required this.top,
      required this.left,
      required this.right,
      required this.bottom,
      this.width,
      this.alignment});
  @override
  Widget build(BuildContext context) {
    double screenHeight = Resize.getHeight(context);
    double screenWidth = Resize.getWidth(context);
    double fontsize = screenHeight / 25;
    // var appLanguage = Provider.of<AppLanguage>(context);
    // appLanguage.changeLanguage(Locale("pt"));
    return Container(
      alignment: alignment,
      padding: EdgeInsets.fromLTRB(left, top, right, bottom),
      child: (column)
          ? Column(children: [
              if (icon == Icons.arrow_back || icon == Icons.arrow_upward)
                Icon(
                  icon,
                  color: Colors.red.withOpacity(0.7),
                  size: fontsize * 4,
                ),
              Container(
                width: (width == null) ? screenWidth / 1.9 : width,
                //padding: EdgeInsets.all(5),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  color: Colors.red.withOpacity(0.8),
                ),
                child: Text(
                  instructiontxt,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: fontsize * 1.7,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              if (!(icon == Icons.arrow_back || icon == Icons.arrow_upward))
                Icon(
                  icon,
                  color: Colors.red.withOpacity(0.7),
                  size: fontsize * 4,
                ),
            ])
          : Row(children: [
              if (icon == Icons.arrow_back || icon == Icons.arrow_upward)
                Icon(
                  icon,
                  color: Colors.red.withOpacity(0.7),
                  size: fontsize * 4,
                ),
              Container(
                width: (width == null) ? screenHeight / 1.9 : width,
                //padding: EdgeInsets.all(5),
                //alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  color: Colors.red.withOpacity(0.8),
                ),
                padding: EdgeInsets.all(5),
                child: Text(
                  instructiontxt,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: fontsize * 1.7,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              if (!(icon == Icons.arrow_back || icon == Icons.arrow_upward))
                Icon(
                  icon,
                  color: Colors.red.withOpacity(0.7),
                  size: fontsize * 4,
                ),
            ]),
    );
  }
}
