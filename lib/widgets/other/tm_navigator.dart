import 'package:flutter/widgets.dart';

/*  La idea de la existencia de esta clase, es poder usar el
    navigator de flutter de forma mas trasparente y sin animaciones.
    Puede pensarse como un wrapper de Navigator */
class TMNavigator {
  /*  Funcion a la que deberemos llamar para movernos de pagina.
      Recibe el contexto (simplemente escribir "context") y la pagina
      (el Widget) a la que queremos ir */
  static void navigateToPage(BuildContext context, Widget page) {
    Navigator.pushReplacement(context, _noAnimationRouter(page));
  }

  /*  Funcion adicional para movernos de pagina. Recibe el contexto
      (simplemente escribir "context") y la ruta de la pagina a la 
      que queremos ir. VIENE CON ANIMACION */
  static void navigateToRoute(BuildContext context, String routeName) {
    Navigator.pushReplacementNamed(context, routeName);
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
