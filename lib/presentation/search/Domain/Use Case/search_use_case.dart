import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/model/failures.dart';
import '../Entity/search_response_entity.dart';
import '../Repository/search_repository.dart';

@injectable
class SearchUseCase {
  final SearchRepository searchRepository;
  SearchUseCase({required this.searchRepository});
  Future<Either<Failures, SearchResponseEntity>> invoke({
    required String queryTerm,
    required num limit,
    required num page,
  }) {
    return searchRepository.getMoviesByQuery(
        queryTerm: queryTerm, limit: limit, page: page);
  }
}
