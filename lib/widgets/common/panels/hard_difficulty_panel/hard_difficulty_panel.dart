import 'package:bratacha/intl/localizations.dart';
import 'package:bratacha/widgets/common/panels/hard_difficulty_panel/hard_difficulty_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HardDifficultyPanel extends StatelessWidget {
  const HardDifficultyPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(AppLocalizations.hardDifficultyPanelLabel),
        BlocBuilder<HardDifficultyCubit, bool>(
          builder: (_, isHardDifficulty) => Switch(
            value: isHardDifficulty,
            onChanged: (_) => context.read<HardDifficultyCubit>().toggle(),
            activeColor: Theme.of(context).colorScheme.secondary,
          ),
        ),
      ],
    );
  }
}
