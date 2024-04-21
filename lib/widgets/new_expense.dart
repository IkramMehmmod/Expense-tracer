import 'dart:io';

import 'package:app3/Models/expense.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});
  final void Function(Expense expense) onAddExpense;
  @override
  State<NewExpense> createState() {
    return _NewEpenseState();
  }
}

class _NewEpenseState extends State<NewExpense> {
  DateTime? _selectedDate;
  Catagory _selectedCatagory = Catagory.lesisure;
  void _presentDatePicker() async {
    final now = DateTime.now();
    // use to store the Selected dane Entered by the user
    final first = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
        context: context, initialDate: now, firstDate: first, lastDate: now);

    setState(() {
      _selectedDate = pickedDate;
    });
  }
  void _showDialog(){
    if(Platform.isIOS){
showCupertinoDialog(
            context: context,
             builder: (ctx) => CupertinoAlertDialog(
               title: const Text('Invalid Input '),
          content: const Text(
              'please make sure valid title, amount, date, and catagory was entered'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('Okey'),
            ),
          ],
             )
          );
    }
     else{
      showDialog(
        context:
            context, // this context is important for all the widets becuse it carries the mata data about the widgets and the relationships of these widgets
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid Input '),
          content: const Text(
              'please make sure valid title, amount, date, and catagory was entered'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('Okey'),
            ),
          ],
        ),
      );
     }

  }

  void _submintExpenseData() {
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsEnvalid = enteredAmount == null || enteredAmount <= 0;
    if (_titleController.text.trim().isEmpty ||
        amountIsEnvalid ||
        _selectedDate == null) {
          _showDialog();
      return;
    }
    Navigator.pop(context);
    widget.onAddExpense(
      Expense(
          title: _titleController.text,
          amount: enteredAmount,
          date: _selectedDate!,
          catagory: _selectedCatagory),
    );
  }

  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  @override
  // dispose is used to dispose the valus that are manually handles
  // so that the memory gets free as they are rempved
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(builder: (ctx, constraints) {
      final width = constraints.maxWidth;
      return SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, keyboardSpace + 16),
            child: Column(
              children: [
                if (width >= 600)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _titleController,
                          maxLength: 50,
                          decoration: const InputDecoration(
                            label: Text('Title'),
                          ),
                        ),
                      ),
                      const SizedBox(width: 24),
                      Expanded(
                        child: TextField(
                          controller: _amountController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            prefixText: '\$',
                            label: Text('Amount'),
                          ),
                        ),
                      ),
                    ],
                  )
                else
                  // thses two text fienlds are used to enter the user inputs
                  TextField(
                    controller: _titleController,
                    maxLength: 50,
                    decoration: const InputDecoration(
                      label: Text('Title'),
                    ),
                  ),
                if (width >= 600)
                  Row(children: [
                    DropdownButton(
                      value: _selectedCatagory,
                      items: Catagory.values
                          .map(
                            (catagory) => DropdownMenuItem(
                              value: catagory,
                              child: Text(
                                catagory.name.toUpperCase(),
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        if (value == null) {
                          return;
                        }
                        setState(
                          () {
                            _selectedCatagory = value;
                          },
                        );
                      },
                    ),
                    const SizedBox(width: 24),
                    Expanded(
                      //that is used to handle and disply the date canlander
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(_selectedDate == null
                              ? "No date selected "
                              : formater.format(_selectedDate!)),
                          IconButton(
                              onPressed: _presentDatePicker,
                              icon: const Icon(Icons.calendar_month))
                        ],
                      ),
                    ),
                  ])
                else
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _amountController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            prefixText: '\$',
                            label: Text('Amount'),
                          ),
                        ),
                      ),
                      Expanded(
                        //that is used to handle and disply the date canlander
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(_selectedDate == null
                                ? "No date selected "
                                : formater.format(_selectedDate!)),
                            IconButton(
                                onPressed: _presentDatePicker,
                                icon: const Icon(Icons.calendar_month))
                          ],
                        ),
                      )
                    ],
                  ),
                const SizedBox(
                  // its is uesd for spacing between the amount and the scrollalbe dropDownButton
                  height: 16,

                ),
                if(width>=600)
                Row(children: [
                  const Spacer(),
                    // these two buttons that are used when the user save or cancel the expense
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Cancel'),
                    ),
                    ElevatedButton(
                      onPressed: _submintExpenseData,
                      child: const Text('Save Expense'),
                    ),
                ],)
                else
                Row(
                  //when the new expense is add it will display the list of the category using dropdown in uper case
                  children: [
                    DropdownButton(
                      value: _selectedCatagory,
                      items: Catagory.values
                          .map(
                            (catagory) => DropdownMenuItem(
                              value: catagory,
                              child: Text(
                                catagory.name.toUpperCase(),
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        if (value == null) {
                          return;
                        }
                        setState(
                          () {
                            _selectedCatagory = value;
                          },
                        );
                      },
                    ),
                    const Spacer(),
                    // these two buttons that are used when the user save or cancel the expense
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Cancel'),
                    ),
                    ElevatedButton(
                      onPressed: _submintExpenseData,
                      child: const Text('Save Expense'),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
