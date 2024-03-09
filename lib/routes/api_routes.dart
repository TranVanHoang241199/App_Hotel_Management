class ApiRoutes {
  // ignore: constant_identifier_names
  static const String apiUrl_Base = "http://hotel.somee.com/";

  // ignore: slash_for_doc_comments
  /**
   * Auth
   */
  // ignore: constant_identifier_names
  static const String apiUrl_auth_login = "${apiUrl_Base}api/v1/auth/login";
  // ignore: constant_identifier_names
  static const String apiUrl_auth_register =
      "${apiUrl_Base}api/v1/auth/register";
  // ignore: constant_identifier_names
  static const String apiUrl_auth_ChangePass =
      "${apiUrl_Base}api/v1/auth/change-pass";
  // ignore: constant_identifier_names
  static const String apiUrl_auth_RecoverAcc =
      "${apiUrl_Base}api/v1/auth/recover-account";
  // ignore: constant_identifier_names
  static const String apiUrl_auth_UpdateInfomation =
      "${apiUrl_Base}api/v1/auth/update-information";
  // ignore: constant_identifier_names
  static const String apiUrl_auth_RemoveAcc =
      "${apiUrl_Base}api/v1/auth/remove-account";
  // ignore: constant_identifier_names
  static const String apiUrl_auth_me = "${apiUrl_Base}api/v1/auth/me";
  // ignore: constant_identifier_names
  static const String apiUrl_auth_GetAllUser =
      "${apiUrl_Base}api/v1/auth/GetAllUser";

  // ignore: slash_for_doc_comments
  /**
   * Room
   */
  // ignore: constant_identifier_names
  static const String apiUrl_room_GetAllRooms =
      "${apiUrl_Base}api/v1/room/GetAllRooms";
  // ignore: constant_identifier_names
  static const String apiUrl_room_GetRoomById =
      "${apiUrl_Base}api/v1/room/GetRoomById";
  // ignore: constant_identifier_names
  static const String apiUrl_room_CreateRoom =
      "${apiUrl_Base}api/v1/room/CreateRoom";
  // ignore: constant_identifier_names
  static const String apiUrl_room_UpdateRoom =
      "${apiUrl_Base}api/v1/room/UpdateRoom";
}
