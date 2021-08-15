import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'widgets/expense_list.dart';
import 'widgets/new_expense.dart';
import 'models/expense.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expenses',
      home: MyHomePage(),
      theme: ThemeData(
          primarySwatch: Colors.green,
          accentColor: Colors.black,
          fontFamily: 'Quicksand',
          appBarTheme: AppBarTheme(
              textTheme: ThemeData.light().textTheme.copyWith(
                      headline6: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ))),
          textTheme: ThemeData.light().textTheme.copyWith(
                  headline6: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ))),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Expense> _userExpenses = [
    // Expense(
    //     id: '1',
    //     title: 'Groceries',
    //     amount: '100',
    //     date: DateTime.now().toString()),
    // Expense(
    //     id: '2', title: 'Gas', amount: '500', date: DateTime.now().toString())
  ];

  void _addExpense(String title, String amount, DateTime date) {
    final newTx = Expense(
        id: (this._userExpenses.length + 1),
        title: title,
        amount: double.parse(amount),
        date: date);

    setState(() {
      this._userExpenses.add(newTx);
    });
  }

  void _startAddingExpense(BuildContext context) {
    showCupertinoModalPopup(
        context: context,
        builder: (_) {
          return NewExpense(this._addExpense);
        });
  }

  void _deleteExpense(int id) {
    setState(() {
      this._userExpenses.removeWhere((tx) => tx.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expenses'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _startAddingExpense(context),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ExpenseList(this._userExpenses, this._deleteExpense)
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddingExpense(context),
      ),
    );
  }
}
