import 'package:expenses_app/widgets/adaptive_flat_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function _addHandler;

  const NewTransaction(this._addHandler);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  void _submitData() {
    final enteredTitle = _titleController.text;
    final enteredAmount = double.tryParse(_amountController.text);

    if (enteredTitle.isNotEmpty && enteredAmount != null && enteredAmount > 0 && _selectedDate != null) {
      widget._addHandler(enteredTitle, enteredAmount, _selectedDate);
      Navigator.of(context).pop();
    }
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      } else {
        setState(
          () => _selectedDate = pickedDate,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
            left: 10,
            right: 10,
          ),
          child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            TextField(
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(labelText: 'Title'),
              controller: _titleController,
              onSubmitted: (_) => _submitData(),
            ),
            TextField(
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(labelText: 'Amount'),
              keyboardType: TextInputType.number,
              controller: _amountController,
              onSubmitted: (_) => _submitData(),
            ),
            SizedBox(
              height: 70,
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Text(
                          _selectedDate == null ? 'No Date Chosen!' : 'Picked Date: ${DateFormat('dd/MM/yyyy').format(_selectedDate)}'
                          ),
                      ],
                    )
                    ),
                  AdaptiveFlatButton('Choose Date', _presentDatePicker)
                ],
              ),
            ),
            RaisedButton(
              onPressed: _submitData,
              textColor: Theme.of(context).textTheme.labelSmall.color,
              color: Theme.of(context).primaryColor,
              child: const Text('Add Transaction'),
            )
          ]),
        ),
      ),
    );
  }
}
