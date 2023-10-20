import 'package:flutter/material.dart';
import 'package:kikagada/modules/auth/domain/entities/user_entity.dart';
import 'package:kikagada/modules/auth/presenter/widgets/profile_widgets/diplay_user_infos_widget.dart';
import 'package:kikagada/shared/components/button_component.dart';
import 'package:kikagada/shared/components/dialog_component.dart';

class DeleteAccountWidget extends StatelessWidget {
  const DeleteAccountWidget(
    this.user, {
    super.key,
    required this.onCancel,
    required this.onConfirm,
  });

  final UserEntity user;
  final void Function(UserEntity) onCancel;
  final void Function() onConfirm;

  void cancelDeleteFlow(BuildContext context, UserEntity user) {
    onCancel(user);
    Navigator.pop(context);
  }

  Future<void> confirmDeleteAccount(BuildContext context) async {
    onConfirm();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        return showAdaptiveDialog<void>(
          barrierDismissible: false,
          context: context,
          builder: (ctx) {
            return DialogComponent(
              title: 'Tem certeza?',
              content:
                  "Ao clicar em ”Excluir conta” você perderá todos seus dados e também seu acesso ao app.",
              actions: [
                ButtonComponent(
                  onPressed: () => cancelDeleteFlow(context, user),
                  label: 'Cancelar',
                  type: ButtonComponentType.create,
                ),
                ButtonComponent(
                  onPressed: () => confirmDeleteAccount(context),
                  label: 'Excluir conta',
                  type: ButtonComponentType.delete,
                ),
              ],
            );
          },
        );
      },
    );
    return DisplayUserInfosWidget(user, onDeleteAccount: (_) {});
  }
}
