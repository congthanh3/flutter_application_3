import 'dart:convert';

class ParseUtils {
  const ParseUtils._();
  //function truyền 1 string vào và trả lại 1 map
  static Map<String, dynamic>? parseStringToMap(String? payload) {
    if (payload == null) {
      return null;
    }
    try {
      return jsonDecode(payload);
    } catch (error) {
      return null;
    }
  }
}
