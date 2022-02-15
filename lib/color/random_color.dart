import 'dart:math' as matematik;
import 'dart:ui';

//Rastgele Renk oluştur
Color randowColors() {
  return Color.fromARGB(
      matematik.Random().nextInt(255),
      matematik.Random().nextInt(255),
      matematik.Random().nextInt(255),
      matematik.Random().nextInt(255));
}
