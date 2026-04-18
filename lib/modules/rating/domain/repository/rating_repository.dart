import 'package:unseen/core/types/repo_reponse.type.dart';
import 'package:unseen/modules/stream/data/models/rating.input.dart';
import 'package:unseen/modules/stream/domain/entities/rating.entity.dart';

abstract class RatingRepository {
  Future<RepoResponse<RatingEntity>> createRating(CreateRatingInput input);
}
