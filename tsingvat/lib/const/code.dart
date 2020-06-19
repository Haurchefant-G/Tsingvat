class ResultCode {
  static const int SUCCESS = 10;

  // 每个dao对应一个范围内的error_code
  static const int ACCOUNT_NOT_FOUND = 21;
  static const int ACCOUNT_ALREADY_EXISTS = 22;
  static const int LOGIN_FAIL = 23;
  static const int REGISTER_FAIL = 24;

  static const int ERRAND_TAKE_FAIL = 41;

  static const int REPLY_NOT_FOUND = 16;
}