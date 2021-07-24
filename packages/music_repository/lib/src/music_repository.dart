import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:network/network.dart';

part 'music_service.dart';

class MusicRepository implements MusicService {
  const MusicRepository({required this.client});

  final NetworkClient client;

  @override
  Future<Response> loadArtists(String artist) async {
    var queryParameters = <String, String>{
      'method': 'artist.search',
      'format': 'json',
      'api_key': dotenv.env['API_KEY']!,
      'artist': artist
    };
    var url = dotenv.env['API_URL'];
    return await client.get(url!, '', queryParameters: queryParameters);
  }

  @override
  Future<Response> searchArtist(String artistName, [int index = 1]) async {
    var queryParameters = <String, String>{
      'method': 'artist.search',
      'format': 'json',
      'api_key': dotenv.env['API_KEY']!,
      'artist': artistName,
      'page': '$index'
    };
    var url = dotenv.env['API_URL'];
    return await client.get(url!, '', queryParameters: queryParameters);
  }

  @override
  Future<Response> loadTopTags(String artistName, [int index = 1]) async {
    var queryParameters = <String, String>{
      'method': 'artist.gettopalbums',
      'artist': artistName,
      'format': 'json',
      'api_key': dotenv.env['API_KEY']!,
      'page': '$index'
    };
    var url = dotenv.env['API_URL'];
    return await client.get(url!, '', queryParameters: queryParameters);
  }

  @override
  Future<Response> loadAlbumDetail({
    String? albumName,
    String? artistName,
    String? mbid,
  }) async {
    var queryParameters = <String, String>{
      'method': 'album.getinfo',
      'album': albumName ?? '',
      'artist': artistName ?? '',
      'format': 'json',
      'api_key': dotenv.env['API_KEY']!
    };

    if (albumName == null && artistName == null) {
      queryParameters['mbid'] = mbid ?? '';
    }

    var url = dotenv.env['API_URL'];
    return await client.get(
      url!,
      '',
      queryParameters: queryParameters,
      options: Options(extra: {'customProgress': false}),
    );
  }
}
