import 'package:flutter/material.dart';
import 'package:part_13/screen/places_detail.dart';

import '../models/place.dart';

class PlacesList extends StatelessWidget {
  const PlacesList({super.key, required this.places});
  final List<Place> places;

  @override
  Widget build(BuildContext context) {
    if (places.isEmpty) {
      return Center(
        child: Text(
          'No Places added yet',
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(color: Theme.of(context).colorScheme.onBackground),
        ),
      );
    }
    return ListView.builder(
            itemCount: places.length,
            itemBuilder: (ctx, index) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => PlacesDetail(place: places[index]),));
                },
                leading: CircleAvatar(
                  // radius: 26,
                  backgroundImage: FileImage(places[index].image),
                ),
                title: Text(
                  places[index].title,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: Theme.of(context).colorScheme.onBackground),
                ),
                shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 2, color: Colors.white),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          );
  }
}
