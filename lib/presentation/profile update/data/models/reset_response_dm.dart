import 'package:movies/presentation/profile%20update/domain/entitys/reset_password_entity.dart';

class ResetPasswordDm extends ResetPasswordEntity {
  ResetPasswordDm({
    super.message,
  });

  ResetPasswordDm.fromJson(dynamic json) {
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    return map;
  }
}
