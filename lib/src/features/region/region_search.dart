import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/src/features/region/components/region_list.dart';
import 'package:weather_app/src/features/region/region_controller.dart';

import 'models/region.dart';

class RegionSearch extends SearchDelegate<String> {
  
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        var controller = context.read<RegionController>();
        controller.clearPossibleRegions();
        return close(context, '');
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.close),
      )
    ];
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildRegionList(context);
  }

  @override
  Widget buildResults(BuildContext context) {
    _updateRegionList(context);
    return _buildRegionList(context);
  }

  Widget _buildRegionList(BuildContext context) {
    var controller = context.watch<RegionController>();
    List<Region> searchedList = controller.possibleRegions;
    if (searchedList.isEmpty) {
      return const Center(
        child: Text('Search for a city in the world'),
      );
    } else {
      return RegionList(regions: searchedList);
    }
  }

  void _updateRegionList(BuildContext context) {
    var controller = context.read<RegionController>();
    if (query.isNotEmpty) {
      controller.getPossibleRegions(query);
    }
  }
}
