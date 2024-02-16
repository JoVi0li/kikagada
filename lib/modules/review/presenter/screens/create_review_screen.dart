import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:kikagada/modules/review/presenter/states/create_review_state.dart';
import 'package:kikagada/modules/review/presenter/stores/create_review_store.dart';
import 'package:kikagada/modules/review/presenter/widgets/create_review_widgets/create_review_widget.dart';
import 'package:kikagada/shared/services/google_ad_service.dart';

class CreateReviewScreen extends StatefulWidget {
  const CreateReviewScreen({super.key});

  @override
  State<CreateReviewScreen> createState() => _CreateReviewScreenState();
}

class _CreateReviewScreenState extends State<CreateReviewScreen> {
  late final GetIt _getIt;
  late final CreateReviewStore _store;
  late InterstitialAd _interstitialAd;

  @override
  void initState() {
    super.initState();
    _getIt = GetIt.I;
    _store = _getIt<CreateReviewStore>();
    loadIntersticialAd();
  }

  @override
  void dispose() {
    _getIt.resetLazySingleton<CreateReviewStore>();
    bannerAd.$2();
    super.dispose();
  }

  final bannerAd =
      GoogleAdService.loadBannerAd("ca-app-pub-1971148572039667/6326626194");

  void loadIntersticialAd() {
    InterstitialAd.load(
        adUnitId: "ca-app-pub-1971148572039667/7256564482",
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          // Called when an ad is successfully received.
          onAdLoaded: (ad) {
            ad.fullScreenContentCallback = FullScreenContentCallback(
                // Called when the ad showed the full screen content.
                onAdShowedFullScreenContent: (ad) {},
                // Called when an impression occurs on the ad.
                onAdImpression: (ad) {},
                // Called when the ad failed to show full screen content.
                onAdFailedToShowFullScreenContent: (ad, err) {
                  // Dispose the ad here to free resources.
                  ad.dispose();
                },
                // Called when the ad dismissed full screen content.
                onAdDismissedFullScreenContent: (ad) {
                  // Dispose the ad here to free resources.
                  ad.dispose();
                },
                // Called when a click is recorded for an ad.
                onAdClicked: (ad) {});

            debugPrint('$ad loaded.');
            // Keep a reference to the ad so you can show it later.
            _interstitialAd = ad;
          },
          // Called when an ad request failed.
          onAdFailedToLoad: (LoadAdError error) {
            debugPrint('InterstitialAd failed to load: $error');
          },
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text(
          'Criar review',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      body: Column(
        children: [
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: _store,
              builder: (ctx, state, child) {
                return switch (state) {
                  CreateReviewInitialState() => CreateReviewWidget.initial(),
                  CreateReviewLoadingState() => CreateReviewWidget.loading(),
                  CreateBaseExceptionState() =>
                    CreateReviewWidget.error(state.error),
                  CreateReviewHasNoPhotosState() =>
                    CreateReviewWidget.hasNoPhoto(ctx),
                  CreateReviewSuccessState() =>
                    CreateReviewWidget.success(ctx, _store.resetValues, _interstitialAd.show)
                };
              },
            ),
          ),
          bannerAd.$1,
        ],
      ),
    );
  }
}
