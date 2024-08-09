import 'package:dartz/dartz.dart';
import 'package:spotify/core/usecase/usecase.dart';
import 'package:spotify/core/injection/service_locator.dart';
import 'package:spotify/feature/home/logic/repositoy/song_repo.dart';

class FetchLikedSongsUsecase implements UseCase<Either, dynamic> {
  @override
  Future<Either?> call({params}) async {
    return await serviceLocator<SongRepository>().fetchLikedSongs();
  }
}
