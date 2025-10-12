// ignore_for_file: file_names

library;

import 'package:FitVise/auth/auth_service.dart';

int pageIndex = 0;
int? currentHeight = 0;
int? currentWeight = 0;
int targetKg = 0;

String classCode = "XXXXXX";
String currentEmail = AuthService().getCurrentUserEmail().toString();
String currentUsername = "user";
String userStatus = "Normal";

bool isTeacher = false;
bool isPremium = false;

final date = DateTime.now();

Map<String, dynamic> segak = {
  "Push up": 0,
  "Sit up": 0, // ringkuk tubi separa
  "Step test": 0, // naik turun bangku
  "Sit and Reach": 0, // jangakuan melunjur : the value is based on mark
  "Overall": '',
};

List exercise = [
  [
    [
      'Push Up',
      '15 times',
      'assets/GIF FitVise/Push Up.gif',
      'Spread your fingers to really engage your upper body muscles, Erik says. Extend your legs, placing your feet hip distance apart, and engage your core to form a straight line from your head to your ankles. With control, bend your elbows to lower your entire body toward the ground.',
      'assets/icons/pushup.png',
    ],
    [
      'Plank',
      '1 min',
      'assets/GIF FitVise/Plank.gif',
      'Press your hands and knees to the floor with your back in a neutral position and your wrists aligned directly under your shoulders. Gaze about one foot in front of you. Your nose should point toward the floor and the back of your neck should be parallel to the ceiling',
      'assets/icons/plank.png',
    ],
    [
      'Cardio',
      '10 min',
      'lib/assets/Dance.gif', //  This is a placeholder image path
      'Cardio, short for cardiovascular exercise, is any activity that raises your heart rate and breathing rate. It helps improve the health of your heart and lungs, burns calories, and increases your overall fitness. Good examples of cardio include walking, running, cycling, swimming, dancing, and jumping rope.',
      'assets/icons/treadmill.png',
    ],
  ],
  [
    [
      'Push Up',
      '20 times',
      'assets/GIF FitVise/Push Up.gif',
      'Spread your fingers to really engage your upper body muscles, Erik says. Extend your legs, placing your feet hip distance apart, and engage your core to form a straight line from your head to your ankles. With control, bend your elbows to lower your entire body toward the ground.',
      'assets/icons/pushup.png',
    ],
    [
      'Jogging',
      '1km',
      'assets/GIF FitVise/Jogging.gif',
      'Start jogging at a slow, steady pace that allows you to breathe comfortably and hold a conversation. If you get tired, its okay to switch between jogging and walking. Keep your posture upright, your head facing forward, and your arms relaxed and bent at your sides.',
      'assets/icons/running.png',
    ],
    [
      'Squats',
      '20 times',
      'assets/GIF FitVise/Squat.gif',
      'To squat, stand with your feet shoulder-width apart and your back straight. Bend your knees and push your hips back like youre sitting in a chair. Lower down until your thighs are parallel to the floor, then push through your heels to stand back up. Keep your chest up and knees aligned with your toes.',
      'assets/icons/squat.png',
    ],
  ],
  [
    [
      'Squats',
      '10 times',
      'assets/GIF FitVise/Squat.gif',
      'To squat, stand with your feet shoulder-width apart and your back straight. Bend your knees and push your hips back like youre sitting in a chair. Lower down until your thighs are parallel to the floor, then push through your heels to stand back up. Keep your chest up and knees aligned with your toes.',
      'assets/icons/squat.png',
    ],
    [
      'Dance',
      '10 min',
      'lib/assets/Dance.gif', // This is a placeholder image path
      'To dance, start by choosing music you enjoy. Feel the beat and move your body to the rhythm. Keep your knees slightly bent and stay relaxed. Begin with simple steps, like side-to-side or forward and back. Watch dance videos or follow tutorials to learn new moves.',
      'assets/icons/dance.png',
    ],
    [
      'Walking',
      '1 Hour',
      'assets/GIF FitVise/Walk.gif',
      'just walk normally',
      'assets/icons/walk.png',
    ],
  ],
  [
    [
      'Wall Push Up',
      '10 times',
      'assets/GIF FitVise/Wall Push Up.gif',
      'Stand facing a wall, about an arms length away. Place your hands on the wall at shoulder height and shoulder-width apart. Lean towards the wall, bending your elbows, then push back to the starting position. Keep your body straight and core engaged.',
      'assets/icons/wall.png',
    ],
    [
      'Walking',
      '30 min',
      'assets/GIF FitVise/Walk.gif',
      'just walk normally',
      'assets/icons/walk.png',
    ],
    [
      'Squat on Chair',
      '10 times',
      'assets/GIF FitVise/Squat On Chair.gif',
      'Stand in front of a chair with your feet shoulder-width apart. Lower your body as if you are going to sit down, keeping your knees behind your toes. When your thighs are parallel to the ground, pause, then push through your heels to stand back up.',
      'assets/icons/chair.png',
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

int getTargetCalories(String status, String meal) {
  switch (status) {
    case 'Underweight':
      return meal == 'Breakfast'
          ? 700
          : meal == 'Snack'
          ? 500
          : meal == 'Lunch'
          ? 800
          : meal == 'Dinner'
          ? 800
          : 0;
    case 'Normal':
      return meal == 'Breakfast'
          ? 500
          : meal == 'Snack'
          ? 400
          : meal == 'Lunch'
          ? 600
          : meal == 'Dinner'
          ? 600
          : 0;
    case 'Overweight':
      return meal == 'Breakfast'
          ? 400
          : meal == 'Snack'
          ? 300
          : meal == 'Lunch'
          ? 600
          : meal == 'Dinner'
          ? 450
          : 0;
    case 'Obesity':
      return meal == 'Breakfast'
          ? 300
          : meal == 'Snack'
          ? 150
          : meal == 'Lunch'
          ? 500
          : meal == 'Dinner'
          ? 400
          : 0;
    default:
      return 0;
  }
}

// Table for breakfast calorie
final Map<String, List<Map<String, dynamic>>> dietData = {
  "Breakfast": [
    {"name": "Scrambled Eggs", "serving": "2 large eggs", "calories": 140},
    {"name": "Boiled Eggs", "serving": "2 large eggs", "calories": 150},
    {"name": "Toast (white bread)", "serving": "1 slice", "calories": 80},
    {"name": "Wholemeal Bread", "serving": "1 slice", "calories": 70},
    {"name": "Kaya Toast", "serving": "2 slices", "calories": 320},
    {"name": "Peanut Butter Toast", "serving": "2 slices", "calories": 350},
    {"name": "Oatmeal", "serving": "1 bowl", "calories": 150},
    {"name": "Cereal with Milk", "serving": "1 bowl", "calories": 200},
    {"name": "Roti Canai", "serving": "1 piece", "calories": 300},
    {"name": "Nasi Lemak", "serving": "1 plate", "calories": 450},
    {"name": "Coffee", "serving": "1 cup (240ml)", "calories": 5},
    {"name": "Latte", "serving": "1 cup (240ml)", "calories": 190},
    {"name": "Cappuccino", "serving": "1 cup (240ml)", "calories": 120},
  ],
  "Lunch": [
    {"name": "Nasi Lemak", "serving": "1 plate", "calories": 450},
    {"name": "Chicken Rice", "serving": "1 plate", "calories": 600},
    {"name": "Fried Rice", "serving": "1 plate", "calories": 630},
    {"name": "Chapati & Dhal", "serving": "2 pieces + dhal", "calories": 320},
    {
      "name": "Vegetable Stir-Fry with Rice",
      "serving": "1 plate",
      "calories": 400,
    },
    {"name": "Curry Laksa", "serving": "1 bowl", "calories": 550},
    {"name": "Mee Goreng Mamak", "serving": "1 plate", "calories": 650},
    {"name": "Salad with Chicken", "serving": "1 bowl", "calories": 300},
    {"name": "Sandwich (Tuna)", "serving": "1 sandwich", "calories": 350},
    {"name": "Soup with Bread", "serving": "1 bowl + bread", "calories": 280},
    {"name": "Iced Lemon Tea", "serving": "1 glass (250ml)", "calories": 90},
    {"name": "Orange Juice", "serving": "1 glass (250ml)", "calories": 110},
    {"name": "Apple Juice", "serving": "1 glass (250ml)", "calories": 115},
    {"name": "Soft Drink (Coke)", "serving": "1 can (330ml)", "calories": 140},
    {"name": "Iced Chocolate", "serving": "1 glass (250ml)", "calories": 220},
    {"name": "Bubble Milk Tea", "serving": "1 cup (500ml)", "calories": 350},
  ],
  "Snack": [
    {"name": "Banana", "serving": "1 medium", "calories": 105},
    {"name": "Apple", "serving": "1 medium", "calories": 95},
    {"name": "Orange", "serving": "1 medium", "calories": 85},
    {"name": "Granola Bar", "serving": "1 bar", "calories": 120},
    {"name": "Milo", "serving": "1 cup", "calories": 165},
    {"name": "Teh Tarik", "serving": "1 cup", "calories": 120},
    {"name": "Yogurt (low-fat)", "serving": "1 small cup", "calories": 100},
    {"name": "Mixed Nuts", "serving": "30g handful", "calories": 180},
    {"name": "Popcorn (light)", "serving": "3 cups", "calories": 90},
    {"name": "Protein Shake", "serving": "1 scoop + milk", "calories": 200},
    {"name": "Coffee", "serving": "1 cup (240ml)", "calories": 5},
    {"name": "Latte", "serving": "1 cup (240ml)", "calories": 190},
    {"name": "Cappuccino", "serving": "1 cup (240ml)", "calories": 120},
    {"name": "Green Tea", "serving": "1 cup (240ml)", "calories": 2},
    {"name": "Iced Lemon Tea", "serving": "1 glass (250ml)", "calories": 90},
    {"name": "Orange Juice", "serving": "1 glass (250ml)", "calories": 110},
    {"name": "Apple Juice", "serving": "1 glass (250ml)", "calories": 115},
    {"name": "Soft Drink (Coke)", "serving": "1 can (330ml)", "calories": 140},
    {"name": "Iced Chocolate", "serving": "1 glass (250ml)", "calories": 220},
    {"name": "Bubble Milk Tea", "serving": "1 cup (500ml)", "calories": 350},
  ],
  "Dinner": [
    {"name": "Grilled Fish", "serving": "150g", "calories": 250},
    {"name": "Steamed Vegetables", "serving": "1 cup", "calories": 80},
    {"name": "Grilled Chicken Breast", "serving": "150g", "calories": 280},
    {"name": "Tofu Stir-Fry", "serving": "1 plate", "calories": 200},
    {"name": "Vegetable Soup", "serving": "1 bowl", "calories": 150},
    {"name": "Spaghetti Aglio Olio", "serving": "1 plate", "calories": 400},
    {"name": "Brown Rice with Veggies", "serving": "1 plate", "calories": 350},
    {"name": "Salmon Teriyaki", "serving": "150g + sauce", "calories": 360},
    {"name": "Caesar Salad", "serving": "1 bowl", "calories": 280},
    {"name": "Iced Lemon Tea", "serving": "1 glass (250ml)", "calories": 90},
    {"name": "Orange Juice", "serving": "1 glass (250ml)", "calories": 110},
    {"name": "Apple Juice", "serving": "1 glass (250ml)", "calories": 115},
    {"name": "Soft Drink (Coke)", "serving": "1 can (330ml)", "calories": 140},
    {"name": "Iced Chocolate", "serving": "1 glass (250ml)", "calories": 220},
    {"name": "Bubble Milk Tea", "serving": "1 cup (500ml)", "calories": 350},
  ],
};
