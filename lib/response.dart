class BaseResponse {
  factory BaseResponse.create(String method, Map args) {
    if (method == 'onAuthResp') {
      return AuthResponse(args['authCode'], args['error'], args['state']);
    } else {
      return BaseResponse();
    }
  }

  BaseResponse();
}

class AuthResponse extends BaseResponse {
  final String authCode;
  final String error;
  final String state;

  AuthResponse(this.authCode, this.error, this.state);
}
