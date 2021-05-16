// IRegisterResult is data interface of result when you register something
class IRegisterResultData {
  final bool isPasses;
  final String registerId;
  Map<String, dynamic>? others;

  IRegisterResultData({
    required this.isPasses,
    required this.registerId,
    this.others,
  });
}