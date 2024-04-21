import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

const uuid = Uuid();
final formater = DateFormat.yMd();

enum Catagory { food, lesisure, work, travel }
const catagoryIcons = {
  Catagory.food: Icons.lunch_dining,
  Catagory.travel: Icons.flight_takeoff,
  Catagory.lesisure: Icons.movie,
  Catagory.work: Icons.work,
};

class Expense {
  Expense(
      {required this.title,
      required this.amount,
      required this.date,
      required this.catagory})
      : id = uuid.v4();
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Catagory catagory;

  String get formattedDate {
    return formater.format(date);
  }
}
// this class is used for the chart to show the total amount of expesnes in over project
class ExpenseBucket{

  const ExpenseBucket ({required this.expenses, required this.catagory});
  // this is a alternative construture function that will me use to create the diffrent buckets that are represented in over chart bar
   ExpenseBucket.forCatagory(List<Expense> allexpesnse, this.catagory)
    : expenses = allexpesnse.where((expense) => expense.catagory == catagory).toList();
   final List<Expense> expenses;
   final Catagory catagory;
   
  

   double get totalExpenses{
    double sum = 0;
     for(var expense in expenses){
      sum += expense.amount;
     }
     return sum;
   }
}
