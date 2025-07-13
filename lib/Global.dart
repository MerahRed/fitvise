library;

int pageIndex = 0;
int? currentheight = 0;
int? currentweight = 0;
int targetKg = 0;

String username = "user";
String user_status = "Normal";

final date = DateTime.now();

List exercise = [
  [
    [
      'Push Up',
      '15 times',
      'lib/assets/push_up.jpeg',
      'Spread your fingers to really engage your upper body muscles, Erik says. Extend your legs, placing your feet hip distance apart, and engage your core to form a straight line from your head to your ankles. With control, bend your elbows to lower your entire body toward the ground.'
    ],
    [
      'Plank',
      '1 min',
      'lib/assets/plank.jpeg',
      'Press your hands and knees to the floor with your back in a neutral position and your wrists aligned directly under your shoulders. Gaze about one foot in front of you. Your nose should point toward the floor and the back of your neck should be parallel to the ceiling'
    ],
    [
      'Cardio',
      '10 min',
      'lib/assets/cardio.jpeg',
      'Cardio, short for cardiovascular exercise, is any activity that raises your heart rate and breathing rate. It helps improve the health of your heart and lungs, burns calories, and increases your overall fitness. Good examples of cardio include walking, running, cycling, swimming, dancing, and jumping rope.'
    ]
  ],
  [
    [
      'Push Up',
      '20 times',
      'lib/assets/push_up.jpeg',
      'Spread your fingers to really engage your upper body muscles, Erik says. Extend your legs, placing your feet hip distance apart, and engage your core to form a straight line from your head to your ankles. With control, bend your elbows to lower your entire body toward the ground.'
    ],
    [
      'Jogging',
      '1km',
      'lib/assets/jogging.jpeg',
      'Start jogging at a slow, steady pace that allows you to breathe comfortably and hold a conversation. If you get tired, its okay to switch between jogging and walking. Keep your posture upright, your head facing forward, and your arms relaxed and bent at your sides.'
    ],
    [
      'Squats',
      '20 times',
      'lib/assets/squat.jpeg',
      'To squat, stand with your feet shoulder-width apart and your back straight. Bend your knees and push your hips back like youre sitting in a chair. Lower down until your thighs are parallel to the floor, then push through your heels to stand back up. Keep your chest up and knees aligned with your toes.'
    ]
  ],
  [
    ['Walking', '1 hour', 'lib/assets/walking.jpeg', 'just walk normally'],
    [
      'Dance',
      '10 min',
      'lib/assets/dance.jpeg',
      'To dance, start by choosing music you enjoy. Feel the beat and move your body to the rhythm. Keep your knees slightly bent and stay relaxed. Begin with simple steps, like side-to-side or forward and back. Watch dance videos or follow tutorials to learn new moves.'
    ],
    [
      'Cycling',
      '1km',
      'lib/assets/cycling.jpeg',
      'To cycle, start by adjusting your seat to a comfortable height. Wear a helmet for safety. Get on the bike and place your feet on the pedals. Push down on one pedal to start moving. Keep your balance and steer with the handlebars. Pedal smoothly and use brakes to slow down or stop. Follow traffic rules and stay aware of your surroundings.'
    ]
  ],
  [
    [
      'Wall Push Up',
      '10 times',
      'lib/assets/wall_push_up.jpeg',
      'Stand facing a wall, about an arms length away. Place your hands on the wall at shoulder height and shoulder-width apart. Lean towards the wall, bending your elbows, then push back to the starting position. Keep your body straight and core engaged.'
    ],
    ['Walking', '30 min', 'lib/assets/walking.jpeg', 'just walk normally'],
    [
      'Squat on Chair',
      '10 times',
      'lib/assets/squat_on_chair.jpeg',
      'Stand in front of a chair with your feet shoulder-width apart. Lower your body as if you are going to sit down, keeping your knees behind your toes. When your thighs are parallel to the ground, pause, then push through your heels to stand back up.'
    ],
  ],
];

// 0 => breakfast, 1 => snack, 2 => lunch, 3 => Dinner
List kcal = [
  [700, 500, 800, 800], //underweight
  [500, 400, 600, 600], //normal
  [400, 300, 600, 450], //overweight
  [300, 150, 500, 400], //obesity
];

int exerciseIndex = 1;
int kcalIndex = 1;
