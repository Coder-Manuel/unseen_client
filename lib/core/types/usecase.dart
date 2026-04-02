import 'dart:async';

import 'package:unseen/core/types/repo_reponse.type.dart';

abstract class UseCase<T, Params> {
  FutureOr<RepoResponse<T>> call(Params params);
}
