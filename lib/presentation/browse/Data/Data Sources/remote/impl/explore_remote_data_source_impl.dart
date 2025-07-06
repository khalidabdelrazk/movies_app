import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:movies/core/model/failures.dart';
import '../../../../../../core/api manager/api_endpoints.dart';
import '../../../../../../core/api manager/api_manager.dart';
import '../../../Models/explore_response_dm.dart';
import '../explore_remote_data_source.dart';

@Injectable(as: ExploreRemoteDataSource)
class ExploreRemoteDataSourceImpl implements ExploreRemoteDataSource {
  ApiManager apiManager;
  ExploreRemoteDataSourceImpl({required this.apiManager});

  @override
  Future<Either<Failures, ExploreResponseDm>> getMoviesByGenre({required String genre, required num limit, required num page}) async{
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
        var response = await apiManager.getData(
          path: ApiEndpoints.listMovies,
          queryParameters: {
            'genre' : genre,
            'limit' : limit,
            'page' : page ,
          },
          options: Options(
            headers: {"Content-Type": "application/json"},
            validateStatus: (status) => true,
          ),
        );
        ExploreResponseDm exploreResponseDm = ExploreResponseDm.fromJson(
          response.data,
        );
        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          return Right(exploreResponseDm);
        }
        return Left(ServerError(errorMessage: exploreResponseDm.message!));
      } else {
        return Left(NetworkError(errorMessage: "Network Error"));
      }
    } catch (e) {
      return Left(ServerError(errorMessage: e.toString()));
    }
  }
}