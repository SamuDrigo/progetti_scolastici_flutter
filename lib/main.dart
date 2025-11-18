import 'package:flutter/material.dart';
import 'package:esercizio_2_2/recipe.dart';
import 'package:esercizio_2_2/recipeDetail.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RecipesBookApp',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      ),
      home: const RecipeListState(title: 'Broccoli Recipes Book'),
    );
  }
}

class RecipeListState extends StatefulWidget {
  const RecipeListState({super.key, required this.title});
  final String title;

  @override
  State<RecipeListState> createState() => _RecipeListState();
}

class _RecipeListState extends State<RecipeListState> {
  final List<Recipe> recipes = [
    Recipe(
      title: 'Vellutata di Broccoli',
      ingredients: [
        '1) Broccoli  (450g);',
        '2) Patate (400g);',
        '3) 1 Porro;',
        '4) Timo (2 rametti);',
        '5) 700ml di brodo vegetale;',
        '6) Sale e pepe q.b.;',
        '7) Burro (30g);',
      ],
      steps: [
        '- Per preparare la vellutata ai broccoli iniziate mondando e tagliando a fette sottili il porro.',
        '- Poi sbucciate le patate e tagliatele a dadini. Lavate quindi i broccoli eliminando i gambi e dividendoli in cimette.',
        '- In un tegame capiente ponete il burro a fondere, aggiungete i porri e fateli appassire per qualche minuto a fiamma dolce.',
        '- e fateli appassire a fuoco basso per 10-15 minuti, senza fargli prendere colore.',
        '- Aggiungete nel tegame le patate e i broccoli e fateli rosolare per qualche minuto mescolando', 
        '- poi aggiungete il brodo vegetale caldo e continuate la cottura per circa 30 minuti a fuoco dolce, salando e pepando',
        '- Trascorso il tempo indicato, passate le verdure con un frullatore ad immersione. Rimettete la vellutata così ottenuta sul fuoco',
        '- aggiustate di sale e aggiungete qualche fogliolina di timo',
        '- Servite la vostra vellutata di broccoli ben calda. BUON APPETITO!',
      ],
      url: 'https://ricette.giallozafferano.it/Vellutata-di-broccoli.html',
    ),
    Recipe(
      title: 'Carbonara',
      ingredients: [
        '1) Spaghetti (320g);',
        '2) Guanciale (150g);',
        '3) Tuorli (6);',
        '4) Pecorino Romano DOP (50g);',
        '5) Pepe nero q.b.;',
      ],
      steps: [
        '- Per cominciare metitamo sul fuoco una pentola con l\'acqua salata per cuocere la pasta.',
        '- Nel frattempo eliminate la cotenna dal guanciale e tagliatelo prima a fette e poi a striscioline spesse circa 1cm',
        '- Versate i pezzetti di guanciale in una padella antiaderente e rosolate per circa 10 minuti a fiamma medio alta',
        '- Una volta che bolle mettete gli spaghetti nell\'acqua bollente e cuoceteli al dente',
        '- Intanto versate i tuorli in una ciotola',
        '- Aggiungete il Pecorino e insaporite con il pepe nero',
        '- Amalgamate il tutto con una frusta a mano, sino ad ottenere una crema liscia.',
        '- Intanto il guanciale sarà giunto a cottura; spegnete il fuoco e utilizzando un mestolo prelevatelo dalla padella, lasciando il fondo di cottura all\'interno della padella stessa ',
        '- Trasferite il guanciale in una ciotolina e tenetelo da parte.',
        '- Versate una mestolata d\'acqua della pasta in padella, insieme al grasso del guanciale.',
        '- Scolate la pasta al dente direttamente nel tegame con il fondo di cottura',
        '- Saltatela brevemente per insaporirla',
        '- Togliete dal fuoco e versate il composto di uova e Pecorino nel tegame.',
        '- Mescolate velocemente per amalgamare.',
        '- Aggiungete il guanciale e mescolate un\'ultima volta',
        '- Servite gli spaghetti alla carbonara aggiungendo del pecorino e un pizzico di pepe nero. BUON APPETITO!',
      ],
      url: 'https://ricette.giallozafferano.it/Spaghetti-alla-Carbonara.html'
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: recipes.length,
        itemBuilder: (context, index) {
          final recipe = recipes[index];
          return ListTile(
            title: Text(recipe.title),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RecipeDetailScreen(recipe: recipe),
                ),
              );
            },
            trailing: IconButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Link: ${recipe.url}')));
                }, 
              icon: Icon(Icons.link),
            ),
          );
        },
      ),
    );
  }
}
