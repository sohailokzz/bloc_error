import 'package:bloc_course_app/bloc/bloc_action.dart';
import 'package:bloc_course_app/bloc/person.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter_bloc/flutter_bloc.dart';

extension IsEqualToIgnoringOrdering<T> on Iterable<T> {
  bool isEqualToIgnoringOrdering(Iterable<T> other) =>
      length == other.length &&
      {...this}.intersection({...other}).length == length;
}

@immutable
class FetchResult {
  final Iterable<Person> persons;
  final bool isRetriveCache;

  const FetchResult({
    required this.persons,
    required this.isRetriveCache,
  });

  @override
  String toString() =>
      'FetchResult ( persons= $persons,isRetriveCache = $isRetriveCache,)';

  @override
  bool operator ==(covariant FetchResult other) =>
      persons.isEqualToIgnoringOrdering(other.persons) &&
      isRetriveCache == other.isRetriveCache;

  @override
  int get hashCode => Object.hash(
        persons,
        isRetriveCache,
      );
}

class PersonBloc extends Bloc<LoadAction, FetchResult?> {
  final Map<String, Iterable<Person>> _cach = {};
  PersonBloc() : super(null) {
    on<LoadPersonAction>((event, emit) async {
      final url = event.url;
      if (_cach.containsKey(url)) {
        final cachedPerson = _cach[url]!;
        final result = FetchResult(
          persons: cachedPerson,
          isRetriveCache: true,
        );
        emit(result);
      } else {
        final loader = event.loader;
        final persons = await loader(url);
        _cach[url] = persons;
        final result = FetchResult(
          persons: persons,
          isRetriveCache: false,
        );
        emit(result);
      }
    });
  }
}
