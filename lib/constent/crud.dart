import 'package:http/http.dart' as http;
import 'dart:convert'; //عشان نحول من جيسون لدارت

class Crud {
  getRequest(String url) async {
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        //اذا صار الاتصال بمعنى الصفحه موجوده
        var responsebody = jsonDecode(
            response.body); //نستقبل محتوى الريسبونس بيكون جيسون ونحوله لدارت
        return responsebody;
      } else {
        print("Erorr ${response.statusCode}");
      }
    } catch (e) {
      print("Error ${e}");
    }
  }

  postRequest(String url, Map data, Map<String, String>? head) async {
    try {
      var response = await http.post(Uri.parse(url),
          body: data, headers: {}); //الداتا هي الحقول مثل يوزر وايميل والباس
      if (response.statusCode == 200) {
        //اذا صار الاتصال بمعنى الصفحه موجوده
        var responsebody = jsonDecode(
            response.body); //نستقبل محتوى الريسبونس بيكون جيسون ونحوله لدارت
        return responsebody;
      } else {
        print("Erorr ${response.statusCode}");
      }
    } catch (e) {
      print("Error ${e}");
    }
  }
}
