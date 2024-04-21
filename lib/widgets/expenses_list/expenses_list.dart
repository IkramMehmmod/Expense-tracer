import 'package:app3/Models/expense.dart';
import 'package:app3/widgets/expenses_list/expenses_items.dart';

import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList(
      {super.key, required this.expenses, required this.onRemovedExpense});
  final void Function(Expense expense) onRemovedExpense;
  final List<Expense> expenses;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      //Dismissible is used to Delete the Expense by moving
      // then in to left or Right direction it requied to store the
      //Index of the Expense that is deleted so that is used
      //if the User want to undo the Expense to place it in it correct possion
      itemBuilder: (ctx, index) => Dismissible(
        key: ValueKey(ExpenseItems(expenses[index])),
        background: Container(
          color: Theme.of(context).colorScheme.error.withOpacity(0.18),
          margin: EdgeInsets.symmetric(
              horizontal: Theme.of(context).cardTheme.margin!.horizontal),
        ),
        onDismissed: (direction) {
          onRemovedExpense(
            expenses[index],
          );
        },
        child: (ExpenseItems(expenses[index])),
      ),
    );
  }
}
