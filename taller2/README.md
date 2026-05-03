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

# Taller 1 - Distribución de APK con Firebase App Distribution

1. **Generar APK De La Aplicacion**  
   Se ejecuta `flutter build apk` en la raíz del proyecto. Se obtiene el archivo `app-release.apk` en `build/app/outputs/flutter-apk/`.

2. **Subir a Firebase App Distribution**
   - Acceder a Firebase App Distributionribution
   - Subir el APK.
   - Crear grupo `QA_Clase`.
   - Rellenar las **Release Notes**.
   - Publicar la versión.

3. **Notificar a los testers**  
   Firebase envía automáticamente un correo electrónico a los miembros del grupo con un enlace de instalación.

4. **Instalación por parte del tester**
   - El tester recibe el correo, hace clic en el enlace y acepta la invitación para luego instalar y testear.

5. **Actualización a una nueva versión**
   - Se hacen cambios en el codigo.
   - Se compila un nuevo APK.
   - Se sube a Firebase App Distribution como una nueva versión.
   - El grupo `QA_Clase` recibe una nueva notificación para actualizar.

## Publicación

1. **Pre-requisitos locales**
   - Tener Flutter instalado y configurado.
   - Tener acceso al proyecto Firebase (con los permisos de editor).
   - Tener copia local del archivo `google-services.json` en `android/app/`, y poner dependencias y plugins en `android/bluid.gradle.kts` y `android/app/build.gradle.kts`.

2. **Actualizar versión**
   - Editar `pubspec.yaml` → `version: 1.0.1+2` (formato: `versión+piso`).

3. **Generar APK de release**
   ```bash
   flutter clean
   flutter pub get
   flutter build apk
   ```
