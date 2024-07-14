import 'package:bratacha/intl/localizations.dart';
import 'package:bratacha/widgets/common/panels/hard_mode_panel/hard_mode_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HardModePanel extends StatelessWidget {
  const HardModePanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(context.l10n.hardModePanelLabel),
        BlocBuilder<HardModeCubit, bool>(
          builder: (_, state) => Switch(
            value: state,
            onChanged: (_) => context.read<HardModeCubit>().toggle(),
            activeColor: Theme.of(context).colorScheme.secondary,
          ),
        ),
      ],
    );
  }
}
