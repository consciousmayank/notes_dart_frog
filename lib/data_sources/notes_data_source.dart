import 'package:notes/model/notes.dart';

/// An interface for a Notess data source.
/// A Notess data source supports basic C.R.U.D operations.
/// * C - Create
/// * R - Read
/// * U - Update
/// * D - Delete
abstract class NotesDataSource {
  /// Create and return the newly created Notes.
  Future<Notes> create(Notes notes);

  /// Return all Notess.
  Future<List<Notes>> readAll();

  /// Return a Notes with the provided [id] if one exists.
  Future<Notes?> read(String id);

  /// Update the Notes with the provided [id] to match [Notes] and
  /// return the updated Notes.
  Future<Notes> update(String id, Notes notes);

  /// Delete the Notes with the provided [id] if one exists.
  Future<void> delete(String id);
}