import 'package:http/http.dart';

abstract class BaseRepo {
  final Client client;

  const BaseRepo(this.client);
}
