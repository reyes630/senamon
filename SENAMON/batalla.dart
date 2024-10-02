import 'package:dart_console/dart_console.dart';
import 'jugador.dart';
import 'Clsenamon.dart';
import 'moneda.dart';


class IniciarBatalla {
  static final Console console = Console(); // Crear instancia de Console

  static void iniciar(List<Jugador> listaJugadores, Map<String, Map<String, Senamon>> eleccionesJugadores) {
    if (listaJugadores.length < 2) {
      console.writeLine("Se necesitan al menos dos jugadores para iniciar una batalla.");
      return;
    }
   

    // Seleccionar aleatoriamente un jugador para iniciar la batalla
    Selector selector = Selector(listaJugadores.map((j) => j.nombre).toList());
    String jugadorInicialNombre = selector.chooseRandomOption();
    Jugador jugador1 = listaJugadores.firstWhere((j) => j.nombre == jugadorInicialNombre);
    Jugador jugador2 = listaJugadores.firstWhere((j) => j != jugador1);

    console.writeLine("Iniciando batalla entre ${jugador1.nombre} y ${jugador2.nombre}");

    Map<String, Senamon> senamones1 = Map.from(eleccionesJugadores[jugador1.nombre]!);
    Map<String, Senamon> senamones2 = Map.from(eleccionesJugadores[jugador2.nombre]!);

    while (senamones1.isNotEmpty && senamones2.isNotEmpty) {
      Senamon senamon1 = pedirSenamon(jugador1, senamones1);
      Senamon senamon2 = pedirSenamon(jugador2, senamones2);

      console.clearScreen();
      console.writeLine("${jugador1.nombre} usará a ${senamon1.nombre}");
      console.writeLine("${jugador2.nombre} usará a ${senamon2.nombre}");

      String perdedor = hacerBatalla(jugador1, senamon1, jugador2, senamon2);

      if (perdedor == jugador1.nombre) {
        senamones1.remove(saberElemento(senamon1));
        if (senamones1.isEmpty) {
          console.writeLine("${jugador1.nombre} se ha quedado sin Senamones.");
          jugador2.victorias++; // Jugador 2 gana la batalla
          break;
        }
      } else {
        senamones2.remove(saberElemento(senamon2));
        if (senamones2.isEmpty) {
          console.writeLine("${jugador2.nombre} se ha quedado sin Senamones.");
          jugador1.victorias++; // Jugador 1 gana la batalla
          break;
        }
      }

      if (!preguntarSiSeguir()) {
        break;
      }
    }

    mostrarResultadoFinal(jugador1, jugador2);
  }

  static Senamon pedirSenamon(Jugador jugador, Map<String, Senamon> senamones) {
    while (true) {
      console.writeLine("\n${jugador.nombre}, elige tu Senamon:");
      int index = 1;
      
      Map<int, Senamon> opciones = {};
      senamones.forEach((elemento, senamon) {
        console.writeLine("$index. ${senamon.nombre} ($elemento)");
        opciones[index] = senamon;
        index++;
      });

      console.writeLine("\nIngresa el número del Senamon que quieres:");
      String input = console.readLine()!; // Cambiar stdin.readLineSync() por console.readLine()
      int? seleccion = int.tryParse(input);

      if (seleccion != null && opciones.containsKey(seleccion)) {
        return opciones[seleccion]!;
      } else {
        console.writeLine("Selección inválida. Por favor, intenta de nuevo.");
      }
    }
  }

  static String hacerBatalla(Jugador jugador1, Senamon senamon1, Jugador jugador2, Senamon senamon2) {
    String elemento1 = senamon1.tipo;
    String elemento2 = senamon2.tipo;
    int vida1 = senamon1.puntosSalud;
    int vida2 = senamon2.puntosSalud;

    while (vida1 > 0 && vida2 > 0) {
      // Ataque del jugador 1
      int ataque1 = calcularAtaque(elemento1, elemento2);
      vida2 -= ataque1;
      mostrarAtaque(jugador1.nombre, senamon1.nombre, jugador2.nombre, senamon2.nombre, ataque1, vida2);

      // Preguntar si el jugador 1 quiere continuar
      if (vida2 > 0 && !preguntarSiSeguir()) {
        break; // Salir si el jugador decide no continuar
      }

      if (vida2 <= 0) break;

      // Ataque del jugador 2
      int ataque2 = calcularAtaque(elemento2, elemento1);
      vida1 -= ataque2;
      mostrarAtaque(jugador2.nombre, senamon2.nombre, jugador1.nombre, senamon1.nombre, ataque2, vida1);

      // Preguntar si el jugador 2 quiere continuar
      if (vida1 > 0 && !preguntarSiSeguir()) {
        break; // Salir si el jugador decide no continuar
      }
    }

    // Determinar el ganador
    if (vida1 > 0) {
      console.writeLine("¡${jugador1.nombre} ha ganado la batalla!");
      jugador1.victorias++;  // Incrementar las victorias del jugador 1
      return jugador2.nombre;
    } else {
      console.writeLine("¡${jugador2.nombre} ha ganado la batalla!");
      jugador2.victorias++;  // Incrementar las victorias del jugador 2
      return jugador1.nombre;
    }
  }

  static bool preguntarSiSeguir() {
    while (true) {
      console.writeLine("\n¿Quieren seguir jugando? (s/n)");
       
      String? respuesta = console.readLine()?.toLowerCase();
      if (respuesta == 's') return true;
      if (respuesta == 'n') return false;
      console.writeLine("Respuesta inválida. Por favor, responde 's' para sí o 'n' para no.");
    }
  }

  static void mostrarAtaque(String atacante, String senamonAtacante, String defensor, String senamonDefensor, int danio, int vidaRestante) {
    console.writeLine("$atacante ataca a $defensor");
    console.writeLine("$senamonAtacante hace $danio de daño a $senamonDefensor");
    console.writeLine("Vida de $senamonDefensor: $vidaRestante");
    console.writeLine("-" * 40);
  }

  static String saberElemento(Senamon senamon) {
    return senamon.tipo; // Accediendo al atributo tipo directamente
  }

  static int calcularAtaque(String elementoAtacante, String elementoDefensor) {
    int ataque = 50;  // Ataque base

    if (elementoAtacante == 'Fuego' && elementoDefensor == 'Hierva') {
      ataque = 70;
    } else if (elementoAtacante == 'Agua' && elementoDefensor == 'Fuego') {
      ataque = 70;
    } else if (elementoAtacante == 'Hierva' && elementoDefensor == 'Agua') {
      ataque = 70;
    } else if (elementoAtacante == 'Electrico' && elementoDefensor == 'Agua') {
      ataque = 70;
    } else if (elementoAtacante == elementoDefensor) {
      ataque = 50;
    } else {
      ataque = 30;
    }

    String efectividad = ataque == 70 ? "muy efectivo" : (ataque == 50 ? "normal" : "poco efectivo");
    console.writeLine("El ataque es $efectividad y hace $ataque de daño.");
    return ataque;
  }

  static void mostrarResultadoFinal(Jugador jugador1, Jugador jugador2) {
    console.writeLine("\nResultado final:");
    console.writeLine("${jugador1.nombre}: ${jugador1.victorias} victorias");
    console.writeLine("${jugador2.nombre}: ${jugador2.victorias} victorias");

    if (jugador1.victorias > jugador2.victorias) {
      console.writeLine("¡${jugador1.nombre} es el ganador del juego!");
    } else if (jugador2.victorias > jugador1.victorias) {
      console.writeLine("¡${jugador2.nombre} es el ganador del juego!");
    } else {
      console.writeLine("¡El juego termina en empate!");
    }
  }
}
