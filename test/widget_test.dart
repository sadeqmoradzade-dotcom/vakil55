import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:vakil/main.dart';

void main() {
  testWidgets('Home screen shows the Persian search interface in RTL',
      (tester) async {
    await tester.pumpWidget(const VakilApp());

    // The application title appears in the app bar and as the page headline.
    expect(find.text('وکیل'), findsNWidgets(2));
    expect(find.text('جستجوی قوانین و مقررات'), findsOneWidget);
    expect(find.text('مثلاً مهندس'), findsOneWidget);
    expect(find.text('جستجو'), findsOneWidget);

    final context = tester.element(find.byType(Scaffold));
    expect(Directionality.of(context), TextDirection.rtl);
  });

  testWidgets('Pressing the search button shows the placeholder message',
      (tester) async {
    await tester.pumpWidget(const VakilApp());

    await tester.enterText(find.byType(TextField), 'قانون کار');
    await tester.tap(find.text('جستجو'));
    await tester.pumpAndSettle();

    expect(
      find.text('قابلیت جستجو در مرحله بعد فعال می‌شود.'),
      findsOneWidget,
    );
  });
}
