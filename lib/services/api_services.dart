import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiServices {
  static const BASE_URL = 'https://api.exchangeratesapi.io/latest?symbols';

  Future<List<String>> getCurrencySymbols() async {
    List<String> currencySymbols = [];
    http.Response response = await http.get(BASE_URL);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      // we want to look through all the keys in the 'rates' JSONObject
      // this line picks our the 'rates'object we want
      var rates = jsonResponse['rates'];
      for (var symbol in rates.keys) {
        //print(symbol);
        // add the symbol to the list
        currencySymbols.add(symbol);
      }
    } else {
      // The API experienced an error
      print(response.reasonPhrase);
    }
    return currencySymbols;
  }

  static const URL = 'https://api.frankfurter.app';
  Future<List<String>> getCurrency() async {
    List<String> currency = [];
    //Base URL + currency endpoint
    http.Response response = await http.get('$URL/currencies');
    if(response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      print(jsonResponse.keys);
      //var currency = jsonResponse;
      for(var symbol in jsonResponse.keys){
        //print(symbol);
        currency.add(symbol);
        print(jsonResponse);
      }
      print(jsonResponse);
    } else {
      print(response.reasonPhrase);
    }
    return currency;
  }

  Future<double> currencyConversion({double amount, String from, String to}) async {
    double conversionResult;
    http.Response response = await http.get('$URL/latest?amount=$amount&from=$from&to=$to');
    if(response.statusCode == 200){
      print('Status code' + response.statusCode.toString());
      var jsonResponse = jsonDecode(response.body);
      var rates = jsonResponse['rates'];
      var date = jsonResponse['date'];
      print('The date is ' +  date.toString());
      print(rates);
      conversionResult = rates[to];
    } else {
      print(response.statusCode);
      print(response.reasonPhrase);
    }
    print(conversionResult);
    return conversionResult;
  }



}
