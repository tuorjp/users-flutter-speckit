import 'package:flutter/material.dart';

class ConfirmDeleteModal extends StatelessWidget {
  final String userName;

  const ConfirmDeleteModal({
    Key? key,
    required this.userName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Confirmar exclusão'),
      content: Text('Tem certeza que deseja excluir o colaborador "$userName"? Esta ação não pode ser desfeita.'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(true),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          child: const Text('Excluir', style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}
