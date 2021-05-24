import 'package:flutter/material.dart';
import 'package:flutter_test_app/resources/ColorsLibrary.dart';
import 'package:flutter_test_app/resources/StylesLibrary.dart';

import '../services/PlaceApiProvider.dart';

class AddressSearch extends SearchDelegate<PlaceSuggestion> {
  AddressSearch(this.sessionToken)
      : super(
          keyboardType: TextInputType.text,
          searchFieldLabel: 'Поиск',
          textInputAction: TextInputAction.none,
        ) {
    apiClient = PlaceApiProvider(sessionToken);
  }

  final sessionToken;
  PlaceApiProvider apiClient;
  PlaceSuggestion _placeSuggestion;

  @override
  List<Widget> buildActions(
    BuildContext context,
  ) {
    return [
      IconButton(
        tooltip: 'Clear',
        icon: Icon(
          Icons.clear,
          color: ColorsLibrary.primaryColor,
        ),
        onPressed: () {
          query = '';
        },
      ),
      IconButton(
        tooltip: 'Done',
        icon: Icon(
          Icons.done,
          color: ColorsLibrary.primaryColor,
        ),
        onPressed: () {
          close(context, _placeSuggestion);
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon: Icon(
        Icons.arrow_back,
        color: ColorsLibrary.primaryColor,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
      future: query == "" ? null : apiClient.fetchSuggestions(query, "ru"),
      builder: (context, snapshot) => query == ''
          ? Container(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Введите адрес..',
                style: StylesLibrary.optionalBlackTextStyle,
              ),
            )
          : snapshot.hasData
              ? ListView.builder(
                  itemBuilder: (context, index) => ListTile(
                    title: Text((snapshot.data[index] as PlaceSuggestion).description),
                    onTap: () {
                      query = (snapshot.data[index] as PlaceSuggestion).description;
                      _placeSuggestion = snapshot.data[index] as PlaceSuggestion;
                    },
                  ),
                  itemCount: snapshot.data.length,
                )
              : Container(
                  child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Загрузка..',
                    style: StylesLibrary.optionalBlackTextStyle,
                  ),
                )),
    );
  }
}
