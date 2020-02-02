//TODO: Add your imports here.
import 'package:http/http.dart' as http;
import 'dart:convert';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

const cryptocompareURL = 'https://min-api.cryptocompare.com/data/pricemulti';

//https://min-api.cryptocompare.com/data/pricemulti?fsyms=BTC&tsyms=USD

class CoinData {
  //TODO: Create your getCoinData() method here.

  Future getCoinData(String selectedCurrency) async {
    Map<String, String> cryptoPrices = {};

    for (String crypto in cryptoList) {
      String requestURL = '$cryptocompareURL?fsyms=$crypto&tsyms=$selectedCurrency';
      http.Response response = await http.get(requestURL);
      if (response.statusCode == 200) {
        var decodedData = jsonDecode(response.body);
        print(decodedData);
        var lastPrice = decodedData[crypto][selectedCurrency];
        cryptoPrices[crypto] = lastPrice.toStringAsFixed(0);
      } else {
        //10. Handle any errors that occur during the request.
        print(response.statusCode);
        //Optional: throw an error if our request fails.
        throw 'Problem with the get request';
      }
    }

    return cryptoPrices;
  }
}
