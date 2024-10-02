import 'dart:math';

class Selector {
  final List<String> options;
  final Random _random = Random();

  Selector(this.options);

  //Este método se encarga de seleccionar aleatoriamente una opción de la lista
  String chooseRandomOption() {
    // verifica si la lista de opciones (options) está vacía.
    if (options.isEmpty) return 'No options available';

    int randomIndex = _random.nextInt(options.length); //genera un número entero aleatorio 
    return options[randomIndex];
  }
}
/* void MonedaDeAzar(Console console) {
      if (listaJugadores.isEmpty) {
        console.clearScreen();
        console.writeLine('No hay jugadores en la lista.', TextAlignment.center);
            sleep(Duration(seconds: 3)); 
        return;
      }
} */
