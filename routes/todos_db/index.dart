import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:notes/model/notes_status.dart';
import 'package:postgres/postgres.dart';

FutureOr<Response> onRequest(RequestContext context) async {
  switch (context.request.method) {
    case HttpMethod.get:
      return _getAllNotes(context);
    case HttpMethod.post:
      return _postNewNote(context);
    case HttpMethod.delete:
    case HttpMethod.head:
    case HttpMethod.options:
    case HttpMethod.patch:
    case HttpMethod.put:
      return Response(statusCode: HttpStatus.methodNotAllowed);
  }
}

Future<Response> _getAllNotes(RequestContext context) async {
  final list = <Map<String, dynamic>>[];
  final results = await context
      .read<Connection>()
      .execute('SELECT id, title, description, status FROM notesTable');

  for (final row in results) {
    list.add({
      'id': row[0],
      'title': row[1],
      'description': row[2],
      'status': row[3],
    });
  }
  return Response.json(
    body: list,
  );
}

Future<Response> _postNewNote(RequestContext context) async {
  final body = await context.request.json() as Map<String, dynamic>;
  final title = body['title'];
  final description = body['description'];
  final status = body['status'];

  switch (status) {
    case 'to-do':
    case 'in-progress':
    case 'paused':
    case 'completed':
      final result = await context.read<Connection>().execute(
            // ignore: lines_longer_than_80_chars
            'INSERT INTO notesTable (title, description, status) VALUES (\'$title\', \'$description\', \'$status\')',
          );
      if (result.affectedRows == 1) {
        return Response.json(
          body: {'success': 'true'},
        );
      } else {
        return Response.json(
          body: {'success': 'false'},
        );
      }
    default:
      return Response.json(
        statusCode: HttpStatus.badRequest,
        body: {'message': 'Status is $status'},
      );
  }
}
