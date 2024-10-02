import 'dart:io';
import 'package:dart_console/dart_console.dart';
import 'Clsenamon.dart';
import 'jugador.dart';
//import 'moneda.dart';
import 'batalla.dart';

//Definicion de listas
List<Jugador> listaJugadores = [];
List<List<Senamon>> listaSenamones = [];
Map<String, Map<String, Senamon>> senamonesPorJugador = {};

void main(List<String> args) {
  final console = Console(); // Inicializamos la consola

  // MENSAJE DE BIENVENIDA
  console.setBackgroundColor(ConsoleColor.blue); // COLOR DE FONDO
  console.setForegroundColor(ConsoleColor.white); // COLOR DE FUENTE
  console.writeLine('BIENVENID@ A', TextAlignment.center);
  console.setBackgroundColor(ConsoleColor.red);
  console.writeLine('SENAMON', TextAlignment.center);
  console.setBackgroundColor(ConsoleColor.blue);
  console.writeLine('En este mundo podrás divertirte...', TextAlignment.center);
  console.writeLine(
      'Elige entre las opciones, sigue las recomendaciones y DISFRUTA.',
      TextAlignment.center);
  console.resetColorAttributes(); // terminar
 
  // Pequeña pausa para que el usuario lea el mensaje
  sleep(Duration(seconds: 5)); // Pausa de 5 segundos

  // MENÚ PRINCIPAL
  final List<String> mainMenuOptions = [
    '1. Agregar Jugadores',
    '2. Elegir Senamon',
    '3. Iniciar Batallas',
    '4. Entrenar Senamon',
    '5. Jugador con más Victorias',
    '0. Salir'
  ];

  // MAP --> Asocia cada opción del menú principal con la lista de opciones de los submenús.
  final Map<String, List<String>> subMenus = {
    'Agregar Jugadores': ['1. Crear Jugadores', '0. Volver'],
    'Elegir Senamon': ['1. Elegir Senamon', '2. Cambiar Senamon', '0. Volver'],

    'Iniciar Batallas': ['1. Iniciar', '0. Volver'],

    'Entrenar Senamon': [
      '1. Ver mis puntos',
      '2. Entrenar Senamon',
      '0. Volver'
    ],

    'Jugador con más Victorias': [
      '1. Ver jugador con más victorias', //El jugador con mas puntos es quien tiene mas batallas ganadas
      '0. Volver'
    ],
  };

  int selectedIndex = 0;

  void displayMenu(List<String> options, {String title = 'MENÚ PRINCIPAL'}) {
    console.clearScreen();
    console.setBackgroundColor(ConsoleColor.blue);
    console.setForegroundColor(ConsoleColor.white);
    console.writeLine(title, TextAlignment.center);
    console.resetColorAttributes();
    console.writeLine('');

    for (int i = 0; i < options.length; i++) {
      if (i == selectedIndex) {
        console.setForegroundColor(ConsoleColor.white);
        console.write('➜ ');
      } else {
        console.write('  ');
      }
      console.writeLine(options[i]);
      console.resetColorAttributes();
    }
  }

  void handleSubMenu(String menuName) {
    List<String> subMenuOptions = subMenus[menuName]!;
    int subMenuIndex = 0;

    void displaySubMenu() {
      console.clearScreen();
      console.setBackgroundColor(ConsoleColor.blue);
      console.setForegroundColor(ConsoleColor.white);
      console.writeLine('MENÚ $menuName', TextAlignment.center);
      console.resetColorAttributes();
      console.writeLine('');

      for (int i = 0; i < subMenuOptions.length; i++) {
        if (i == subMenuIndex) {
          console.setForegroundColor(ConsoleColor.white);
          console.write('➜ ');
        } else {
          console.write('  ');
        }
        console.writeLine(subMenuOptions[i]);
        console.resetColorAttributes();
      }
    }

    displaySubMenu();

    void CrearJugador(Console console) {
      String? nombreJugador;
      String? emailJugador;
      int cantidadJugadores = 2;

      for (int i = 0; i < cantidadJugadores; i++) {
        console.clearScreen();
        console.setBackgroundColor(ConsoleColor.blue);
        console.setForegroundColor(ConsoleColor.white);
        console.writeLine(
            'Ingrese el nombre del jugador #${i + 1}: ', TextAlignment.left);
        console.resetColorAttributes();
        nombreJugador = console.readLine();

        console.setBackgroundColor(ConsoleColor.blue);
        console.setForegroundColor(ConsoleColor.white);
        console.writeLine(
            'Ingrese el email del jugador #${i + 1}: ', TextAlignment.left);
        console.resetColorAttributes();
        emailJugador = console.readLine();
        console.clearScreen();

        // Crear una instancia de Jugador y agregarla a la lista
        Jugador jugador = Jugador(nombreJugador!, emailJugador!, 0, 0);
        listaJugadores.add(jugador);

        console.clearScreen();
        console.writeLine('Jugador agregado :)', TextAlignment.center);
        //Muestra los nombres de los jugadores para confirmación.
        console.writeLine(listaJugadores.map((j) => j.nombre).join(', '), TextAlignment.center);
      }
    }

   void seleccionarSenamones(List<Jugador> listaJugadores, Map<String, Map<String, Senamon>> senamonesPorJugador, Console console) {
      console.clearScreen();
      if (listaJugadores.isEmpty) {
        console.setBackgroundColor(ConsoleColor.red);
        console.writeLine("Primero debe crear jugadores.");
        return;
      }
    
      // Definición del mapa
      //Mapa para seleccionar senamones con las flechas -------//
      Map<String, List<Senamon>> senamones = {
        'Fuego': [],
        'Agua': [],
        'Hierva': [],
        'Volador': [],
        'Electrico': [],
      };
      
      //Voladores
      Senamon volador1 = Senamon("Ledi", 1, "Volador", 50, 100, 40, 60, "Este senamon puede volar y atacar al tiempo");
      senamones['Volador']?.add(volador1); // El ? es para errores
      Senamon volador2 = Senamon("Mitrovic", 1, "Volador", 32, 100, 50, 120, "Es un senamon muy agil se destaca por su rapidez");
      senamones['Volador']?.add(volador2); // El ? es para errores
      Senamon volador3 = Senamon("Cole", 1, "Volador", 78, 74, 65, 126, "Es un senamon muy ágil que destaca por su rapidez y capacidad de ataque.");
      senamones['Volador']?.add(volador3); 
      Senamon volador4 = Senamon("Vanbas", 1, "Volador", 85, 70, 80, 123, "Un senamon que combina velocidad y fuerza, ideal para ataques sorpresivos.");
      senamones['Volador']?.add(volador4); 
      Senamon volador5 = Senamon("Vander", 1, "Volador", 98, 87, 105, 67, "Este senamon es conocido por su gran defensa y su resistencia en combate.");
      senamones['Volador']?.add(volador5); 
      

      //Fuego
      Senamon fuego1 = Senamon("Cech", 1, "Fuego", 78, 84, 78, 100, "Un senamon que puede volar y lanzar poderosos ataques de fuego.");
      senamones['Fuego']?.add(fuego1); // El ? es para errores
      Senamon fuego2 = Senamon("Lampard", 1, "Fuego", 95, 115, 90, 60, "Un senamon fuerte y con mucha presencia en el campo de batalla.");
      senamones['Fuego']?.add(fuego2);
      Senamon fuego3 = Senamon("Muldur", 1, "Fuego", 73, 76, 75, 100, "Un senamon elegante que controla el fuego de manera magistral.");
      senamones['Fuego']?.add(fuego3);
      Senamon fuego4 = Senamon("Frimppong", 1, "Fuego", 75, 90, 50, 95, "Un senamon oscuro que es temido por su ferocidad y poder.");
      senamones['Fuego']?.add(fuego4);
      Senamon fuego5 = Senamon("Jairhzino", 1, "Fuego", 65, 130, 60, 65, "Un senamon que posee un gran ataque físico, ideal para combates directos.");
      senamones['Fuego']?.add(fuego5);

      //Electrico
      Senamon electrico1 = Senamon("Eusebio", 1, "Eléctrico", 90, 90, 85, 100, "Un senamon legendario que vuela a gran velocidad y lanza potentes rayos.");
      senamones['Electrico']?.add(electrico1);
      Senamon electrico2 = Senamon("Pele", 1, "Eléctrico", 65, 65, 60, 130, "Un senamon extremadamente rápido, conocido por su gran velocidad."); 
      senamones['Electrico']?.add(electrico2); 
      Senamon electrico3 = Senamon("Walker", 1, "Eléctrico", 90, 75, 60, 45, "Un senamon robusto que destaca por su poderoso ataque especial.");
      senamones['Electrico']?.add(electrico3);
      Senamon electrico4 = Senamon("Baquembauer", 1, "Eléctrico", 75, 123, 67, 95, "Un senamon fuerte y ágil que puede desatar una gran energía eléctrica.");
      senamones['Electrico']?.add(electrico4);
      Senamon electrico5 = Senamon("Poe", 1, "Eléctrico", 60, 45, 40, 95, "Un senamon pequeño pero astuto, capaz de sorprender a sus oponentes.");
      senamones['Electrico']?.add(electrico5);

      //Agua
      Senamon agua1 = Senamon("Guz", 1, "Agua", 95, 90, 85, 100, "Un senamon que se transforma de un pequeño Magikarp en un poderoso dragón marino.");
      senamones['Agua']?.add(agua1);
      Senamon agua2 = Senamon("Añep", 2, "Agua", 130, 110, 95, 65, "Un senamon que puede manipular el agua y usarlo a su favor en combate.");
      senamones['Agua']?.add(agua2);
      Senamon agua3 = Senamon("Son", 3, "Agua", 79, 100, 105, 78, "Un senamon que cuenta con cañones de agua en su espalda, capaz de lanzar potentes chorros.");
      senamones['Agua']?.add(agua3);
      Senamon agua4 = Senamon("Nakata", 4, "Agua", 130, 85, 80, 60, "Un senamon amigable que ayuda a los viajeros en el mar.");
      senamones['Agua']?.add(agua4);
      Senamon agua5 = Senamon("Macall", 5, "Agua", 90, 75, 75, 70, "Un senamon que puede controlar la lluvia y atraer nubes.");
      senamones['Agua']?.add(agua5);

      //Hierva
      Senamon hierba1 = Senamon("Venusaur", 1, "Hierba", 80, 82, 83, 80, "Un senamon con una enorme planta en su espalda que libera polen.");
      senamones['Hierva']?.add(hierba1);
      Senamon hierba2 = Senamon("Lurantis", 2, "Hierba", 70, 105, 90, 45, "Un senamon elegante que es experto en el combate cuerpo a cuerpo.");
      senamones['Hierva']?.add(hierba2);
      Senamon hierba3 = Senamon("Torterra", 3, "Hierba", 95, 109, 105, 56, "Un senamon que puede causar terremotos y tiene un ecosistema en su espalda.");
      senamones['Hierva']?.add(hierba3);
      Senamon hierba4 = Senamon("Sceptile", 4, "Hierba", 70, 110, 65, 120, "Un senamon ágil que se mueve rápidamente por los árboles.");
      senamones['Hierva']?.add(hierba4);
      Senamon hierba5 = Senamon("Chesnaught", 5, "Hierba", 88, 107, 122, 64, "Un senamon defensivo que protege a los más débiles con su armadura.");
      senamones['Hierva']?.add(hierba5);
          
      
 

      // Inicializa el mapa para cada jugador
      for (var jugador in listaJugadores) {
        senamonesPorJugador[jugador.nombre] = {};
      }

      // Bucle para que cada jugador elija un Senamon de cada tipo
      for (var tipo in senamones.keys) {
        for (var jugador in listaJugadores) {
          console.setBackgroundColor(ConsoleColor.magenta); // COLOR DE FONDO
          console.setForegroundColor(ConsoleColor.black);
          console.writeLine('Lista de Senamones de $tipo a escoger:', TextAlignment.center);
          console.resetColorAttributes();
          for (int j = 0; j < senamones[tipo]!.length; j++) {
            console.writeLine('${j + 1}. ${senamones[tipo]![j]}');
          }
          console.setBackgroundColor(ConsoleColor.cyan); 
          console.setForegroundColor(ConsoleColor.black);
          console.write('Seleccione un Senamon de $tipo (1-${senamones[tipo]!.length}) para ${jugador.nombre}: ');
          console.resetColorAttributes();
          int seleccion = int.parse(console.readLine()!) - 1;
          Senamon senamonSeleccionado = senamones[tipo]!.removeAt(seleccion);
          senamonesPorJugador[jugador.nombre]![tipo] = senamonSeleccionado;

          console.setBackgroundColor(ConsoleColor.green);
          console.setForegroundColor(ConsoleColor.black);
          console.writeLine('${jugador.nombre} ha seleccionado:');
          console.resetColorAttributes();
          console.writeLine('$senamonSeleccionado');
          console.clearScreen();         

        }
      }

      // Mostrar un resumen de Senamones seleccionados por cada jugador
      for (var jugador in listaJugadores) {
        
        
        console.setBackgroundColor(ConsoleColor.green);
        console.setForegroundColor(ConsoleColor.black);
        console.writeLine('Resumen de Senamones para ${jugador.nombre}:',TextAlignment.center);
        console.resetColorAttributes();
        senamonesPorJugador[jugador.nombre]!.forEach((tipo, senamon) {
          console.setBackgroundColor(ConsoleColor.cyan); // COLOR DE FONDO
          console.setForegroundColor(ConsoleColor.black);
          console.writeLine('Senamon de $tipo:');
          console.resetColorAttributes();
          console.writeLine('${senamon.nombre}');
          console.writeLine('${senamon.descripcion}');
        });
      }
      console.readLine();
    }

    void cambiarSenamones(List<Jugador> listaJugadores, Map<String, Map<String, Senamon>> senamonesPorJugador, Console console) {
      if (listaJugadores.isEmpty || senamonesPorJugador.isEmpty) {
        console.setBackgroundColor(ConsoleColor.red);
        console.writeLine("Primero debe crear jugadores y seleccionar Senamones.", TextAlignment.center);
        return;
      }

      console.writeLine("Escoja un jugador para cambiar los Senamones:");
      for (int i = 0; i < listaJugadores.length; i++) {
        console.writeLine("${i + 1}. ${listaJugadores[i].nombre}");
      }

      int seleccionJugador = int.parse(console.readLine()!) - 1;
      Jugador jugadorSeleccionado = listaJugadores[seleccionJugador];

      // Asegúrate de que tiene Senamones seleccionados previamente
      if (senamonesPorJugador[jugadorSeleccionado.nombre] == null) {
        console.setBackgroundColor(ConsoleColor.red);
        console.writeLine("${jugadorSeleccionado.nombre} no ha seleccionado ningún Senamon.");
        return;
      }

      // Senamones disponibles
      Map<String, List<Senamon>> senamonesDisponibles = {
        'Fuego': [],
        'Agua': [],
        'Hierva': [],
        'Volador': [],
        'Electrico': [],
      };

      // Asegúrate de que los Senamones están cargados en senamonesDisponibles
      // (Esto debe hacerse de manera similar a cómo lo hiciste en `seleccionarSenamones`)
      // Puedes reutilizar la lógica de carga de senamones de la función anterior.

      console.writeLine("*" * 40);
      console.writeLine("Cambiar Senamones para ${jugadorSeleccionado.nombre}:");

      for (var tipo in senamonesDisponibles.keys) {
        // Mostrar Senamones actuales del jugador
        Senamon? senamonActual = senamonesPorJugador[jugadorSeleccionado.nombre]![tipo];

        // Mostrar los Senamones disponibles (excepto el actual)
        console.writeLine("Senamones de $tipo disponibles:");
        List<Senamon> senamonesFiltrados = senamonesDisponibles[tipo]!.where((senamon) => senamon != senamonActual).toList();

        for (int i = 0; i < senamonesFiltrados.length; i++) {
          console.writeLine("${i + 1}. ${senamonesFiltrados[i].nombre}");
        }

        console.write("Seleccione un nuevo Senamon de $tipo (1-${senamonesFiltrados.length}) o 0 para mantener el actual: ");
        int seleccion = int.parse(console.readLine()!);

        if (seleccion > 0 && seleccion <= senamonesFiltrados.length) {
          Senamon nuevoSenamon = senamonesFiltrados[seleccion - 1];
          console.writeLine("${jugadorSeleccionado.nombre} ha cambiado su Senamon de $tipo a: ${nuevoSenamon.nombre}");
          senamonesPorJugador[jugadorSeleccionado.nombre]![tipo] = nuevoSenamon; // Asigna el nuevo Senamon
        } else {
          console.writeLine("${jugadorSeleccionado.nombre} mantiene su Senamon actual de $tipo: ${senamonActual?.nombre}");
        }
      }

      console.writeLine("*" * 40);
      console.writeLine("Resumen actualizado de Senamones para ${jugadorSeleccionado.nombre}:");
      senamonesPorJugador[jugadorSeleccionado.nombre]!.forEach((tipo, senamon) {
        console.writeLine('Senamon de $tipo: ${senamon.nombre}');
      });
      console.readLine();
    }

    void entrenarSenamon(List<Jugador> listaJugadores, Map<String, Map<String, Senamon>> senamonesPorJugador, Console console) {
      // Preguntar cuál jugador quiere entrenar su Senamon
      console.writeLine('¿Qué jugador desea entrenar su Senamon?');

      for (int i = 0; i < listaJugadores.length; i++) {
        console.writeLine('${i + 1}. ${listaJugadores[i].nombre} (${listaJugadores[i].victorias} victorias)');
      }

      String? inputJugador = console.readLine();
      int? jugadorSeleccionado = int.tryParse(inputJugador!);

      if (jugadorSeleccionado == null || jugadorSeleccionado < 1 || jugadorSeleccionado > listaJugadores.length) {
        console.writeLine('Selección inválida.');
        return;
      }

      Jugador jugador = listaJugadores[jugadorSeleccionado - 1];

      // Verificar si tiene victorias
      if (jugador.victorias == 0) {
        console.writeLine('${jugador.nombre} no tiene victorias suficientes para entrenar un Senamon.');
        return;
      }

      // Mostrar los Senamones del jugador
      Map<String, Senamon> senamonesJugador = senamonesPorJugador[jugador.nombre]!;
      console.writeLine('Elige el Senamon que quieres entrenar:');

      List<Senamon> listaSenamones = senamonesJugador.values.toList();
      for (int i = 0; i < listaSenamones.length; i++) {
        console.writeLine('${i + 1}. ${listaSenamones[i].nombre} (Puntos de Salud: ${listaSenamones[i].puntosSalud})');
      }

      String? inputSenamon = console.readLine();
      int? senamonSeleccionado = int.tryParse(inputSenamon!);

      if (senamonSeleccionado == null || senamonSeleccionado < 1 || senamonSeleccionado > listaSenamones.length) {
        console.writeLine('Selección inválida.');
        return;
      }

      Senamon senamon = listaSenamones[senamonSeleccionado - 1];

      // Otorgar puntos adicionales en función de las victorias
      int puntosDisponibles = jugador.victorias * 50; // Cada victoria tendra un valor de 50 puntos
      //Mostramos el jugador y la cantidade puntos disponibles nuevamente
      console.writeLine('${jugador.nombre} tiene $puntosDisponibles puntos disponibles para entrenar a ${senamon.nombre}.');

      // Mostrar menú para seleccionar cuántos puntos asignar
      console.writeLine('Elige cuántos puntos quieres asignar a la vida de este Senamon:');
      console.writeLine('1. 10 puntos');
      console.writeLine('2. 20 puntos');
      console.writeLine('3. 30 puntos');

      String? inputPuntos = console.readLine();
      int? puntosAsignados;

      switch (inputPuntos) {
        case '1':
          puntosAsignados = 10;
          break;
        case '2':
          puntosAsignados = 20;
          break;
        case '3':
          puntosAsignados = 30;
          break;
        default:
          console.writeLine('Selección inválida.');
          return;
      }

      // Verificar si tiene suficientes puntos para asignar
      if (puntosAsignados > puntosDisponibles) {
        console.writeLine('No tienes suficientes puntos para asignar esa cantidad.');
        return;
      }

      // Incrementar la vida del Senamon
      senamon.puntosSalud += puntosAsignados;
      console.writeLine('${senamon.nombre} ha recibido $puntosAsignados puntos adicionales de vida. Ahora tiene ${senamon.puntosSalud} puntos de vida.');

      // Restar los puntos asignados de los puntos disponibles del jugador
      jugador.victorias -= puntosAsignados ~/ 50;  // Descontar victorias usadas
    }


    while (true) {
      final key = console.readKey();

      if (key.controlChar == ControlCharacter.arrowDown) {
        subMenuIndex = (subMenuIndex + 1) % subMenuOptions.length;
      } else if (key.controlChar == ControlCharacter.arrowUp) {
        subMenuIndex =
            (subMenuIndex - 1 + subMenuOptions.length) % subMenuOptions.length;
      } else if (key.char == ' ') {
        // Este case usa el nombre de las listas del sub menú para realizar las verificaciones
        switch (subMenuOptions[subMenuIndex]) {
          case '1. Crear Jugadores':
            if (menuName == 'Agregar Jugadores') {
              CrearJugador(console);
            }
            break;
          case '1. Elegir Senamon':
            if (menuName == 'Elegir Senamon') {
              seleccionarSenamones(listaJugadores, senamonesPorJugador, console);
            }
            break;
          case '2. Cambiar Senamon':
            if (menuName == 'Elegir Senamon') {
              cambiarSenamones(listaJugadores, senamonesPorJugador, console);
            }
            break;

          case '1. Iniciar':
            if (menuName == 'Iniciar Batallas') {
              //MonedaDeAzar(console);
              console.setBackgroundColor(ConsoleColor.red);
              console.writeLine('Iniciando batallas...', TextAlignment.center);
              console.resetColorAttributes();
              console.clearScreen();
              //Aqui seguirian las batallas
              IniciarBatalla.iniciar(listaJugadores,senamonesPorJugador);

            } 
            break;
          case '1. Ver mis puntos':
            console.writeLine('Lista de Jugadores y sus Puntos:', TextAlignment.center);
        
            // Mostrar lista de jugadores con sus puntos
           if (listaJugadores.isEmpty) {
                console.writeLine('No hay jugadores en la lista.', TextAlignment.center);
            } else {
                  // Mostrar los jugadores y los puntos disponibles en base a las victorias
                  for (int i = 0; i < listaJugadores.length; i++) {
                      Jugador jugador = listaJugadores[i];
                      int puntosDisponibles = jugador.victorias * 50; // Cada victoria equivale a 50 puntos
                      console.writeLine(
                          '${i + 1}. ${jugador.nombre} Tiene $puntosDisponibles  de Puntos disponibles', 
                          TextAlignment.center
                      );
                  }
              }
            break;
          case '2. Entrenar Senamon':
            if (menuName == 'Entrenar Senamon') { 
              console.setBackgroundColor(ConsoleColor.red);
              console.writeLine('Entrenando Senamon...', TextAlignment.center);
              console.resetColorAttributes();
              entrenarSenamon(listaJugadores, senamonesPorJugador, console);
            }
            break;
          case '1. Ver jugador con más victorias':
            if (menuName == 'Jugador con más Victorias') {
              console.setBackgroundColor(ConsoleColor.yellow);
              console.setForegroundColor(ConsoleColor.black);
              console.writeLine('Mostrando jugador con más victorias...', TextAlignment.center);
              console.resetColorAttributes();

              if (listaJugadores.isEmpty) {
                console.writeLine('No hay jugadores en la lista.', TextAlignment.center);
              } else {
                // Encontrar el jugador con más victorias
                Jugador jugadorTop = listaJugadores.reduce((jugador1, jugador2) =>
                    jugador1.victorias > jugador2.victorias ? jugador1 : jugador2);

                console.writeLine( 'El jugador con más victorias es:', TextAlignment.center);
                console.writeLine( ' ${jugadorTop.nombre} con ${jugadorTop.victorias} victorias.', TextAlignment.center);
              }
            }
            break;
          case '0. Volver':
            return;
          default:
            console.clearScreen();
            console.writeLine(
                'Opción seleccionada: ${subMenuOptions[subMenuIndex]}', TextAlignment.center);
            break;
        }

        console.writeLine(
            'Presione cualquier tecla para regresar al menú anterior.', TextAlignment.center);
        console.readKey();
        displaySubMenu();
      }

      displaySubMenu();
    }
  }
  
 

  // Mostrar el menú principal
  displayMenu(mainMenuOptions);

  while (true) {
    final key = console.readKey();

    if (key.controlChar == ControlCharacter.arrowDown) {
      selectedIndex = (selectedIndex + 1) % mainMenuOptions.length;
    } else if (key.controlChar == ControlCharacter.arrowUp) {
      selectedIndex =
          (selectedIndex - 1 + mainMenuOptions.length) % mainMenuOptions.length;
    } else if (key.char == ' ') {
      if (selectedIndex == mainMenuOptions.length - 1) {
        console.clearScreen();
        console.setBackgroundColor(ConsoleColor.blue);
        console.setForegroundColor(ConsoleColor.white);
        console.writeLine('Saliendo...', TextAlignment.center);
        console.resetColorAttributes();
        exit(0);
      } else {
        handleSubMenu(mainMenuOptions[selectedIndex].split('. ')[1]);
        displayMenu(mainMenuOptions);
      }
    }

    displayMenu(mainMenuOptions);

  }
}
