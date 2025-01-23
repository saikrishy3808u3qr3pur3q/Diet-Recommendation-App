// import 'package:flutter/material.dart';
//
// class ERecipePage extends StatelessWidget {
//   final String foodName;
//   final String description;
//   final List<String> steps;
//   final List<String> ingredients;
//
//   const ERecipePage({
//     Key? key,
//     required this.foodName,
//     required this.description,
//     required this.steps,
//     required this.ingredients,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(foodName),
//         backgroundColor: Colors.blueAccent,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Description Section
//             Text(
//               'Description',
//               style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 8),
//             Text(description),
//             const SizedBox(height: 16),
//
//             // Ingredients Section
//             Text(
//               'Ingredients',
//               style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 8),
//             ...ingredients.map((ingredient) => Padding(
//               padding: const EdgeInsets.symmetric(vertical: 4.0),
//               child: Text('- $ingredient'),
//             )),
//
//             const SizedBox(height: 16),
//
//             // Steps Section
//             Text(
//               'Steps',
//               style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 8),
//             ...steps.asMap().entries.map((entry) => Padding(
//               padding: const EdgeInsets.symmetric(vertical: 4.0),
//               child: Text('${entry.key + 1}. ${entry.value}'),
//             )),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

class ERecipePage extends StatelessWidget {
  final String foodName;
  final String description;
  final List<String> steps;
  final List<String> ingredients;

  const ERecipePage({
    Key? key,
    required this.foodName,
    required this.description,
    required this.steps,
    required this.ingredients,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(foodName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Description
              Text(
                description,
                style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
              ),
              const SizedBox(height: 20),

              // Ingredients List
              const Text(
                'Ingredients',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              ...ingredients.map((ingredient) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text('- $ingredient', style: const TextStyle(fontSize: 16)),
                );
              }).toList(),
              const SizedBox(height: 20),

              // Preparation Steps
              const Text(
                'Preparation Steps',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              ...steps.asMap().entries.map((entry) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Text('${entry.key + 1}. ${entry.value}', style: const TextStyle(fontSize: 16)),
                );
              }).toList(),
            ],
          ),
        ),
      ),
    );
  }
}

