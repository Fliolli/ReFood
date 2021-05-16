import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';

class PlaceSuggestion {
  final String placeId;
  final String description;

  PlaceSuggestion(this.placeId, this.description);

  @override
  String toString() {
    return 'Suggestion(description: $description, placeId: $placeId)';
  }
}

class PlaceApiProvider {
  final client = Client();

  PlaceApiProvider(this.sessionToken);

  final sessionToken;

  static final String androidKey = 'AIzaSyDeWEmtAR98Oxm19lCOu1eEdwtDUKrHGjk';
  static final String iosKey = 'AIzaSyCRZguDFpDMVrlPy-tqJR6YSePT237eHyc';
  final apiKey = Platform.isAndroid ? androidKey : iosKey;

  Future<List<PlaceSuggestion>> fetchSuggestions(String input, String lang) async {
    final request =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&types=address&language=$lang&components=country:ru&key=$apiKey&sessiontoken=$sessionToken';
    final response = await client.get(Uri.parse(request));

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      if (result['status'] == 'OK') {
        return result['predictions']
            .map<PlaceSuggestion>((p) => PlaceSuggestion(p['place_id'], p['description']))
            .toList();
      }
      if (result['status'] == 'ZERO_RESULTS') {
        return [];
      }
      throw Exception(result['error_message']);
    } else {
      throw Exception('Failed to fetch suggestion');
    }
  }
}
