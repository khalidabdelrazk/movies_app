import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:movies/core/model/failures.dart';
import 'package:movies/presentation/home/Domain/Entity/movies_response_entity.dart';
import '../../../../../../core/api manager/api_endpoints.dart';
import '../../../../../../core/api manager/api_manager.dart';
import '../../../Models/movies_response_dm.dart';
import '../home_remote_data_source.dart';

@Injectable(as: HomeRemoteDataSource)
class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  ApiManager apiManager;
  HomeRemoteDataSourceImpl({required this.apiManager});

  @override
  Future<Either<Failures, MoviesResponseEntity>> getMostPopular(
      String? genre) async {
    final List<ConnectivityResult> connectivityResult =
        await Connectivity().checkConnectivity();
    try {
      if (connectivityResult.contains(ConnectivityResult.wifi) ||
          connectivityResult.contains(ConnectivityResult.ethernet) ||
          connectivityResult.contains(ConnectivityResult.vpn) ||
          connectivityResult.contains(ConnectivityResult.bluetooth) ||
          connectivityResult.contains(ConnectivityResult.other) ||
          !connectivityResult.contains(ConnectivityResult.none) ||
          connectivityResult.contains(ConnectivityResult.mobile)) {
        Map<String, dynamic> queryParams = {};
        if (genre != null) {
          queryParams.addAll({"genre": genre});
        }
        queryParams.addAll({'limit': 10});
        var response = await apiManager.getData(
          path: ApiEndpoints.listMovies,
          queryParameters: queryParams,
          options: Options(
            headers: {"Content-Type": "application/json"},
            validateStatus: (status) => true,
          ),
        );
        MoviesResponseDm registerResponse = MoviesResponseDm.fromJson(
          response.data,
        );
        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          return Right(registerResponse);
        }
        return Left(ServerError(errorMessage: registerResponse.message!));
      } else {
        return Left(NetworkError(errorMessage: "Network Error"));
      }
    } catch (e) {
      return Left(ServerError(errorMessage: e.toString()));
    }
  }
}