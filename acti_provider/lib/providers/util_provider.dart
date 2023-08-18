import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/widgets.dart';

class UtilProvider extends ChangeNotifier {
  static final UtilProvider rtp = UtilProvider._();
  final storage = const FlutterSecureStorage();
  UtilProvider._();

  static Future responseHTTP({required String urlBase}) async {
    var response = await http.get(Uri.parse(urlBase));
    return response;
  }

  Future checkSession() async {
    Map<String, String> allValues = await storage.readAll();
    if (allValues['inSesion'] == '1') {
      return 1;
    }
    return 0;
  }

  Future saveStorage({
    required String usuario,
    required,
    required String password,
  }) async {
    await storage.write(key: 'Usuario', value: usuario);
    await storage.write(key: 'psw', value: password);
    await storage.write(key: 'inSesion', value: '1');
    return 1;
  }

  Future responseHttp({required String urlBase}) async {
    var response = await http.get(Uri.parse(urlBase));
    return response;
  }
  Future clearSession() async {
    await storage.deleteAll();
  }
}