import 'package:flutter/widgets.dart';

/*  La idea de la existencia de esta clase, es poder usar el
    navigator de flutter de forma mas trasparente y sin animaciones.
    Puede pensarse como un wrapper de Navigator */
class TMNavigator extends Navigator {
  const TMNavigator({Key? key}) : super(key: key);

  /*  Funcion a la que deberemos llamar para movernos de pagina.
      Recibe el contexto (simplemente escribir "context") y la pagina
      (el Widget) a la que queremos ir */
  static void navigateTo(BuildContext context, Widget page) {
    Navigator.pushReplacement(context, _noAnimationRouter(page));
  }

  /*  Esta funcion devuelve un PageRouteBuilder sin animacion de transicion,
      que es usado por la funcion navigateTo() */
  static PageRouteBuilder _noAnimationRouter(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation1, animation2) => page,
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
    );
  }
}
