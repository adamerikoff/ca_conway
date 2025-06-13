# **ca_conway**  
**Eine Ruby-Implementierung von Conways "Spiel des Lebens" (Game of Life)**  

📌 **Ein zellulärer Automat nach den Regeln von John Horton Conway** – simuliert evolutionäre Muster durch einfache Nachbarschaftsregeln.  

🔗 **Referenzen:**  
- [Conways Spiel des Lebens (Wikipedia)](https://de.wikipedia.org/wiki/Conways_Spiel_des_Lebens)  
- [Ruby-Programmiersprache](https://www.ruby-lang.org/)  

---

### **Funktionsweise**  
Das Programm modelliert ein 2D-Gitter von Zellen, die lebendig (`#`) oder tot (`.`) sein können. Jede Generation berechnet sich nach Conways klassischen Regeln:  
1. **Überleben:** Eine lebende Zelle mit 2 oder 3 Nachbarn bleibt am Leben.  
2. **Sterben:** Eine lebende Zelle mit weniger als 2 oder mehr als 3 Nachbarn stirbt.  
3. **Geburt:** Eine tote Zelle mit genau 3 Nachbarn wird lebendig.  

---

### **Features**  
- **Ruby-optimierte Logik** (nutzt z. B. `Array`-Manipulationen für effiziente Nachbarschaftsprüfungen).  
- **Kommandozeilen-Interface (CLI)** zur interaktiven Steuerung (Start/Pause/Reset).  
- **Anpassbare Grid-Größen** und Startmuster (z. B. Gleiter, Blinker, zufällige Besiedlung).  

---

### **Screenshots** *(Beispielplatzhalter – füge eigene Bilder ein!)*  
| ![Startgeneration](https://via.placeholder.com/300x200/222/fff?text=Initial+Grid) | ![Evolution](https://via.placeholder.com/300x200/222/fff?text=Generation+5) |  
|:--:|:--:|  
| *Startkonfiguration* | *Muster nach 5 Generationen* |  

---

### **Installation & Nutzung**  
```bash
git clone https://github.com/dein-username/ca_conway.git  
cd ca_conway  
run.sh start 
```  

---