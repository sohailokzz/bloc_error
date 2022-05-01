import 'package:bloc_course_app/bloc/bloc_action.dart';
import 'package:bloc_course_app/bloc/person.dart';
import 'package:bloc_course_app/bloc/persons_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';

const mockedPersons1 = [
  Person(
    age: 20,
    name: 'Foo',
  ),
  Person(
    age: 30,
    name: 'Bar',
  ),
];
const mockedPersons2 = [
  Person(
    age: 20,
    name: 'Foo',
  ),
  Person(
    age: 30,
    name: 'Bar',
  ),
];

Future<Iterable<Person>> mockGetPersons1(String _) =>
    Future.value(mockedPersons1);
Future<Iterable<Person>> mockGetPersons2(String _) =>
    Future.value(mockedPersons2);

void main() {
  group(
    'Testing bloc',
    () {
      late PersonBloc bloc;
      setUp(
        () {
          bloc = PersonBloc();
        },
      );

      blocTest<PersonBloc, FetchResult?>('Test Initial state',
          build: () => bloc,
          verify: (bloc) => expect(
                bloc.state,
                null,
              ));
//test person1
      blocTest<PersonBloc, FetchResult?>(
        'Mock retriving persons from first iterable',
        build: () => bloc,
        act: (bloc) {
          bloc.add(
            const LoadPersonAction(
              url: 'dumy_url_1',
              loader: mockGetPersons1,
            ),
          );
          bloc.add(
            const LoadPersonAction(
              url: 'dumy_url_1',
              loader: mockGetPersons1,
            ),
          );
        },
        expect: () => [
          const FetchResult(
            persons: mockedPersons1,
            isRetriveCache: false,
          ),
          const FetchResult(
            persons: mockedPersons1,
            isRetriveCache: false,
          )
        ],
      );

      //test person2
      blocTest<PersonBloc, FetchResult?>(
        'Mock retriving persons from second iterable',
        build: () => bloc,
        act: (bloc) {
          bloc.add(
            const LoadPersonAction(
              url: 'dumy_url_2',
              loader: mockGetPersons2,
            ),
          );
          bloc.add(
            const LoadPersonAction(
              url: 'dumy_url_2',
              loader: mockGetPersons2,
            ),
          );
        },
        expect: () => [
          const FetchResult(
            persons: mockedPersons2,
            isRetriveCache: false,
          ),
          const FetchResult(
            persons: mockedPersons2,
            isRetriveCache: false,
          )
        ],
      );
    },
  );
}
