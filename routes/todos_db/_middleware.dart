import 'package:dart_frog/dart_frog.dart';
import 'package:postgres/postgres.dart';

Handler middleware(Handler handler) {
  return (context) async {
    final conn = await Connection.open(
        Endpoint(
          host: 'localhost',
          database: 'mydatabase_cmd',
          username: 'postgres',
          password: 'M0rpheus@@22',
          port: 5433,
        ),
        settings: const ConnectionSettings(
          sslMode: SslMode.disable,
        ));

    final response = await handler
        .use(
          provider<Connection>(
            (context) => conn,
          ),
        )
        .call(context);

    await conn.close();

    return response;
  };
}
