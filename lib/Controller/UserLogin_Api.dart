// import 'dart:convert';

// import 'package:http/http.dart' as http;
// import 'package:mentegoz_technologies/Modal/User_Model.dart';


//    var idUrl = 'https://antes.meduco.in/api/applogin';
//    Future<List>   get_profile_data(email,password) async {
     
    
//     // final response = await dio.post(apiUrl, data: data, options: options);
//     final res = await http.post(Uri.parse(idUrl,),body:  {
//       'email': email,
//       'password': password,
//     },  headers: {
//         "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8",
//       },);
//     try {
//       if (res.statusCode == 200) {
//         List pro = json.decode(res.body);

//         return pro.map((e) => User_Lgin_Data.fromJson(e)).toList();
//       } else {
//         return [];
//       }
//     } catch (e) {
//       return [];
//     }
//   }

