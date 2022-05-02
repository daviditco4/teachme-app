import 'package:flutter/material.dart';

class TeacherProfileMiddleInfo extends StatelessWidget {
  const TeacherProfileMiddleInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Información acerca de la sala',
          style: textTheme.titleMedium,
        ),
        const SizedBox(height: 5.0),
        Text(
          'Este único chat es el mínimo recurso que bastará para buscar un profesor/alumno por el momento. Deje su mensaje de búsqueda y conéctese con un posible profesor/alumno.',
          style: textTheme.bodyMedium,
        ),
      ],
    );
  }
}
