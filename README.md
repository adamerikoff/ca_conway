Here's an improved version of your German README, focusing on clarity, flow, and slightly more engaging language, while maintaining all the essential information.

-----

# **ca\_conway**

## Eine Ruby-Implementierung von Conways "Spiel des Lebens"

-----

### **Projektübersicht**

**ca\_conway** ist eine dynamische Ruby-Implementierung von John Horton Conways berühmtem "Spiel des Lebens". Dieses faszinierende **zelluläre Automaten-System** simuliert die Entstehung komplexer evolutionärer Muster auf einem 2D-Gitter, basierend auf einfachen Nachbarschaftsregeln. Beobachten Sie, wie Leben entsteht, gedeiht und vergeht\!

-----

### **Grundlagen des Spiels**

Das "Spiel des Lebens" basiert auf einem Gitter von Zellen, die entweder **lebendig** (dargestellt als weiß) oder **tot** (dargestellt als schwarz) sein können. Jede neue Generation wird gemäß drei grundlegenden Regeln berechnet:

1.  **Überleben:** Eine lebende Zelle mit genau 2 oder 3 lebenden Nachbarn bleibt am Leben.
2.  **Sterben:** Eine lebende Zelle stirbt, wenn sie weniger als 2 lebende Nachbarn hat (Unterbevölkerung) oder mehr als 3 lebende Nachbarn hat (Überbevölkerung).
3.  **Geburt:** Eine tote Zelle wird lebendig, wenn sie genau 3 lebende Nachbarn hat.

-----

### **Features**

  * **Interaktive grafische Benutzeroberfläche (GUI):** Dank der Gosu-Bibliothek wird das Spielgeschehen in Echtzeit visualisiert.
  * **Toroidale Topologie (Wrap-around-Ränder):** Das Spielfeld ist wie ein Donut geformt. Zellen, die einen Rand verlassen, erscheinen am gegenüberliegenden Rand wieder. Dies ermöglicht die unendliche Bewegung von Mustern wie Gleitern.
  * **Anpassbare Simulationsgeschwindigkeit:** Steuern Sie, wie schnell sich die Generationen entwickeln, um Muster genauer zu beobachten.
  * **Echtzeit-Informationen:** Die aktuelle **Generationsnummer** und die **Anzahl der lebenden Zellen** werden kontinuierlich in der oberen linken Ecke angezeigt.
  * **Manuelle Zellsteuerung:** Klicken Sie mit der Maus auf eine Zelle, um ihren Zustand (lebendig/tot) jederzeit direkt zu ändern.
  * **Flexible Konfiguration:** Passen Sie die **Gittergröße** an und wählen Sie verschiedene **Startmuster** (z. B. zufällige Besiedlung).

-----

### **Screenshots**

-----

### **Installation & Nutzung**

Um **ca\_conway** auszuführen, benötigen Sie **Ruby** und die **Gosu-Bibliothek**.

1.  **Repository klonen:**

    ```bash
    git clone https://github.com/dein-username/ca_conway.git
    cd ca_conway
    ```

2.  **Gosu installieren:** Falls Gosu noch nicht auf Ihrem System installiert ist, tun Sie dies über RubyGems:

    ```bash
    gem install gosu
    ```

3.  **Simulation starten:**

    ```bash
    ./run.sh start
    ```

    *Hinweis: Stellen Sie sicher, dass sich `game_of_life.rb`, `Cell.rb` und `World.rb` im selben Verzeichnis befinden und die Datei `run.sh` ausführbar ist (falls nicht, führen Sie `chmod +x run.sh` aus).*

-----

### **Steuerung während der Simulation**

  * **Mausklick:** Klicken Sie auf eine Zelle, um ihren Zustand (`lebendig` / `tot`) umzuschalten.
  * **ESC-Taste:** Beendet die Anwendung.

-----

### **Referenzen**

  * [Conways Spiel des Lebens (Wikipedia)](https://de.wikipedia.org/wiki/Conways_Spiel_des_Lebens)
  * [Ruby-Programmiersprache](https://www.ruby-lang.org/)
  * [Gosu (2D Game Development Library)](https://www.libgosu.org/)