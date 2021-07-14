import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:music_factory/service/service.dart';

part 'music_service.dart';

class MusicRepository implements MusicService {
  const MusicRepository({required this.client});

  final NetworkClient client;

  @override
  Future<Response> loadAlbums(String artist) async {
    var queryParameters = <String, String>{
      'method': 'artist.gettopalbums',
      'artist': artist
    };
    var url = dotenv.env['API_URL'];
    return await client.get(url!, '', queryParameters: queryParameters);
  }

  @override
  Future<Response> searchArtist(String artistName) {
    // TODO: implement searchArtist
    throw UnimplementedError();
  }

}