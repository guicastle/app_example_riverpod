## 🧠 **Resumo do Projeto**
## Exemplo (`read`, `watch`, `listen`)** com o Riverpod:

---

## 🔹 1. `ref.read(provider)` – Lê o valor **atual**, **sem reagir** a mudanças

📦 **Exemplo:**

```dart
final contadorProvider = StateProvider<int>((ref) => 0);
```

```dart
ElevatedButton(
  onPressed: () {
    final contador = ref.read(contadorProvider); // lê o valor atual
    print("Contador atual: $contador");
  },
  child: Text('Mostrar valor'),
),
```

👉 Útil para **ações pontuais**, como em `onPressed`, `initState`, etc.

---

## 🔹 2. `ref.watch(provider)` – Reage a mudanças, **reconstrói o widget**

📦 **Exemplo:**

```dart
@override
Widget build(BuildContext context, WidgetRef ref) {
  final contador = ref.watch(contadorProvider); // reconstrói ao mudar

  return Text('Valor: $contador');
}
```

👉 Ideal para usar no `build()` ou `ConsumerWidget`, onde você quer que **atualize na tela** automaticamente.

---

## 🔹 3. `ref.listen(provider, callback)` – Observa mudanças, **sem rebuild**

📦 **Exemplo com mensagem quando muda:**

```dart
@override
void initState() {
  super.initState();

  ref.listen<int>(
    contadorProvider,
    (previous, next) {
      if (next > 5) {
        print("Contador passou de 5!");
      }
    },
  );
}
```

👉 Excelente para **efeitos colaterais** como:

* Mostrar `SnackBar`
* Redirecionar tela
* Log de evento

---

## ⚖️ Resumo rápido:

| Comando        | Quando usar                              | Reage a mudança? | Reconstroi Widget? |
| -------------- | ---------------------------------------- | ---------------- | ------------------ |
| `ref.read()`   | Uso pontual (ex: botão, init)            | ❌                | ❌                  |
| `ref.watch()`  | Mostrar valor na UI / rebuild automático | ✅                | ✅                  |
| `ref.listen()` | Efeitos colaterais (snackbar, logs)      | ✅                | ❌                  |

---


