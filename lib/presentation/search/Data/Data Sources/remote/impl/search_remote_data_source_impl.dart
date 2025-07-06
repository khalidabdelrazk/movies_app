import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:movies/core/model/failures.dart';
import '../../../../../../core/api manager/api_endpoints.dart';
import '../../../../../../core/api manager/api_manager.dart';
import '../../../Models/search_response_dm.dart';
import '../search_remote_data_source.dart';

@Injectable(as: SearchRemoteDataSource)
class SearchRemoteDataSourceImpl implements SearchRemoteDataSource {
  ApiManager apiManager;
  SearchRemoteDataSourceImpl({required this.apiManager});

  @override
  Future<Either<Failures, SearchResponseDm>> getMoviesByQuery({required String queryTerm, required num limit, required num page}) async{
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
        queryParams.addAll(
            {
              'limit': limit,
              'page': page,
              'query_term': queryTerm,
            }
        );
        var response = await apiManager.getData(
          path: ApiEndpoints.listMovies,
          queryParameters: queryParams,
          options: Options(
            headers: {"Content-Type": "application/json"},
            validateStatus: (status) => true,
          ),
        );
        SearchResponseDm searchResponseDm = SearchResponseDm.fromJson(
          response.data,
        );
        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          return Right(searchResponseDm);
        }
        return Left(ServerError(errorMessage: searchResponseDm.message!));
      } else {
        return Left(NetworkError(errorMessage: "Network Error"));
      }
    } catch (e) {
      return Left(ServerError(errorMessage: e.toString()));
    }
  }
}