class MySingleton {
  static final MySingleton _singleton = MySingleton._internal();
  String userId = "";
  String deviceToken = "";
  String userLang = "English";
  factory MySingleton() {
    return _singleton;
  }
  MySingleton._internal();
  static MySingleton get shared => _singleton;
}
