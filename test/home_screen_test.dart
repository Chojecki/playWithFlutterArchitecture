import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'test_widget.dart';

void main() {
  group('HomeScreen', () {
    final horseListFinder = find.byKey(Key('__horseList__'));
    final horseItem1Finder = find.byKey(Key('__dismissaibleHorse1__'));
    final horseItem2Finder = find.byKey(Key('__dismissaibleHorse2__'));

    testWidgets('should display a list after loading horses', (tester) async {
      await tester.pumpWidget(TestWidget());
      await tester.pump(Duration.zero);

      expect(horseListFinder, findsOneWidget);
      expect(horseItem1Finder, findsOneWidget);
      expect(horseItem2Finder, findsOneWidget);
    });

    testWidgets('should remove horse using a dismissible', (tester) async {
      await tester.pumpWidget(TestWidget());
      await tester.pumpAndSettle();
      await tester.drag(horseItem1Finder, Offset(-1000, 0));
      await tester.pumpAndSettle(Duration(seconds: 5));

      expect(horseItem1Finder, findsNothing);
      expect(horseItem2Finder, findsOneWidget);
    });
  });
}
