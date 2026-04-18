import 'package:unseen/core/types/repo_reponse.type.dart';
import 'package:unseen/core/types/usecase.dart';
import 'package:unseen/modules/rating/domain/repository/rating_repository.dart';
import 'package:unseen/modules/stream/data/models/rating.input.dart';
import 'package:unseen/modules/stream/domain/entities/rating.entity.dart';

class CreateRatingUseCase extends UseCase<RatingEntity, CreateRatingInput> {
  final RatingRepository repo;

  CreateRatingUseCase({required this.repo});

  @override
  Future<RepoResponse<RatingEntity>> call(CreateRatingInput input) =>
      repo.createRating(input);
}
