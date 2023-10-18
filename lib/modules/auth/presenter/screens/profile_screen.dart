import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:kikagada/modules/auth/presenter/states/profile_state.dart';
import 'package:kikagada/modules/auth/presenter/stores/profile_store.dart';
import 'package:kikagada/modules/auth/presenter/widgets/profile_widgets/diplay_user_infos_widget.dart';
import 'package:kikagada/shared/components/button_component.dart';

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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title:
            Text('Meu perfil', style: Theme.of(context).textTheme.titleMedium),
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      body: ValueListenableBuilder(
          valueListenable: _store,
          builder: (ctx, state, child) {
            switch (state) {
              case ProfileLoadingState():
                return CircularProgressIndicator();
              case ProfileRetrievedAccountState():
                return DisplayUserInfosWidget(state.user);
              
              default:
                return CircularProgressIndicator();
            }
          }),
    );
  }
}
