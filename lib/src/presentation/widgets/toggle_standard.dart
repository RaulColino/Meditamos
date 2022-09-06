import 'package:flutter/material.dart';
import 'package:meditamos/src/presentation/utils/theme/meditamos_colors.dart';

class ToggleStandard extends StatefulWidget {
  final String leftValue;
  final String rightValue;
  final ValueChanged onToggleCallback;
  final bool isLeft;

  const ToggleStandard({
    Key? key,
    required this.leftValue,
    required this.rightValue,
    required this.onToggleCallback,
    required this.isLeft,
  }) : super(key: key);

  @override
  _ToggleStandardState createState() => _ToggleStandardState();
}

class _ToggleStandardState extends State<ToggleStandard> {
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    final String toggleSelectedText =
        widget.isLeft ? widget.leftValue : widget.rightValue;
    double toggleWidth = width * 0.85;
    double toggleHeight = height * .053;
    double toggleBorderRadius = width * .018;
    return SizedBox(
      width: toggleWidth,
      height: toggleHeight,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              widget.onToggleCallback(1);
            },
            child: Expanded(
              child: Container(
                decoration: ShapeDecoration(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.07),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(toggleBorderRadius),
                  ),
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: toggleWidth * 0.5,
                        child: Center(
                          child: Text(
                            widget.isLeft ? "" : widget.leftValue,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Theme.of(context).hintColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: toggleWidth * 0.5,
                        child: Center(
                          child: Text(
                            widget.isLeft ? widget.rightValue : "",
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Theme.of(context).hintColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ]),
              ),
            ),
          ),
          AnimatedAlign(
            alignment:
                widget.isLeft ? Alignment.centerLeft : Alignment.centerRight,
            duration: Duration(milliseconds: 200),
            curve: Curves.ease,
            child: Tooltip(
              message: toggleSelectedText,
              child: Container(
                alignment: Alignment.center,
                width: toggleWidth * 0.5,
                height: toggleHeight,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  boxShadow: [
                    // BoxShadow(
                    //   offset: Offset(0, 4),
                    //   blurRadius: 19,
                    //   color: Theme.of(context).shadowColor.withOpacity(0.2),
                    // ),
                  ],
                  borderRadius: BorderRadius.circular(toggleBorderRadius),
                  border: Border.all(
                      color: Theme.of(context).colorScheme.outline, width: 2),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    toggleSelectedText,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Theme.of(context).hintColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
