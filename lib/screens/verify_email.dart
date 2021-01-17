import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shipanther/bloc/auth/auth_bloc.dart';
import 'package:shipanther/l10n/shipanther_localization.dart';
import 'package:shipanther/widgets/shipanther_scaffold.dart';
import 'package:shipanther/widgets/shipanther_text_form_field.dart';

class VerifyEmail extends StatelessWidget {
  const VerifyEmail(this.emailId, {Key? key}) : super(key: key);
  final String emailId;

  @override
  Widget build(BuildContext context) {
    return ShipantherScaffold(
      null,
      title: ShipantherLocalizations.of(context)!.welcome,
      actions: [
        IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              context.read<AuthBloc>().add(
                    const AuthLogout(),
                  );
            })
      ],
      body: Column(
        children: [
          Text(
            ShipantherLocalizations.of(context)!.emailSent(emailId),
          ),
          ShipantherButton(
            onPressed: () {
              context.read<AuthBloc>().add(
                    const CheckVerified(),
                  );
            },
            labelText: ShipantherLocalizations.of(context)!.iVerified,
          ),
          ShipantherButton(
            onPressed: () {
              context.read<AuthBloc>().add(
                    const ResendEmail(),
                  );
            },
            labelText: ShipantherLocalizations.of(context)!.resendEmail,
          ),
        ],
      ),
    );
  }
}
