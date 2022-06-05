import 'package:flutter/material.dart';
import 'package:teachme_app/constants/theme.dart';

class AddSubject extends StatefulWidget {
  const AddSubject({Key? key}) : super(key: key);

  @override
  State<AddSubject> createState() => _AddSubject();
}

class _AddSubject extends State<AddSubject> {

  String dropdownValue = 'Programación';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(Radius.circular(30.0)),),
        child:Container(
          color: MyColors.cardClass,
          width: 450,
          height: 150,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('Agregar materia',
                  style: const TextStyle(
                    color: MyColors.white,
                    fontSize: 25,
                  )),

              Text('Selecciona alguna de las siguientes materias: ',
                  style: const TextStyle(
                    color: MyColors.white,
                    fontSize: 17,
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    DropdownButton<String>(
                      value: dropdownValue,
                      icon: const Icon(Icons.arrow_drop_down),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValue = newValue!;
                        });
                      },
                      items: <String>['Matematica Discreta', 'Analisis Matematico', 'Programación', 'Biologia']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: const Text('Agregar'),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(MyColors.buttonCardClass)),
                    ),
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: const Text('Cancelar'),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(MyColors.buttonCardClass)),
                    ),
                  ],
                ),

            ],
          ),
        ),
      ),
    );
  }
}

void onPressed(String text) {
  print('Se presiono "$text"');
}
