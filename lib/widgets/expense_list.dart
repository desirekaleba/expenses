import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/expense.dart';

class ExpenseList extends StatelessWidget {
  final List<Expense> expenses;
  final Function deleteExpense;

  ExpenseList(this.expenses, this.deleteExpense);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 550,
        child: this.expenses.isEmpty
            ? Column(
                children: <Widget>[
                  Text(
                    'No Expenses yet!',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  Container(
                    height: 400,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              )
            : ListView.builder(
                itemBuilder: (ctx, index) {
                  return Card(
                    elevation: 5,
                    margin: EdgeInsets.symmetric(vertical: 12, horizontal: 5),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: FittedBox(
                              child: Text('${expenses[index].amount}')),
                        ),
                      ),
                      title: Text(
                        expenses[index].title,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      subtitle: Text(
                        DateFormat.yMMMd().format(expenses[index].date),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        color: Theme.of(context).errorColor,
                        onPressed: () => deleteExpense(this.expenses[index].id),
                      ),
                    ),
                  );
                },
                itemCount: expenses.length,
              ));
  }
}
