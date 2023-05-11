// Processes - Day 149
// Prayash Thapa - March 28, 2016


// **************************************************************


Points[] points;
float c, dc;


// **************************************************************


void setup() {
    size(800, 400);
    background(0);
  
    colorMode(HSB, 360, 100, 100, 100);
    c = random(360);
  
    // Create the points
    points = new Points[3];
    for (int i = 0; i < points.length; i++) {
        points[i] = new Points(random(width), random(height));
    }
}


// **************************************************************


void draw() {
    fill(0, 0, 0);
    noStroke();
    if (frameCount % 1700 == 0) {
        rect(0, 0, width, height);
    }
  
    // Draw circles from 3 points moving on smooth random trajectories.
    for (int i = 0; i < points.length; i++) {
        if (random(1) > 0.96) {
            points[i].setDir(random(-PI, PI));  //change direction sometimes
        }
        
        points[i].update();
        points[i].checkEdges();
    }
  
    // Set the style of the circle
    dc = map(millis(), 0, 150000, 0, 360);
    stroke((c + dc) % 360, 50, 100, 5);
    noFill();
  
    // Verifies if there is a circle and draw it
    float Det = (points[0].p.x * points[1].p.y)  + (points[1].p.x * points[2].p.y) + (points[2].p.x * points[0].p.y);
    Det -= (points[0].p.y * points[1].p.x)  + (points[1].p.y * points[2].p.x) + (points[2].p.y * points[0].p.x);
    
    if (abs(Det) > 50.) {
        circle(points);
    }
}


// **************************************************************


void circle(Points[] pts) {
    // Find the midpoints of 2 sides
    PVector[] mp = new PVector[2];
    for (int k = 0; k < mp.length; k++) {
        mp[k] = midpoint(pts[k].p, pts[k+1].p);
    }
  
    // Find the center of the circle
    PVector o = center(mp);
    
    // Calculate the radius
    float r = dist(o.x, o.y, pts[2].p.x, pts[2].p.y);
  
    // If not collinear display circle
    ellipse(o.x, o.y, 2*r, 2*r);
}


// **************************************************************


PVector midpoint(PVector A, PVector B) {
    float d = dist(A.x, A.y, B.x, B.y); //distance AB
    float theta = atan2(B.y - A.y, B.x - A.x); //inclination of AB

    PVector p = new PVector(A.x + d/2*cos(theta),   A.y + d/2*sin(theta), //midpoint
                    theta - HALF_PI);  //inclination of the bissecteur

    return p;
}


// **************************************************************


PVector center(PVector[] P) {
    PVector[] eq = new PVector[2];

    for (int i = 0; i < 2; i++) {
      float a = tan(P[i].z);
      eq[i] = new PVector (a, -1, -1 * (P[i].y - P[i].x * a));
    }

    float ox = (eq[1].y * eq[0].z - eq[0].y * eq[1].z) / (eq[0].x * eq[1].y - eq[1].x * eq[0].y);
    float oy =  (eq[0].x * eq[1].z - eq[1].x * eq[0].z) / (eq[0].x * eq[1].y - eq[1].x * eq[0].y);
    return new PVector(ox, oy);
}


// **************************************************************


class Points {
    PVector p, velocity, acceleration;

    Points(float x_, float y_) {
        p = new PVector(x_, y_, 1);
        velocity = new PVector(0, 0, 0);
        acceleration = new PVector(random(1), random(1), 0);
    }


    void setDir(float angle) {
        // Direction of the acceleration is defined by the new angle
        acceleration.set(cos(angle), sin(angle), 0);

        // Magnitude of the acceleration is proportional to the angle between acceleration and velocity
        acceleration.normalize();
        float dif = PVector.angleBetween(acceleration, velocity);
        dif = map(dif, 0, PI, 0.1, 0.001);
        acceleration.mult(dif);
    }

    void update() {
        velocity.add(acceleration);
        velocity.limit(1.5);
        p.add(velocity);
    }

    void checkEdges() {
        p.x = constrain(p.x, 0, width);
        p.y = constrain(p.y, 0, height);
    }
}
