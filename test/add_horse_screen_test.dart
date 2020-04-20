import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:my_horses/screens/add_horse_screen.dart';

import 'test_widget.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  group('AddHorseScreen', () {
    NavigatorObserver mockObserver;

    setUp(() {
      mockObserver = MockNavigatorObserver();
    });

    final findNameTextField = find.byKey(Key('__nameTextField__'));
    final findNoteTextField = find.byKey(Key('__noteTextField__'));

    testWidgets('should render from text fields and button', (tester) async {
      await tester.pumpWidget(TestWidget(
        child: AddHorseScreen(
          testImage: true,
        ),
      ));
      await tester.pump(Duration.zero);

      expect(findNameTextField, findsOneWidget);
      expect(findNoteTextField, findsOneWidget);
      expect(find.byType(TextFormField), findsNWidgets(2));
      expect(find.byType(MaterialButton), findsOneWidget);
    });

    testWidgets('should pop when form submited', (tester) async {
      await tester.pumpWidget(MaterialApp(
        navigatorObservers: [mockObserver],
        home: TestWidget(
          child: AddHorseScreen(
            testImage: true,
          ),
        ),
      ));
      await tester.pumpAndSettle();

      await tester.enterText(findNameTextField, "Aris");
      await tester.tap(find.byKey(Key('__submitFormButton__')));
      await tester.pumpAndSettle();

      verify(mockObserver.didPush(captureAny, any));
    });

    testWidgets('should not display button when there is no any image',
        (tester) async {
      await tester.pumpWidget(TestWidget(
        child: AddHorseScreen(
          testImage: false,
        ),
      ));
      await tester.pumpAndSettle();
      expect(find.widgetWithText(MaterialButton, 'Button'), findsNothing);
    });

    testWidgets('should ask for name field if it is empty', (tester) async {
      await tester.pumpWidget(TestWidget(
        child: AddHorseScreen(testImage: true),
      ));
      await tester.pumpAndSettle();
      expect(find.widgetWithText(MaterialButton, 'Button'), findsOneWidget);

      await tester.tap(find.widgetWithText(MaterialButton, 'Button'));
      await tester.pump();

      expect(find.text('empty error'), findsOneWidget);
    });
  });
}
