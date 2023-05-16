import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:part_13/providers/user_provider.dart';
import 'package:part_13/screen/add_place.dart';
import 'package:part_13/widgets/image_input.dart';
import 'package:part_13/widgets/plasec_list.dart';

class PlacesScreen extends ConsumerWidget {
  const PlacesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userPlaces = ref.watch(userPlacesProvider);
    File? _selectedImage;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Places'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => AddNewPlace(),
              ));
            },
            icon: const Icon(Icons.add),
          ),
         
        ],
      ),
      body: PlacesList(places: userPlaces),
    );
  }
}





//  IconButton(
//               onPressed: () {
//                 Navigator.of(context).push(MaterialPageRoute(
//                   builder: (context) => ImageInput(
//                     onPickImage: (image) => _selectedImage = image,
//                   ),
//                 ));
//               },
//               icon: Icon(Icons.camera_alt))