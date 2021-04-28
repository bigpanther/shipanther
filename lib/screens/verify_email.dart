import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shipanther/bloc/auth/auth_bloc.dart';
import 'package:shipanther/l10n/locales/l10n.dart';
import 'package:shipanther/widgets/shipanther_text_form_field.dart';

class VerifyEmail extends StatelessWidget {
  const VerifyEmail(this.emailId, {Key? key}) : super(key: key);
  final String emailId;

  @override
  Widget build(BuildContext context) {
    final localization = ShipantherLocalizations.of(context);
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            MdiIcons.emailSend,
            size: 100,
            color: theme.accentColor,
          ),
          Text(
            localization.emailSent(emailId),
            style: theme.textTheme.bodyText1!.copyWith(
              color: theme.hintColor,
            ),
            textAlign: TextAlign.center,
          ),
          ShipantherButton(
            onPressed: () {
              context.read<AuthBloc>().add(
                    const CheckVerified(),
                  );
            },
            labelText: localization.iVerified,
          ),
          ShipantherButton(
            onPressed: () {
              context.read<AuthBloc>().add(
                    const ResendEmail(),
                  );
            },
            labelText: localization.resendEmail,
            secondary: true,
          ),
        ],
      ),
    );
  }
}
