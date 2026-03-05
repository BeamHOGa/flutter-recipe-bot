// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_application_1/main.dart';

void main() {
  testWidgets('Recipe chatbot shows initial UI', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('แชทบอทสูตรอาหาร'), findsOneWidget);
    expect(find.textContaining('ผู้ช่วยสูตรอาหาร AI'), findsOneWidget);
    expect(find.text('พิมพ์คำถามเกี่ยวกับสูตรอาหาร...'), findsOneWidget);
  });

  testWidgets('Recipe chatbot shows loading indicator when sending message',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.enterText(
      find.byType(EditableText).first,
      'ขอสูตรผัดกะเพราไก่',
    );
    await tester.tap(find.byIcon(Icons.send));
    await tester.pump();

    expect(find.text('ขอสูตรผัดกะเพราไก่'), findsOneWidget);
    expect(find.text('Gemini กำลังคิด...'), findsOneWidget);
  });
}
