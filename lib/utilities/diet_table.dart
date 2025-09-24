import 'package:flutter/material.dart';
import 'package:FitVise/Global.dart';

class DietTable extends StatefulWidget {
  final String mealType; // Breakfast, Lunch, Snack, Dinner

  const DietTable({super.key, required this.mealType});

  @override
  State<DietTable> createState() => _DietTableState();
}

class _DietTableState extends State<DietTable> {
  late List<Map<String, dynamic>> foods;
  late List<bool> selected; // track selected items
  late final int target;

  @override
  void initState() {
    super.initState();
    foods = dietData[widget.mealType] ?? [];
    target = getTargetCalories(userStatus, widget.mealType);
    selected =
        List<bool>.filled(foods.length, false); // none selected initially
  }

  int get totalCalories {
    int sum = 0;
    for (int i = 0; i < foods.length; i++) {
      if (selected[i]) sum += foods[i]["calories"] as int;
    }
    return sum;
  }

  @override
  Widget build(BuildContext context) {
    if (foods.isEmpty) {
      return Center(
        child: Text("No data available for ${widget.mealType}"),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Table
        Table(
          border: TableBorder.all(color: Colors.grey),
          columnWidths: const {
            0: FlexColumnWidth(2),
            1: FlexColumnWidth(2),
            2: FlexColumnWidth(1),
            3: FlexColumnWidth(1),
          },
          children: [
            // Header row
            const TableRow(
              decoration: BoxDecoration(color: Colors.black26),
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Food",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Serving",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Calories",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Select",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ],
            ),

            // Dynamic food rows
            ...List.generate(foods.length, (i) {
              return TableRow(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(foods[i]["name"]),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(foods[i]["serving"]),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("${foods[i]["calories"]} kcal"),
                  ),
                  Center(
                    child: Checkbox(
                      value: selected[i],
                      onChanged: (bool? value) {
                        setState(() {
                          selected[i] = value ?? false;
                        });
                      },
                    ),
                  ),
                ],
              );
            }),

            // Total row
            TableRow(
              decoration: BoxDecoration(
                color: totalCalories < (target + 50)
                    ? Colors.white10
                    : Colors.redAccent,
              ),
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Total",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("—"),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "$totalCalories kcal",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                const SizedBox(),
              ],
            ),
          ],
        )
      ],
    );
  }
}
