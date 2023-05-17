import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';
import 'package:part_13/models/place.dart';

Future<Database> _getDatabase() async {
  final dbPat = await sql.getDatabasesPath();
  final db = await sql.openDatabase(
    path.join(dbPat, 'places.db'),
    onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE user_places(id TEXT PRIMARY KEY, title TEXT, image TEXT)');
    },
    version: 1,
  );
  return db;
}

class UserPlacesNotifier extends StateNotifier<List<Place>> {
  UserPlacesNotifier() : super(const []);

  Future<void> loadPlaces() async {
    final db = await _getDatabase();
    final data = await db.query('user_places');
    final places = data.map(
      (row) => Place(
        id: row['id'] as String,
        image: File(row['image'] as String),
        title: row['title'] as String,
      ),
    ).toList();
    state = places;
  }

  void addPlace(String title, File image) async {
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fiilename = path.basename(image.path);
    final copiedImage = await image.copy('${appDir.path}/$fiilename');

    final newPlace = Place(image: copiedImage, title: title);
    final db = await _getDatabase();
    db.insert('user_places',
        {'id': newPlace.id, 'title': newPlace.title, 'image': newPlace.image});

    state = [newPlace, ...state];
  }
}

final userPlacesProvider =
    StateNotifierProvider<UserPlacesNotifier, List<Place>>(
  (ref) => UserPlacesNotifier(),
);
