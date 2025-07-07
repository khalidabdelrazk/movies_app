import 'package:movies/core/model/failures.dart';
import 'package:movies/presentation/profile%20update/domain/entitys/delete_response_entity.dart';
import 'package:movies/presentation/profile%20update/domain/entitys/reset_password_entity.dart';
import 'package:movies/presentation/profile%20update/domain/entitys/update_profile_response_entity.dart';

abstract class UpdateProfileStates {}

class UpdateProfileLoadingState extends UpdateProfileStates {}

class UpdateProfileInitialState extends UpdateProfileStates {}

class UpdateProfileErrorState extends UpdateProfileStates {
  Failures failures;
  UpdateProfileErrorState({required this.failures});
}

class UpdateProfileSuccessState extends UpdateProfileStates {
  UpdateProfileResponseEntity updateProfileResponseEntity;
  UpdateProfileSuccessState({required this.updateProfileResponseEntity});
}

//delete profile states
class DeleteProfileLoadingState extends UpdateProfileStates {}

class DeleteProfileInitialState extends UpdateProfileStates {}

class DeleteProfileErrorState extends UpdateProfileStates {
  Failures failures;
  DeleteProfileErrorState({required this.failures});
}

class DeleteProfileSuccessState extends UpdateProfileStates {
  DeleteResponseEntity deleteProfileResponseEntity;
  DeleteProfileSuccessState({required this.deleteProfileResponseEntity});
}


//reset password states
class ResetPasswordLoadingState extends UpdateProfileStates {}

class ResetPasswordInitialState extends UpdateProfileStates {}

class ResetPasswordErrorState extends UpdateProfileStates {
  Failures failures;
  ResetPasswordErrorState({required this.failures});
}

class ResetPasswordSuccessState extends UpdateProfileStates {
  ResetPasswordEntity resetPasswordEntity;
  ResetPasswordSuccessState({required this.resetPasswordEntity});
}