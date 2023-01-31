class Config {
  static const String mainUrl = "http://192.168.1.64:5000";
  static const String loginUrl = "$mainUrl/api/users/login";
  static const String fileUploadUrl = "$mainUrl/api/upload";
  static const String registerUrl = "$mainUrl/api/users/register";
  static const String getConvoUrl = "$mainUrl/api/convos/get";
  static const String getUserUrl = "$mainUrl/api/users/getuser";
  static const String getMessages = "$mainUrl/api/messages/fetch";
  static const String sendMessUrl = "$mainUrl/api/messages/send";
  static const String getUserFrndUrl = "$mainUrl/api/users/getFriendList";
  static const String getUserReqUrl = "$mainUrl/api/users/getRequestList";
  static const String acceptReqUrl = "$mainUrl/api/users/accept";
  static const String sendReqUrl = "$mainUrl/api/users/add";
  static const String getCheckConvoUrl = "$mainUrl/api/convos/check";
  static const String createChatUrl = "$mainUrl/api/convos/create";
  static const String getTargetUrl = "$mainUrl/api/convos/getTarget";
  static const String searchUserUrl = "$mainUrl/api/users/search";
}
