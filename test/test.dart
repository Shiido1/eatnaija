import 'dart:convert';

import 'package:http/http.dart' as http;

void main() {
  print("Hello working");
  updateApi();
  // calculatePayment();
}


// checkapi() async{
//    var response = await http.post(
//                       "https://api.flutterwave.com/v3/subaccounts",
//                       body: json.encode(
//                         {
//                           "account_bank":"044",
//                           "account_number":"0690000037",
//                           "business_name":"Eternal Blue",
//                           "business_email":"petya@stux.net",
//                           "business_contact":"Anonymous",
//                           "business_contact_mobile":"090890382",
//                           "business_mobile":"09087930450",
//                           "country":"NG",
//                           "meta":[{"meta_name":"mem_adr",
//                                   "meta_value":"0x16241F327213"
//                                   }],
//                           "split_type":"percentage",
//                           "split_value":0.5
//                         }
//                       ),
//                       headers: { 
//                         'Content-type': 'application/json',
//                         'Accept': 'application/json',
//                         "Authorization": "Bearer FLWSECK-13ec888e9d9f6fee8c3ca805118e3e1e-X"
//                         },
//                       // encoding: encoding
//                       );
//   print(response.body);
// }


updateApi() async{
     var response = await http.put(
                      "https://api.flutterwave.com/v3/subaccounts/47740",
                      body: json.encode(
                        {
                          "business_name":"Luxe collectibles",
                          "business_email":"mad@o.enterprises",
                          "account_bank":"044",
                          "account_number":"0690000040",
                          "split_type":"flat",
                          "split_value":"200"
                        }
                      ),
                      headers: { 
                        'Content-type': 'application/json',
                        'Accept': 'application/json',
                        "Authorization": "Bearer FLWSECK-13ec888e9d9f6fee8c3ca805118e3e1e-X"
                        },
                      // encoding: encoding
                      );
                      print(response.body);
                      print(response.statusCode);
}