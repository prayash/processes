// Processes - Day 118
// Prayash Thapa - April 27, 2016

int num = 200;
ArrayList<Sparkle> particles = new ArrayList<Sparkle>();

boolean sensel_sensor_opened = false;

int WINDOW_WIDTH_PX = 1150;
//We will scale the height such that we get the same aspect ratio as the sensor
int WINDOW_HEIGHT_PX;
SenselDevice sensel;

int screen_x;
int screen_y;

// ************************************************************************************

void setup() {
  // size(600, 600);

  for (int i = 0; i < num; i++) particles.add(new Sparkle());

  DisposeHandler dh = new DisposeHandler(this);
  sensel = new SenselDevice(this);

  sensel_sensor_opened = sensel.openConnection();

  if(!sensel_sensor_opened) {
    println("Unable to open Sensel sensor!");
    exit();
    return;
  }

  //Init window height so that display window aspect ratio matches sensor.
  //NOTE: This must be done AFTER senselInit() is called, because senselInit() initializes
  //  the sensor height/width fields. This dependency needs to be fixed in later revisions
  WINDOW_HEIGHT_PX = (int) (sensel.getSensorHeightMM() / sensel.getSensorWidthMM() * WINDOW_WIDTH_PX);

  size(1200, 800);

  //Enable contact sending
  sensel.setFrameContentControl(SenselDevice.SENSEL_FRAME_CONTACTS_FLAG);

  //Enable scanning
  sensel.startScanning();
}

// ************************************************************************************

void draw() {
  fill(#E4E4E4, 30); noStroke();
  rect(0, 0, width, height);

  for (Sparkle s : particles) s.render();

  if (!sensel_sensor_opened) return;

  SenselContact[] c = sensel.readContacts();

  if(c == null) {
    println("NULL CONTACTS");
    return;
  }

  for(int i = 0; i < c.length; i++) {
    float force = c[i].total_force;

    float area = c[i].area_mm_sq;

    float sensor_x_mm = c[i].x_pos_mm;
    float sensor_y_mm = c[i].y_pos_mm;

    screen_x = (int) ((sensor_x_mm / sensel.getSensorWidthMM())  * WINDOW_WIDTH_PX);
    screen_y = (int) ((sensor_y_mm / sensel.getSensorHeightMM()) * WINDOW_HEIGHT_PX);

    float orientation = c[i].orientation_degrees;
    float major = c[i].major_axis_mm;
    float minor = c[i].minor_axis_mm;

    // NOTE: This assumes window is scaled similar to sensor:
    int screen_major = (int) ((major / sensel.getSensorWidthMM())  * WINDOW_WIDTH_PX);
    int screen_minor = (int) ((minor / sensel.getSensorWidthMM())  * WINDOW_WIDTH_PX);

    int id = c[i].id;
    int event_type = c[i].type;

    String event;
    switch (event_type)
    {
      case SenselDevice.SENSEL_EVENT_CONTACT_INVALID:
        event = "invalid";
        break;
      case SenselDevice.SENSEL_EVENT_CONTACT_START:
        sensel.setLEDBrightness(id, (byte)100); //turn on LED
        event = "start";
        break;
      case SenselDevice.SENSEL_EVENT_CONTACT_MOVE:
        event = "move";
        break;
      case SenselDevice.SENSEL_EVENT_CONTACT_END:
        sensel.setLEDBrightness(id, (byte)0);
        event = "end";
        break;
      default:
        event = "error";
    }

    println("Contact ID " + id + ", event=" + event + ", mm coord: (" + sensor_x_mm + ", " + sensor_y_mm + "), shape: (" + orientation + ", " + major + ", " + minor + "), area=" + area + ", force=" + force);

    if(true) // Set to false to just draw circles
    {
      float scale = (float)force / 10000.0f;
      if(scale > 1.0f) scale = 1.0f;

      color from = color(0, 102, 153);
      color to = color(204, 102, 0);
      color clr = lerpColor(from, to, scale);

      pushMatrix();
      translate( screen_x, screen_y );
      rotate( radians(orientation) );

      stroke(255);
      fill(clr);
      ellipse( 0, 0, screen_minor, screen_major);
      popMatrix();
    }
    else
    {
      float size = force / 100.0f;
      if(size < 10) size = 10;

      ellipse(screen_x, screen_y, size, size);
    }
  }
  if(c.length > 0)
    println("****");
}

// ************************************************************************************

class Sparkle {

  PVector location, direction;
  float angle = random(TWO_PI);
  float speed;

  Sparkle() {
    location = new PVector(width/2, height/2, random(2, 8));
    direction = new PVector(cos(angle) * 1, sin(angle) * 1);
    speed = random(3, 10);
  }

  void update() {
    angle = atan2(screen_x - location.y, screen_y - location.x);
    PVector target = new PVector(cos(angle), sin(angle));
    target.mult(0.075);

    direction.add(target);
    direction.normalize();

    PVector velocity = direction.get();
    velocity.mult(speed);
    location.add(velocity);

    if (location.x < 0) {
      location.x = 0;
      direction.x = direction.x * -1;
    } else if (location.x > width) {
      location.x = width;
      direction.x = direction.x * -1;
    } else if (location.y < 0) {
      location.y = 0;
      direction.y = direction.y * -1;
    } else if (location.y > height) {
      location.y = height;
      direction.y = direction.y * -1;
    }
  }

  void render() {
    update();
    noStroke(); fill(#008BCA, 105);
    ellipse(location.x, location.y, location.z, location.z);
  }
}

// ************************************************************************************

void mousePressed() {
  particles.clear(); setup();
}

void keyPressed() {
  if (key == 's') saveFrame("##.png");
}

public class DisposeHandler
{
  DisposeHandler(PApplet pa)
  {
    pa.registerMethod("dispose", this);
  }
  public void dispose()
  {
    println("Closing sketch");
    if(sensel_sensor_opened)
    {
      sensel.stopScanning();
      sensel.closeConnection();
    }
  }
}
