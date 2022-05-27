import 'package:flutter/material.dart';
import 'package:teachme_app/constants/theme.dart';
import 'package:teachme_app/pages/settings_page.dart';
import 'package:flutter/material.dart';
import '../widgets/bottom_nav_bar.dart';

class PaymentMethod extends StatefulWidget {
  const PaymentMethod({Key? key}) : super(key: key);

  @override
  State<PaymentMethod> createState() => _PaymentMethod();
}


class _PaymentMethod extends State<PaymentMethod> {
  Future<bool?> showWarning(BuildContext context) async =>
      showDialog<bool>(
        context: context,
        builder: (context) =>
            AlertDialog(
              title: Text('Seguro quiere realizar los cambios?'),
              actions: [
                ElevatedButton(onPressed: () => Navigator.pop(context, false),
                    child: Text('No')),
                ElevatedButton(onPressed: () => Navigator.pop(context, true),
                    child: Text('Si'))
              ],
            ),
      );
  int? val = -1;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        print('Back Buttom');
        final shouldPop = await showWarning(context);
        return shouldPop ?? false;
      },
      child: Scaffold(
        backgroundColor: MyColors.background,
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: true,
          leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => navigateTo(context, const SettingsPage())
          ),
          title: const Text('Medio de Pagos',
              style: TextStyle(
                color: Colors.black,
                fontSize: 25,
                fontWeight: FontWeight.w900,
              )),
          backgroundColor: MyColors.background,
          elevation: 0,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Podes agregar tu cuenta de Marcado pago: ",
                style: const TextStyle(
                  color: MyColors.black,
                  fontSize: 15,)
                ),

                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(25, 10, 40, 20),
                  child: ListTile(
                    title: Text("Mercado Pago",
                    ),
                    leading: Radio(
                      value: 1,
                      groupValue: val,
                      onChanged: (int? value) {
                        setState(() {
                          val = value;
                        });
                      },
                      activeColor: MyColors.buttonCardClass,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 130.0),
                  child: ElevatedButton(
                    onPressed: ()=> showWarning(context),
                    child: const Text('Agregar metodo de pago'),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            MyColors.buttonCardClass),
                        shape: MaterialStateProperty.all<
                            RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18), side: const BorderSide(color: Colors.white))
                        )
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
