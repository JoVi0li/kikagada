import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:kikagada/modules/auth/domain/repositories/auth_repository.dart';
import 'package:kikagada/modules/auth/domain/usecases/login_with_apple_usecase.dart';
import 'package:kikagada/modules/auth/domain/usecases/login_with_google_usecase.dart';
import 'package:kikagada/modules/auth/external/datasource/firebase_auth_datasource_imp.dart';
import 'package:kikagada/modules/auth/infra/datasources/auth_datasource.dart';
import 'package:kikagada/modules/auth/infra/repositories/auth_repository_imp.dart';
import 'package:kikagada/modules/auth/presenter/stores/login_store.dart';
import 'package:kikagada/modules/rank/domain/repositories/rank_repository.dart';
import 'package:kikagada/modules/rank/domain/usecases/get_ranks_usecase.dart';
import 'package:kikagada/modules/rank/domain/usecases/vote_relevance_usecase.dart';
import 'package:kikagada/modules/rank/external/datasources/firestore_rank_datasource.dart';
import 'package:kikagada/modules/rank/infra/datasources/rank_datasource.dart';
import 'package:kikagada/modules/rank/infra/repositories/rank_repository.dart';
import 'package:kikagada/modules/rank/presenter/stores/overview_store.dart';
import 'package:kikagada/modules/review/domain/repositories/review_repository.dart';
import 'package:kikagada/modules/review/domain/usecases/create_review_usecase/create_review_usecase.dart';
import 'package:kikagada/modules/review/domain/usecases/delete_review_usecase/delete_review_usecase.dart';
import 'package:kikagada/modules/review/domain/usecases/get_review_by_id_usecase/get_review_by_id.dart';
import 'package:kikagada/modules/review/domain/usecases/update_review_usecase/update_review_usecase.dart';
import 'package:kikagada/modules/review/external/datasources/firestore_review_datasource.dart';
import 'package:kikagada/modules/review/infra/datasources/review_datasource.dart';
import 'package:kikagada/modules/review/infra/repositories/review_repository.dart';
import 'package:kikagada/modules/review/presenter/stores/review_details_store.dart';

final class Inject {
  final GetIt _getIt = GetIt.I;

  Inject._() {
    authModule();
    reviewModule();
    rankModule();
  }

  void authModule() {
    _getIt.registerLazySingleton<AuthDatasource>(
        () => FirebaseAuthDatasourceImp());
    _getIt.registerLazySingleton<AuthRepository>(
        () => AuthRepositoryImp(datasource: _getIt()));
    _getIt.registerLazySingleton<LoginWithGoogleUsecase>(
        () => LoginWithGoogleUsecaseImp(repository: _getIt()));
    _getIt.registerLazySingleton<LoginWithAppleUsecase>(
        () => LoginWithAppleUsecaseImp(repository: _getIt()));
    _getIt.registerLazySingleton<LoginStore>(
        () => LoginStore(_getIt(), _getIt()));
  }

  void reviewModule() {
    _getIt.registerLazySingleton<IReviewDatasource>(
        () => FirestoreReviewDatasource(firestore: FirebaseFirestore.instance));
    _getIt.registerLazySingleton<IReviewRepository>(
        () => ReviewRepository(datasource: _getIt()));
    _getIt.registerLazySingleton<ICreateReviewUsecase>(
        () => CreateReviewUsecase(repository: _getIt()));
    _getIt.registerLazySingleton<IGetReviewByIdUsecase>(
        () => GetReviewByIdUsecase(repository: _getIt()));
    _getIt.registerLazySingleton<IUpdateReviewUsecase>(
        () => UpdateReviewUsecase(repository: _getIt()));
    _getIt.registerLazySingleton<IDeleteReviewUsecase>(
        () => DeleteReviewUsecase(repository: _getIt()));
    _getIt.registerLazySingleton<IReviewDetailsStore>(
        () => ReviewDetailsStore(_getIt(), _getIt()));
  }

  void rankModule() {
    _getIt.registerLazySingleton<IRankDatasource>(
        () => FirestoreRankDatasource(firestore: FirebaseFirestore.instance));
    _getIt.registerLazySingleton<IRankRepository>(
      () => RankRepository(datasource: _getIt()),
    );
    _getIt.registerLazySingleton<IGetRanksUsecase>(
      () => GetRanksUsecase(repository: _getIt()),
    );
    _getIt.registerLazySingleton<IVoteRelevanceUsecase>(
      () => VoteRelevanceUsecase(repository: _getIt()),
    );
    _getIt.registerLazySingleton<IOverviewStore>(
      () => OverviewStore(_getIt(), _getIt()),
    );
  }

  factory Inject.initialize() {
    return Inject._();
  }
}
