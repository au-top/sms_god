abstract class ApiStateCode {
  /// 所有正确的请求都返回 2000
  static const ok = 2000;

  /// 常规错误
  static const generalError = 4000;

  /// 注册手机号已经被使用
  static const signUpErrorPhoneNumberIsExis = 4001;

  /// 手机号不合规
  static const errorPhoneNumberUnlawful = 4002;

  /// 登陆时密码错误
  static const loginPasswdError = 4003;

  /// 过于类似 404 故保留状态码 不使用
  static const NOCODE = 4004;

  /// 账号不存在
  static const userNonExis = 4005;

  /// 已经登录账号
  static const alreadyLoginUser = 4006;

  /// 邮箱验证码错误 Email TestCode Error
  static const emailTestCodeError = 4007;

  /// 邮箱验证码不存在
  static const emailTestCodeIsNotExis = 4008;

  /// 邮箱验证码过期
  static const emailTestCodeTimeOut = 4009;

  /// 邮箱已经被注册
  static const signUpErrorEmailIsExis = 4010;

  /// 账号没有登入
  static const notSignIn = 4011;

  /// 参数类型验证失败
  static const parameterTypeTestError = 4012;

  /// 参数检测错误
  static const parameterTestError = 4013;

  /// message target 不存在
  static const messageTargetNoExis = 4014;

  /// UUID (GROUP OR USER) 不存在
  static const uuidIsNotExis = 4015;

  /// [code] is [ApiStateCode] value
  static getApiStateCodeDescribe(int code) {
    return _apiStateCodeDescribe[code] ?? "API无描述";
  }
}

/// 本地 API Code 描述
final _apiStateCodeDescribe = <int, String>{
  ApiStateCode.signUpErrorPhoneNumberIsExis: "该手机号已经被注册使用",
  ApiStateCode.alreadyLoginUser: "亲,该账号已经登录",
  ApiStateCode.emailTestCodeError: "亲,验证码错误了",
  ApiStateCode.notSignIn: "亲,账号没有被登录或失效"
};

class HttpPackage<T> {
  late int code;
  T? data;
  late String describe;

  HttpPackage({required this.data, required this.code, required this.describe});

  HttpPackage.fromMap(dynamic o) {
    final _o = Map<String, dynamic>.from(o);
    code = _o["code"];
    data = _o["data"];
    describe = _o["describe"];
  }

  HttpPackage<E> copyWith<E>({int? code, required E data, String? describe}) {
    return HttpPackage(
      code: code ?? this.code,
      data: data,
      describe: describe ?? this.describe,
    );
  }

  void printLog([String? name]) {
    if (name != null) {
      // ignore: avoid_print
      print("$name>>> ");
    }
    // ignore: avoid_print
    print("\tcode: $code \n\tdata: $data \n\tdescribe: $describe ");
  }

  bool isOk() {
    return code == ApiStateCode.ok;
  }
}
