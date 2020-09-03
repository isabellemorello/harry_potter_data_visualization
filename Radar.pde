import java.util.Map;

class Radar {
  // Dati
  String[] labels;
  int numberOfVertices;
  int radius;
  int size;
  color colors;
  int[] countAllData;

  // Costruttore
  Radar(String[] labels, int radius, int size, color colors, int[] countAllData) {
    this.labels = labels;
    this.numberOfVertices = labels.length;
    this.radius = radius;
    this.size = size;
    this.colors = colors;
    // this.houseData = houseData;
    this.countAllData = countAllData;
  }

  // Metodi
  private void drawGrid() {
    for (int i = 0; i <= this.size; i += 10) {
      float diam = map(i, 0, 100, 0, 180);
      if (i % 50 == 0) {
        stroke(255, 85);
        fill(255, 100);
        textFont(font2);
        textSize(12);
        textAlign(CENTER, TOP);
        text(i/10, 0 + 15, 0 + diam/2);
      } else {
        stroke(255, 55);
      }
      noFill();
      ellipse(0, 0, diam, diam);
    }
  }

  private void drawVertices() {
    float insideAngle = 360 / this.numberOfVertices;

    for (int i = 0; i < this.numberOfVertices; i++) {
      float xpos = 240 * sin(i * radians(insideAngle));
      float ypos = 240 * -cos(i * radians(insideAngle));

      line(0, 0, xpos, ypos);
      fill(255);
      textFont(font);
      text(this.labels[i], xpos + 10, ypos + 10);
    }
  }

  void drawRadarChart() {
    float insideAngle = 360 / this.numberOfVertices;

    fill(this.colors, 64);
    strokeWeight(2.5);
    stroke(this.colors, 255);
    beginShape();
    for (int i = 0; i < this.countAllData.length; i++) {
      float xpos = map(this.countAllData[i], 0, 100, 0, 180 * 5) * sin(i * radians(insideAngle));
      float ypos = map(this.countAllData[i], 0, 100, 0, 180 * 5) * -cos(i * radians(insideAngle));
      vertex(xpos, ypos);
    }
    endShape(CLOSE);
  }

  void drawRadar() {
    this.drawGrid();
    this.drawVertices();
    this.drawRadarChart();
  }
} 
