import 'package:flutter/material.dart';

class ExpensesChartBar extends StatelessWidget {
  final String label;
  final double spentAmount;
  final double spendingPercentageOfTotal;
  ExpensesChartBar({
    @required this.label,
    @required this.spentAmount,
    @required this.spendingPercentageOfTotal,
  });
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: [
            Container(
              height:
                  MediaQuery.of(context).orientation == Orientation.landscape
                      ? constraints.maxHeight * 0.15
                      : constraints.maxHeight * 0.11,
              child: FittedBox(
                child: Text(
                  '\$${spentAmount.toStringAsFixed(0)}',
                ),
              ),
            ),
            SizedBox(
              height: constraints.maxHeight * 0.05,
            ),
            Container(
              height: constraints.maxHeight * 0.6,
              width: 10.0,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1.0),
                      color: Color.fromRGBO(220, 220, 220, 1),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                  ),
                  FractionallySizedBox(
                    heightFactor: spendingPercentageOfTotal,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: constraints.maxHeight * 0.05),
            Container(
              height: constraints.maxHeight * 0.15,
              child: FittedBox(
                child: Text(
                  label,
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
