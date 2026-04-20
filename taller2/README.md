# Actividad: Asincronía y Concurrencia en Flutter

## Conceptos Aplicados

1. **Future / Async / Await**: Utilizados en FutureView para simular peticiones a un servidor (I/O Bound) sin bloquear la aplicación.
2. **Timer**: Implementado en TimerView para crear un cronómetro que actualiza la UI cada 100ms. Se limpia en el método dispose.
3. **Isolate**: Usado en IsolateView para realizar una suma matemática de 100 millones de ciclos en un hilo separado del principal (CPU Bound).

## Flujo de Pantallas

- **Home**: Dashboard de bienvenida.
- **Future**: Pantalla con un CircularProgressIndicator que cambia a un GridView tras 5 segundos.
- **Timer**: Cronómetro con control de flujo (inicio/pausa/reinicio).
- **Isolate**: Ejecución de tarea pesada con comunicación por puertos entre hilos.
