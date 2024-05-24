import 'package:notes/data_sources/notes_data_source.dart';
import 'package:notes/model/notes.dart';
import 'package:uuid/uuid.dart';

/// An in-memory implementation of the [NotessDataSource] interface.
class InMemoryNotessDataSource implements NotesDataSource {
  /// Map of ID -> Notes
  final _cache = <String, Notes>{};

  @override
  Future<Notes> create(Notes notes) async {
    final id = const Uuid().v4();
    final createdNotes = notes.copyWith(id: id);
    _cache[id] = createdNotes;
    return createdNotes;
  }

  @override
  Future<List<Notes>> readAll() async => _cache.values.toList();

  @override
  Future<Notes?> read(String id) async => _cache[id];

  @override
  Future<Notes> update(String id, Notes Notes) async {
    return _cache.update(id, (value) => Notes);
  }

  @override
  Future<void> delete(String id) async => _cache.remove(id);
}