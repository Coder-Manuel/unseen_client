import 'package:get/get.dart';
import 'package:unseen/modules/rating/domain/usecases/create_rating.usecase.dart';

class RatingController extends GetxController {
  final CreateRatingUseCase _createRatingUsecase;

  RatingController({required CreateRatingUseCase createRatingUsecase})
    : _createRatingUsecase = createRatingUsecase;
}
