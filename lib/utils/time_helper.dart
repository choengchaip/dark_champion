class TimeHelper {
  TimeHelper._();

  static Future<void> sleep({milliseconds: 500}) {
    return Future.delayed(Duration(milliseconds: milliseconds), () {});
  }
}
