// To parse this JSON data, do
//
//     final notes = notesFromJson(jsonString);

import 'package:meta/meta.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'notes.freezed.dart';
part 'notes.g.dart';

@freezed
class Notes with _$Notes {
    const factory Notes({
        String? id,
        required String title,
        required String description,
        required DateTime createdAt,
        required String author,
    }) = _Notes;

    factory Notes.fromJson(Map<String, dynamic> json) => _$NotesFromJson(json);
}
