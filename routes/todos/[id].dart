import 'dart:async';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:notes/data_sources/notes_data_source.dart';
import 'package:notes/model/notes.dart';

FutureOr<Response> onRequest(RequestContext context, String id) async {
  final dataSource = context.read<NotesDataSource>();
  final note = await dataSource.read(id);

  if (note == null) {
    return Response(statusCode: HttpStatus.notFound, body: 'Not found');
  }

  switch (context.request.method) {
    case HttpMethod.get:
      return _get(context, note);
    case HttpMethod.put:
      return _put(context, id, note);
    case HttpMethod.delete:
      return _delete(context, id);
    case HttpMethod.head:
    case HttpMethod.options:
    case HttpMethod.patch:
    case HttpMethod.post:
      return Response(statusCode: HttpStatus.methodNotAllowed);
  }
}

Future<Response> _get(RequestContext context, Notes note) async {
  return Response.json(body: note);
}

Future<Response> _put(RequestContext context, String id, Notes note) async {
  final dataSource = context.read<NotesDataSource>();
  final updatedNote = Notes.fromJson(
    await context.request.json() as Map<String, dynamic>,
  );
  final newNote = await dataSource.update(
    id,
    note.copyWith(
      title: updatedNote.title,
      description: updatedNote.description,
    ),
  );

  return Response.json(body: newNote);
}

Future<Response> _delete(RequestContext context, String id) async {
  final dataSource = context.read<NotesDataSource>();
  await dataSource.delete(id);
  return Response(statusCode: HttpStatus.noContent);
}
