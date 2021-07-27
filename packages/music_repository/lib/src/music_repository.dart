import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:network/network.dart';

part 'music_service.dart';

/// A sub class of the Music Service
class MusicRepository implements MusicService {
  /// Constructor will require the client
  const MusicRepository({required this.client});

  /// Network client will be required to communicate with the api
  final NetworkClient client;

  /// This function will be use to search artist and load next data
  @override
  Future<Response> searchArtist(String artistName, [int index = 1]) async {
    var queryParameters = <String, String>{
      'method': 'artist.search',
      'format': 'json',
      'api_key': dotenv.env['API_KEY']!,
      'artist': artistName,
      'page': '$index'
    };
    return await client.get(
      dotenv.env['API_URL']!,
      '',
      queryParameters: queryParameters,
    );
  }

  /// loadTopAlbums will be use to fetch albums related to the respective
  /// artist. The method is being used it Get
  @override
  Future<Response> loadTopAlbums(String artistName, [int index = 1]) async {
    var queryParameters = <String, String>{
      'method': 'artist.gettopalbums',
      'artist': artistName,
      'format': 'json',
      'api_key': dotenv.env['API_KEY']!,
      'page': '$index'
    };
    return await client.get(
      dotenv.env['API_URL']!,
      '',
      queryParameters: queryParameters,
    );
  }

  /// loadAlbumDetail will be use to fetch album detail from the URL
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
