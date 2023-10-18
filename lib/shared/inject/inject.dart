import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:kikagada/modules/auth/domain/repositories/auth_repository.dart';
import 'package:kikagada/modules/auth/domain/usecases/delete_account_usecase/delete_account_usecase.dart';
import 'package:kikagada/modules/auth/domain/usecases/delete_account_usecase/delete_account_usecase_imp.dart';
import 'package:kikagada/modules/auth/domain/usecases/get_user_usecase/get_user_usecase.dart';
import 'package:kikagada/modules/auth/domain/usecases/get_user_usecase/get_user_usecase_imp.dart';
import 'package:kikagada/modules/auth/domain/usecases/login_with_apple_usecase/login_with_apple_usecase.dart';
import 'package:kikagada/modules/auth/domain/usecases/login_with_apple_usecase/login_with_apple_usecase_imp.dart';
import 'package:kikagada/modules/auth/domain/usecases/login_with_google_usecase/login_with_google_usecase.dart';
import 'package:kikagada/modules/auth/domain/usecases/login_with_google_usecase/login_with_google_usecase_imp.dart';
import 'package:kikagada/modules/auth/external/datasource/firebase_auth_datasource_imp.dart';
import 'package:kikagada/modules/auth/infra/datasources/auth_datasource.dart';
import 'package:kikagada/modules/auth/infra/repositories/auth_repository_imp.dart';
import 'package:kikagada/modules/auth/presenter/stores/login_store.dart';
import 'package:kikagada/modules/auth/presenter/stores/profile_store.dart';
import 'package:kikagada/modules/review/domain/repositories/review_repository.dart';
import 'package:kikagada/modules/review/domain/usecases/create_review_usecase/create_review_usecase.dart';
import 'package:kikagada/modules/review/domain/usecases/delete_review_usecase/delete_review_usecase.dart';
import 'package:kikagada/modules/review/domain/usecases/get_my_reviews_usecase/get_my_reviews_usecase.dart';
import 'package:kikagada/modules/review/domain/usecases/get_photos_download_url_usecase/get_photos_download_url_usecase.dart';
import 'package:kikagada/modules/review/domain/usecases/get_review_by_id_usecase/get_review_by_id.dart';
import 'package:kikagada/modules/review/domain/usecases/get_reviews_usecase/get_reviews_usecase.dart';
import 'package:kikagada/modules/review/domain/usecases/update_review_usecase/update_review_usecase.dart';
import 'package:kikagada/modules/review/domain/usecases/upload_photos_usecase/upload_photos_usecase.dart';
import 'package:kikagada/modules/review/external/datasources/firebase_review_datasource.dart';
import 'package:kikagada/modules/review/infra/datasources/review_datasource.dart';
import 'package:kikagada/modules/review/infra/repositories/review_repository.dart';
import 'package:kikagada/modules/review/presenter/stores/create_review_store.dart';
import 'package:kikagada/modules/review/presenter/stores/home_store.dart';
import 'package:kikagada/modules/review/presenter/stores/my_reviews_store.dart';
import 'package:kikagada/modules/review/presenter/stores/review_details_store.dart';
import 'package:kikagada/shared/components/navigation_bar/navigation_bar_controller.dart';

final class Inject {
  final GetIt _getIt = GetIt.I;

  Inject._() {
    authModule();
    reviewModule();
    shared();
  }

  void authModule() {
    _getIt.registerLazySingleton<IAuthDatasource>(
        () => FirebaseAuthDatasourceImp(auth: FirebaseAuth.instance));
    _getIt.registerLazySingleton<IAuthRepository>(
        () => AuthRepositoryImp(datasource: _getIt()));
    _getIt.registerLazySingleton<ILoginWithGoogleUsecase>(
        () => LoginWithGoogleUsecaseImp(repository: _getIt()));
    _getIt.registerLazySingleton<ILoginWithAppleUsecase>(
        () => LoginWithAppleUsecaseImp(repository: _getIt()));
    _getIt.registerLazySingleton<IDeleteAccountUsecase>(
        () => DeleteAccountUsecase(repository: _getIt()));
    _getIt.registerLazySingleton<IGetUserUsecase>(
        () => GetUserUsecase(repository: _getIt()));
    _getIt.registerLazySingleton<LoginStore>(
        () => LoginStore(_getIt(), _getIt()));
    _getIt.registerLazySingleton<IProfileStore>(
        () => ProfileStore(_getIt(), _getIt()));
  }

  void reviewModule() {
    _getIt.registerLazySingleton<IReviewDatasource>(() =>
        FirebaseReviewDatasource(
            firestore: FirebaseFirestore.instance,
            storage: FirebaseStorage.instance,
            auth: FirebaseAuth.instance));
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
    _getIt.registerLazySingleton<IGetReviewsUsecase>(
        () => GetReviewsUsecase(repository: _getIt()));
    _getIt.registerLazySingleton<IGetPhotosDownloadURL>(
        () => GetPhotosDownloadURL(repository: _getIt()));
    _getIt.registerLazySingleton<IUploadPhotosUsecase>(
        () => UploadPhotosUsecase(repository: _getIt()));
    _getIt.registerLazySingleton<IGetMyReviewsUsecase>(
        () => GetMyReviewsUsecase(_getIt()));
    _getIt.registerLazySingleton<IReviewDetailsStore>(
        () => ReviewDetailsStore(_getIt(), _getIt(), _getIt()));
    _getIt.registerLazySingleton<IHomeStore>(() => HomeStore(_getIt()));
    _getIt.registerLazySingleton<ICreateReviewStore>(
        () => CreateReviewStore(_getIt(), _getIt()));
    _getIt
        .registerLazySingleton<IMyReviewsStore>(() => MyReviewsStore(_getIt()));
  }

  void shared() {
    _getIt.registerLazySingleton<NavigationBarController>(
      () => NavigationBarController(),
    );
  }

  factory Inject.initialize() {
    return Inject._();
  }
}
