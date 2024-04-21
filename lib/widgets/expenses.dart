import 'package:app3/widgets/chart/chart.dart';
import 'package:app3/widgets/new_expense.dart';
import 'package:flutter/material.dart';
import 'package:app3/widgets/expenses_list/expenses_list.dart';
import 'package:app3/Models/expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});
  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  //these are the dummy expeses that are display on the screen
  final List<Expense> _registerExpenses = [
    Expense(
        title: 'Flutter Course',
        amount: 19.33,
        date: DateTime.now(),
        catagory: Catagory.work),
    Expense(
        title: 'Cenima',
        amount: 19.33,
        date: DateTime.now(),
        catagory: Catagory.lesisure)
  ];
  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      useSafeArea: true,
        isScrollControlled: true,
        context: context,
        builder: (ctx) => NewExpense(
              onAddExpense: _addExpense,
            ));
  }

  void _addExpense(Expense expense) {
    // This is used to add nw Expesnses
    setState(() {
      _registerExpenses.add(expense);
    });
  }

  void _removedExpense(Expense expense) {
    final expenseIndex = _registerExpenses.indexOf(
        expense); // this variable is used to store the Index of the current expense that is deleted so that if the user undo the expese so it will display on its correct place
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Expense is Deleted'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _registerExpenses.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
    // This is used to remove the Expenses
    setState(() {
      _registerExpenses.remove(expense);
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    //This Widget is used to Display the sms on the screen if no Expense id found on the Screen POr if all the Expenses are deleted by the user
    Widget mainContent = const Center(
      child: Text('No Expense Found. Start Adding New !'),
    );
    if (_registerExpenses.isNotEmpty) {
      // checking that is there is no Expense or the expeses are present on the screen
      mainContent = ExpensesList(
          expenses: _registerExpenses, onRemovedExpense: _removedExpense);
    }
    return Scaffold(
      // by this the appbar is created with the + button that is used to add new expeses
      appBar: AppBar(
        title: const Text('Flutter Expense Tracker'),
        //backgroundColor: const Color.fromARGB(122, 154, 40, 156),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: width < 600
          ? Column(
              children: [
                Chart(expenses: _registerExpenses),
                Expanded(
                  child: mainContent,
                )
              ],
            )
          : Row(
              children: [
                Expanded(
                  child: Chart(expenses: _registerExpenses),
                ),
                Expanded(
                  child: mainContent,
                )
              ],
            ),
    );
  }
}
