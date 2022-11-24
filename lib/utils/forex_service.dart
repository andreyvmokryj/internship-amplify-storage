import 'dart:convert';
import 'package:http/http.dart' as http;

import 'date_helper.dart';

class ForexService{
  String apiBase = "https://bank.gov.ua/NBU_Exchange/exchange?json&";

  Future<Map> getExchangeRates(String mainCurrencyCode, DateTime dateTime) async {
    Map<String, double> map = {};
    String dateString = DateHelper().dateToNbuString(dateTime);
    var response = await http.get(Uri.parse(apiBase + "date=$dateString"));
    if(response.statusCode == 200) {
      List responseBody = json.decode(response.body);
      map["UAH"] = 1;
      responseBody.forEach((element) {
        String key = element["CurrencyCodeL"];
        double value = element["Amount"];
        map[key] = value;
      });

      double priceInUAH = map[mainCurrencyCode]!;
      map.forEach((key, value) {
        map[key] = value / priceInUAH;
      });
    }
    print("");
    return map;
  }
}