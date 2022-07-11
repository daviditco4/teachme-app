import 'package:flutter/material.dart';
import 'package:teachme_app/constants/theme.dart';
import 'package:teachme_app/pages/settings_page.dart';
import 'package:flutter/cupertino.dart';
import '../widgets/other/tm_navigator.dart';

class Help extends StatefulWidget {
  const Help({Key? key}) : super(key: key);

  @override
  State<Help> createState() => _Help();
}

class _Help extends State<Help> {
  bool _expanded1 = false;
  bool _expanded2 = false;
  bool _expanded3 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.background,
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: true,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () =>
                TMNavigator.navigateToPage(context, const SettingsPage())),
        title: const Text('Help',
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
              ExpansionPanelList(
                animationDuration: const Duration(milliseconds: 500),
                children: [
                  ExpansionPanel(
                    headerBuilder: (context, isExpanded) {
                      return const ListTile(
                        title: Text(
                          'Reportar un problema',
                          style: TextStyle(color: Colors.black),
                        ),
                      );
                    },
                    body: SafeArea(
                      child: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            const Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  25, 10, 40, 20),
                              child: TextField(
                                decoration: InputDecoration(
                                  border: UnderlineInputBorder(),
                                  hintText: 'Dejar un comentario del reporte',
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 130.0),
                              child: ElevatedButton(
                                onPressed: () => showPopup(),
                                child: const Text('Enviar'),
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        MyColors.buttonCardClass),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(18),
                                            side: const BorderSide(
                                                color: Colors.white)))),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    isExpanded: _expanded1,
                    backgroundColor: MyColors.background,
                    canTapOnHeader: true,
                  ),
                ],
                dividerColor: MyColors.bottomNavBarBackground,
                expansionCallback: (panelIndex, isExpanded) {
                  _expanded1 = !_expanded1;
                  setState(() {});
                },
              ),
              ExpansionPanelList(
                animationDuration: const Duration(milliseconds: 500),
                children: [
                  ExpansionPanel(
                    headerBuilder: (context, isExpanded) {
                      return const ListTile(
                        title: Text(
                          'Solicitudes de ayuda',
                          style: TextStyle(color: Colors.black),
                        ),
                      );
                    },
                    body: const ListTile(
                      title: Text('Aun no se han realizado reportes',
                          style: TextStyle(color: Colors.black, fontSize: 15)),
                    ),
                    isExpanded: _expanded2,
                    backgroundColor: MyColors.background,
                    canTapOnHeader: true,
                  ),
                ],
                dividerColor: MyColors.bottomNavBarBackground,
                expansionCallback: (panelIndex, isExpanded) {
                  _expanded2 = !_expanded2;
                  setState(() {});
                },
              ),
              ExpansionPanelList(
                animationDuration: const Duration(milliseconds: 500),
                children: [
                  ExpansionPanel(
                    headerBuilder: (context, isExpanded) {
                      return const ListTile(
                        title: Text(
                          'Help sobre privacidad y seguridad',
                          style: TextStyle(color: Colors.black),
                        ),
                      );
                    },
                    body: const ListTile(
                      title: Text(
                          'Recorda que reporte es anonimo. \n ¿Como reportar a un usuario? ',
                          style: TextStyle(color: Colors.black, fontSize: 15)),
                    ),
                    isExpanded: _expanded3,
                    backgroundColor: MyColors.background,
                    canTapOnHeader: true,
                  ),
                ],
                dividerColor: MyColors.bottomNavBarBackground,
                expansionCallback: (panelIndex, isExpanded) {
                  _expanded3 = !_expanded3;
                  setState(() {});
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showPopup() {
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext builder) {
          return CupertinoPopupSurface(
            child: Container(
                padding: const EdgeInsetsDirectional.all(20),
                color: CupertinoColors.white,
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).copyWith().size.height * 0.25,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Material(
                        child: Text(
                      "Estas seguro que deseas iniciar el reporte?",
                      style: TextStyle(
                        backgroundColor: CupertinoColors.white,
                        fontSize: 25,
                      ),
                    )),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('No'),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  MyColors.buttonCardClass),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18),
                                      side: const BorderSide(
                                          color: Colors.white))),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text("Si"),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  MyColors.buttonCardClass),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18),
                                      side: const BorderSide(
                                          color: Colors.white))),
                            ),
                          ),
                        ]),
                  ],
                )),
            isSurfacePainted: true,
          );
        });
  }
}
