import 'package:flutter/material.dart';

class ButtonPad extends StatelessWidget {
  final void Function(String) onPressed;
  const ButtonPad({super.key, required this.onPressed});

  static const buttons = [
    // Row 1
    'sin', 'cos', 'tan', 'DEL',
    // Row 2
    '(', ')', '^', '/',
    // Row 3
    '7', '8', '9', '*',
    // Row 4
    '4', '5', '6', '-',
    // Row 5
    '1', '2', '3', '+',
    // Row 6
    '0', '.', 'C', '=',
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final itemWidth =
            (constraints.maxWidth - 24) / 4; // Account for spacing
        return GridView.count(
          crossAxisCount: 4,
          shrinkWrap: true,
          childAspectRatio: 1.1,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          physics: const NeverScrollableScrollPhysics(),
          children: buttons.map((label) {
            final isOperator = ['+', '-', '*', '/', '=', '^'].contains(label);
            final isClear = label == 'C' || label == 'DEL';
            final isFunction = ['sin', 'cos', 'tan'].contains(label);

            return SizedBox(
              width: itemWidth,
              height: itemWidth,
              child: Material(
                color: isOperator
                    ? Theme.of(context).colorScheme.primary
                    : isClear
                        ? Colors.red.shade400
                        : isFunction
                            ? Colors.orange.shade300
                            : Theme.of(context).cardColor,
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(itemWidth / 2),
                ),
                clipBehavior: Clip.antiAlias,
                child: InkWell(
                  onTap: () => onPressed(label),
                  child: Center(
                    child: Text(
                      label,
                      style: TextStyle(
                        fontSize: isFunction ? 18 : 24,
                        fontWeight: FontWeight.bold,
                        color: isOperator || isClear || isFunction
                            ? Colors.white
                            : Theme.of(context).textTheme.bodyLarge?.color,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
