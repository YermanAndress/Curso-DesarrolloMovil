import 'package:go_router/go_router.dart';

import 'package:taller2/views/paso_parametros/paso_parametros_screen.dart';
import 'package:taller2/views/paso_parametros/detalle_screen.dart';
import 'package:taller2/views/ciclo_vida/ciclo_vida_screen.dart';
import 'package:taller2/views/isolate/isolate_view.dart';
import 'package:taller2/views/future/future_view.dart';
import 'package:taller2/views/home/home_screen.dart';
import 'package:taller2/views/timer/timer_view.dart';

import 'package:taller2/views/pokemons/pokemon_detail_view.dart';
import 'package:taller2/views/pokemons/pokemon_list_view.dart';

import 'package:taller2/views/parqueadero/parqueadero_list_view.dart';

final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(), // Usa HomeView
    ),
    // Rutas para el paso de parámetros
    GoRoute(
      path: '/paso_parametros',
      builder: (context, state) => const PasoParametrosScreen(),
    ),

    // !Ruta para el detalle con parámetros
    GoRoute(
      path:
          '/detalle/:parametro/:metodo', //la ruta recibe dos parametros los " : " indican que son parametros
      builder: (context, state) {
        //*se capturan los parametros recibidos
        // declarando las variables parametro y metodo
        // es final porque no se van a modificar
        final parametro = state.pathParameters['parametro']!;
        final metodo = state.pathParameters['metodo']!;
        return DetalleScreen(parametro: parametro, metodoNavegacion: metodo);
      },
    ),
    //!Ruta para el ciclo de vida
    GoRoute(
      path: '/ciclo_vida',
      name: 'ciclo_vida',
      builder: (context, state) => const CicloVidaScreen(),
    ),
    GoRoute(
      path: '/isolate',
      name: 'isolate',
      builder: (context, state) => const IsolateView(),
    ),
    GoRoute(
      path: '/future',
      name: 'future',
      builder: (context, state) => const FutureView(),
    ),
    GoRoute(
      path: '/timer',
      name: 'timer',
      builder: (context, state) => const TimerView(),
    ),
    //!Ruta para http
    GoRoute(
      path: '/pokemons',
      name: 'pokemons',
      builder: (context, state) => const PokemonListView(),
    ),
    //!Ruta para detalle de pokemones
    GoRoute(
      path: '/pokemon/:name', // se recibe el nombre del pokemon como parametro
      name: 'pokemon_detail',
      builder: (context, state) {
        final name =
            state.pathParameters['name']!; // se captura el nombre del pokemon.
        return PokemonDetailView(name: name);
      },
    ),
    GoRoute(
      path: '/parqueadero',
      name: 'parqueadero',
      builder: (context, state) => const ParqueaderoListView(),
    ),
  ],
);
