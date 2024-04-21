

import 'package:app3/Models/expense.dart';
import 'package:flutter/material.dart';


class ExpenseItems extends StatelessWidget {
  const ExpenseItems(this.expense, {super.key});
  final Expense expense;
  @override
  Widget build(BuildContext context) {
    return Card(
      
     child: Padding (  
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(expense.title, 
            style: Theme.of(context).textTheme.titleLarge,),
            
            Row(
              
              children: [
                Text(
                  '\$${expense.amount.toStringAsFixed(2)}',
                ),
                const Spacer(),
                Row(
                  children: [
                     Icon(catagoryIcons[expense.catagory]),
                    const SizedBox(width: 8),
                    Text(expense.formattedDate)
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
