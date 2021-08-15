import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewExpense extends StatefulWidget {
  final addTx;

  NewExpense(this.addTx);

  @override
  _NewExpenseState createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  void _submitData() {
    if (_amountController.text.isEmpty) {
      return;
    }
    final enteredTitle = this._titleController.text;
    final enteredAmount = this._amountController.text;

    if (enteredTitle.isEmpty ||
        enteredAmount.isEmpty ||
        this._selectedDate == null) {
      return;
    }

    widget.addTx(enteredTitle, enteredAmount, this._selectedDate);
    Navigator.of(context).pop();
  }

  void _presendDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime.now())
        .then((date) {
      if (date == null) {
        return;
      } else {
        setState(() {
          this._selectedDate = date;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('New Expense')),
      body: Padding(
        padding: EdgeInsets.fromLTRB(20.0, 2.0, 20.0, 4.0),
        child: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: _titleController,
              onSubmitted: (_) => _submitData(),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: _amountController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              onSubmitted: (_) => _submitData(),
            ),
            Container(
              height: 70,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      _selectedDate == null
                          ? 'No date chosen!'
                          : 'Date: ${DateFormat.yMd().format(_selectedDate)}',
                    ),
                  ),
                  TextButton(
                    child: Text('Pick date',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    onPressed: _presendDatePicker,
                  ),
                ],
              ),
            ),
            ElevatedButton(
              child: Text('ADD'),
              onPressed: _submitData,
            ),
          ],
        ),
      ),
    );
  }
}
