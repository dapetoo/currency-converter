import 'package:currency_converter/components/app_bar.dart';
import 'package:currency_converter/components/bottom_row.dart';
import 'package:currency_converter/constants/theme_store.dart';
import 'package:currency_converter/services/api_services.dart';
import 'package:flutter/material.dart';
import 'package:currency_converter/components/build_container.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> currencySymbol = [];
  String fromCurrencySymbol = 'USD';
  String toCurrencySymbol = 'AUD';
  ApiServices _apiServices = ApiServices();

  double amount;
  String from;
  String to;

  TextEditingController amountController = TextEditingController();
  TextEditingController responseController = TextEditingController();

  @override
  void initState() {
    super.initState();
    //getSymbol();
    getCurrency();
  }

  //ThemeStore themeStore;

  void getSymbol() {
    try {
      _apiServices.getCurrencySymbols().then((List<String> currencies) {
        setState(() {
          currencySymbol = currencies;
          //print('Currency Symbols are: ' + currencySymbol.toString());
        });
      });
    } catch (e) {
      print(e.toString());
    }
  }

  void getCurrency() {
    try {
      _apiServices.getCurrency().then((List<String> currencies) {
        setState(() {
          currencySymbol = currencies;
          //print('Currencies are' + currencySymbol.toString());
        });
      });
    } catch (e) {
      print(e.toString());
    }
  }

  DropdownButton<String> fromCurrencyDropDownButton() {
    return DropdownButton<String>(
      hint: Text(fromCurrencySymbol),
      icon: Icon(Icons.arrow_drop_down),
      items: currencySymbol
          .map<DropdownMenuItem<String>>(
            (currencySymbol) => (DropdownMenuItem(
              child: Text(currencySymbol.toString()),
              value: currencySymbol,
            )),
          )
          .toList(),
      onChanged: (value) {
        setState(() {
          fromCurrencySymbol = value;
          from = value;
          print('The value from the fromCurrencyDropdown is ' + value);
        });
      },
      value: fromCurrencySymbol,
    );
  }

  DropdownButton<String> toCurrencyDropDownButton() {
    return DropdownButton<String>(
      hint: Text(toCurrencySymbol),
      value: toCurrencySymbol,
      icon: Icon(Icons.arrow_drop_down),
      items: currencySymbol
          .map<DropdownMenuItem<String>>(
            (currencySymbol) => (DropdownMenuItem(
              child: Text(currencySymbol.toString()),
              value: currencySymbol,
            )),
          )
          .toList(),
      onChanged: (value) {
        setState(() {
          toCurrencySymbol = value;
          to = value;
          print('The value from the toCurrencyDropdown is ' + value);
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    responseController.text = toCurrencySymbol.toString();
    return SafeArea(
      child: Scaffold(
        drawer: Drawer(
          child: Container(
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 40.0,
                ),
                GestureDetector(
                  child: Text('View Chart'),
                  onTap: () => debugPrint('Gesture Detected'),
                ),
                SizedBox(
                  height: 20,
                ),
                InkWell(child: Text('Documentation')),
                SizedBox(
                  height: 20,
                ),
                Text('Sign Up'),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  child: Text('Change App Theme'),
                  onTap: () {
                    showDialog(
                      context: context,
                      child: Observer(
                        builder: (_) {
                          final themeStore = context.read<ThemeStore>();
                          return SimpleDialog(
                            title: Text('Change Theme'),
                            children: [
                              ListTile(
                                title: const Text('Light Theme'),
                                leading: Radio(
                                    value: ThemeType.light,
                                    groupValue: themeStore.currentThemeType,
                                    onChanged: (ThemeType value) {
                                      themeStore.changeCurrentTheme(value);
                                      Navigator.pop(context, true);
                                    }),
                              ),
                              ListTile(
                                title: const Text('Dark Theme'),
                                leading: Radio(
                                    value: ThemeType.dark,
                                    groupValue: themeStore.currentThemeType,
                                    onChanged: (ThemeType value) {
                                      themeStore.changeCurrentTheme(value);
                                      Navigator.pop(context, true);
                                    }),
                              ),
                            ],
                          );
                        },
                      ),
                    ).then((value) => Navigator.pop(context));
                  },
                ),
              ],
            ),
          ),
        ),
        body: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBar(),
              SizedBox(),
              Image.asset(
                'assets/images/home_icon.png',
                width: 180,
              ),
              Column(
                children: [
                  TextField(
                    onChanged: (String value) {
                      setState(() {
                        amount = double.parse(value);
                      });
                    },
                    controller: amountController,
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    style: TextStyle(
                        color: Color(0xFF000000), fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(20),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        filled: true,
                        fillColor: Colors.grey.shade200,
                        hintText: 'Enter amount',
                        hintStyle: TextStyle(color: Colors.grey),
                        suffixText: fromCurrencySymbol),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextField(
                    controller: responseController,
                    enabled: false,
                    style: TextStyle(
                      color: Color(0xFF000000),
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(20),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        filled: true,
                        fillColor: Colors.grey.shade200,
                        hintText: '0.0',
                        suffixText: toCurrencySymbol),
                  ),
                  //Text(result.toString()),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ReusableContainer(
                        cardChild: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(
                          Icons.fiber_manual_record,
                          color: Colors.red,
                        ),
                        fromCurrencyDropDownButton(),
                      ],
                    )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Icon(
                      Icons.swap_horiz,
                      color: Colors.grey.shade400,
                      size: 40,
                    ),
                  ),
                  Expanded(
                    child: ReusableContainer(
                        cardChild: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(
                          Icons.fiber_manual_record,
                          color: Colors.green,
                        ),
                        toCurrencyDropDownButton(),
                      ],
                    )),
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(),
                height: 50,
                width: double.infinity,
                child: RaisedButton(
                  color: Color(0xFF23DEA6),
                  onPressed: () async {
                    double result = await _apiServices.currencyConversion(
                        amount: amount, from: from, to: to);
                    responseController.text = result.toString();
                    print('The new value is ' + result.toString());
                    print('$amount, $from, $to');
                    print(result);
                  },
                  child: Text(
                    'Convert',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
              ),
              buildBottomRow()
            ],
          ),
        ),
      ),
    );
  }

  Row buildBottomRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Mid-market exchange rate at ',
          style: TextStyle(
            fontSize: 10,
            decoration: TextDecoration.underline,
            color: Colors.blue,
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Icon(
          Icons.error,
          color: Colors.grey,
        )
      ],
    );
  }
}
