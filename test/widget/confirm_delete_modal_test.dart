import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:users/ui/widgets/confirm_delete_modal.dart';

void main() {
  testWidgets('ConfirmDeleteModal returns correct values on pop', (WidgetTester tester) async {
    bool? result;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) {
              return ElevatedButton(
                onPressed: () async {
                  result = await showDialog<bool>(
                    context: context,
                    builder: (context) => const ConfirmDeleteModal(userName: 'Tester'),
                  );
                },
                child: const Text('Open'),
              );
            },
          ),
        ),
      ),
    );

    // Open dialoig
    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();

    // Verify dialog content
    expect(find.text('Confirmar exclusão'), findsOneWidget);
    expect(find.text('Tem certeza que deseja excluir o colaborador "Tester"? Esta ação não pode ser desfeita.'), findsOneWidget);

    // Tap Cancel
    await tester.tap(find.text('Cancelar'));
    await tester.pumpAndSettle();
    
    expect(result, isFalse);
    
    // Open dialog again
    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();
    
    // Tap Confirm
    await tester.tap(find.text('Excluir'));
    await tester.pumpAndSettle();
    
    expect(result, isTrue);
  });
}
