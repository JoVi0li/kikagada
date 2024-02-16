import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:kikagada/modules/auth/presenter/states/profile_state.dart';
import 'package:kikagada/modules/auth/presenter/stores/profile_store.dart';
import 'package:kikagada/modules/auth/presenter/widgets/profile_widgets/delete_account_widget.dart';
import 'package:kikagada/modules/auth/presenter/widgets/profile_widgets/diplay_user_infos_widget.dart';
import 'package:kikagada/modules/auth/presenter/widgets/profile_widgets/profile_loading_widget.dart';
import 'package:kikagada/shared/services/google_ad_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late final GetIt _getIt;
  late final IProfileStore _store;

  @override
  void initState() {
    super.initState();
    _getIt = GetIt.I;
    _store = _getIt<IProfileStore>();
  }

  @override
  void dispose() {
    _getIt.resetLazySingleton<IProfileStore>();
    ad.$2();
    super.dispose();
  }

  final ad =
      GoogleAdService.loadBannerAd("ca-app-pub-1971148572039667/3712071145");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text(
          'Meu perfil',
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
                  ProfileLoadingState() => const ProfileLoadingWidget(),
                  (ProfileRetrievedAccountState retrieved) =>
                    DisplayUserInfosWidget(
                      retrieved.user,
                      onDeleteAccount: _store.initDeleteAccountFlow,
                    ),
                  ProfileDeletedAccountState() => const ProfileLoadingWidget(),
                  (ProfileInitDeleteAccountFlowState deleted) =>
                    DeleteAccountWidget(
                      deleted.user,
                      onCancel: _store.cancelDeleteAccountFlow,
                      onConfirm: _store.deleteAccount,
                    ),
                  ProfileErrorState() => Container(),
                };
              },
            ),
          ),
          ad.$1,
        ],
      ),
    );
  }
}
