import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Provider de contador
final contadorProvider = StateProvider<int>((ref) => 0);

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: HomePage());
  }
}

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    // Assista ao estado do contador
    final contador = ref.watch(contadorProvider);

    // Escute mudanças do contador (com callback)
    ref.listen<int>(contadorProvider, (previous, next) {
      print("Contador anterior: $previous");
      print("Contador atual: $next");

      if (next > 5) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Contador passou de 5!")));
      }
    });

    return Scaffold(
      appBar: AppBar(title: const Text("Exemplo de Riverpod")),
      body: Center(
        child: Text(
          'Valor atual: $contador', // A UI será reconstruída quando o contador mudar
          style: const TextStyle(fontSize: 24),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final atual = ref.read(contadorProvider); // Acesso pontual ao valor
          ref.read(contadorProvider.notifier).state =
              atual + 1; // Incrementa o contador
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
