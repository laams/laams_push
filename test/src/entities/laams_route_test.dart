import 'package:flutter_test/flutter_test.dart';
import 'package:laams_push/laams_push.dart';

void main() {
  test('Testing if two Routes pass == test', () async {
    const route1 = LaamsRoute.init(
      name: 'settings',
      fragment: '#home',
      arguments: <String, dynamic>{'id': 12333, 'name': 'karim'},
      state: {'lastName': 'Ahmadi'},
    );
    const route2 = LaamsRoute.init(
      name: 'settings',
      fragment: '#home',
      arguments: <String, dynamic>{'id': 12333, 'name': 'karim'},
      state: {'lastName': 'Ahmadi'},
    );
    expect(route1 == route2, true);
  });

  test('Testing if list of Routes pass == test', () async {
    const list1 = <LaamsRoute>[
      LaamsRoute.init(
        name: 'settings',
        fragment: '#home',
        arguments: <String, dynamic>{'id': 12333, 'name': 'karim'},
        state: {'lastName': 'Ahmadi'},
      ),
      LaamsRoute.init(
        name: 'settings',
        fragment: '#home',
        arguments: <String, dynamic>{'id': 12333, 'name': 'karim'},
        state: {'lastName': 'Ahmadi'},
      ),
    ];

    const list2 = <LaamsRoute>[
      LaamsRoute.init(
        name: 'settings',
        fragment: '#home',
        arguments: <String, dynamic>{'id': 12333, 'name': 'karim'},
        state: {'lastName': 'Ahmadi'},
      ),
      LaamsRoute.init(
        name: 'settings',
        fragment: '#home',
        arguments: <String, dynamic>{'id': 12333, 'name': 'karim'},
        state: {'lastName': 'Ahmadi'},
      ),
    ];

    expect(list1 == list2, true);
    final singledList = list1.toSet().toList();
    expect(singledList.length, 1);
  });

  test('This is to test a map', () {
    final product1 = <String, dynamic>{'id': 12333, 'name': 'karim'};
    final product2 = <String, dynamic>{'id': 12333, 'name': 'karim'};
    expect(product1 == product2, false);
  });
}
