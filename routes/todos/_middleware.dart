import 'package:dart_frog/dart_frog.dart';
import 'package:notes/data_sources/notes_data_source.dart';
import 'package:notes/data_sources/notes_datasources_impl.dart';


final _dataSource = InMemoryNotessDataSource();

Handler middleware(Handler handler) {
  return handler
      .use(requestLogger())
      .use(provider<NotesDataSource>((_) => _dataSource));

}
