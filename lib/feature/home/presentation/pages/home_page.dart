import '../widgets/home_widgets.dart';
import 'package:flutter/material.dart';
import 'package:spotify/core/utils/spacing.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const ClampingScrollPhysics(),
      slivers: [
        const NewAlbumCard(),
        SliverToBoxAdapter(child: verticalSpaceing(15)),
        const SectionTitle("New Songs", 120),
        SliverToBoxAdapter(child: verticalSpaceing(10)),
        const NewSongsList(),
        const SectionTitle("Trending now", 140),
        SliverToBoxAdapter(child: verticalSpaceing(5)),
        const TrendingSongsList()
      ],
    );
  }
}
