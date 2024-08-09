import 'package:flutter/material.dart';
import 'package:spotify/core/utils/spacing.dart';
import 'package:spotify/core/utils/theme/font_styles.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:spotify/feature/onBoarding/presentation/bloc/theme_cubit/theme_cubit.dart';

class FirstPageContent extends StatelessWidget {
  const FirstPageContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Enjoy listening to music",
          style: AppFontStyles.bold22.copyWith(color: Colors.white),
        ),
        verticalSpaceing(20),
        Text(
          "Your ultimate music companion on the go! Dive into millions of tracks, podcasts, and playlists curated just for you. Let the music journey begin!",
          style: AppFontStyles.greyRegular17,
          textAlign: TextAlign.center,
        ),
        verticalSpaceing(23),
      ],
    );
  }
}
