// import 'package:expense_trcker/model/transaction.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// class CustomTransactionList extends StatelessWidget {
//   final List<Transaction> _transactionList;
//   CustomTransactionList(this._transactionList);
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: _transactionList.map((tx) {
//         return Card(
//           child: Row(
//             children: [
//               Container(
//                 padding: EdgeInsets.all(10.0),
//                 decoration: BoxDecoration(
//                     border: Border.all(
//                       color: Colors.purple,
//                       width: 2.0,
//                     )),
//                 margin: EdgeInsets.symmetric(
//                   vertical: 10.0,
//                   horizontal: 20.0,
//                 ),
//                 child: Text(
//                   '\$${tx.price}',
//                   style: TextStyle(
//                     color: Colors.purple,
//                     fontSize: 20.0,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     tx.title,
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 16.0,
//                     ),
//                   ),
//                   SizedBox(
//                     height: 4.0,
//                   ),
//                   Text(
//                     " ${tx.time.month} \\ ${tx.time.day}  \\ ${tx.time.year}  ",
//                     style: TextStyle(
//                       fontWeight: FontWeight.w300,
//                       fontSize: 13.0,
//                       color: Colors.grey,
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         );
//       }).toList(),
//     );
//   }
// }
