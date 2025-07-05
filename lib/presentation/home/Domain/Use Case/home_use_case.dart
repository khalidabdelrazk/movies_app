import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:movies/presentation/home/Domain/Entity/movies_response_entity.dart';
import '../../../../core/model/failures.dart';
import '../Repository/home_repository.dart';

@injectable
class HomeUseCase {
  final HomeRepository homeRepository;
  HomeUseCase({required this.homeRepository});
  Future<Either<Failures, MoviesResponseEntity>> invoke(String? genre) {
    return homeRepository.getMostPopular(genre);
  }
}
