import 'package:expenses_app/models/transaction.dart';
import 'package:expenses_app/widgets/chart.dart';
import 'package:expenses_app/widgets/new_transaction.dart';
import 'package:expenses_app/widgets/transaction_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //     [
  //       DeviceOrientation.portraitUp,
  //       DeviceOrientation.portraitDown
  //     ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.amber,
          fontFamily: 'Quicksand',
          textTheme: ThemeData.light().textTheme.copyWith(
                labelSmall: TextStyle(color: Colors.white),
                titleMedium: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
                titleSmall: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 14,
                    fontWeight: FontWeight.normal),
                titleLarge: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 25,
                    fontWeight: FontWeight.normal),
              ),
          appBarTheme: AppBarTheme(
              titleTextStyle: const TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                  fontWeight: FontWeight.bold)
              // textTheme: ThemeData.light().textTheme.copyWith(           // old flutter
              //   titleSmall: const TextStyle(
              //     fontFamily: 'OpenSans',
              //     fontSize: 20,
              //     fontWeight: FontWeight.bold
              //   ))
              )),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransaction = [];

  bool _showChart = false;

  List<Transaction> get _recentTransactions {
    return _userTransaction
        .where(
            (tx) => tx.date.isAfter(DateTime.now().subtract(Duration(days: 7))))
        .toList();
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return NewTransaction(_addNewTransaction);
        });
  }

  void _addNewTransaction(String title, double amount, DateTime date) {
    setState(() {
      _userTransaction.insert(
          0,
          Transaction(
              id: DateTime.now().toString(),
              title: title,
              amount: amount,
              date: date));
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransaction.removeWhere((tx) => tx.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: const Text('Personal Expenses'),
      actions: [
        IconButton(
            onPressed: () => _startAddNewTransaction(context),
            icon: Icon(Icons.add))
      ],
    );

    final curScaleFactor = MediaQuery.of(context).textScaleFactor;
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    final _txListWidget = Container(
        height: (MediaQuery.of(context).size.height -
                appBar.preferredSize.height -
                MediaQuery.of(context).padding.top) *
            0.7,
        child: TransactionList(_recentTransactions, _deleteTransaction));

    final _txChart = Container(
        height: (MediaQuery.of(context).size.height -
                appBar.preferredSize.height -
                MediaQuery.of(context).padding.top) *
            (isLandscape ? 0.7 : 0.3),
        width: double.infinity,
        child: Chart(_userTransaction));
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Text("data", style: TextStyle(fontSize: 20 * curScaleFactor),), // Using user phone settings to change text size.
            if (isLandscape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Show Chart'),
                  Switch(
                      value: _showChart,
                      onChanged: (isOn) {
                        setState(() {
                          _showChart = isOn;
                        });
                      })
                ],
              ),
            if (isLandscape) _showChart ? _txChart : _txListWidget,

            if (!isLandscape)
                ...[_txChart,
                _txListWidget,]
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
          onPressed: () => _startAddNewTransaction(context),
          child: Icon(Icons.add)),
    );
  }
}
