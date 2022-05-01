import 'package:bloc_course_app/bloc/person.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter/material.dart';

const person1Url = 'http://10.0.2.2:5500/api/person1.json';
const person2Url = 'http://10.0.2.2:5500/api/person2.json';

typedef PersonsLoader = Future<Iterable<Person>> Function(String url);

@immutable
abstract class LoadAction {
  const LoadAction();
}

@immutable
class LoadPersonAction implements LoadAction {
  final String url;
  final PersonsLoader loader;

  const LoadPersonAction({
    required this.url,
    required this.loader,
  }) : super();
}
