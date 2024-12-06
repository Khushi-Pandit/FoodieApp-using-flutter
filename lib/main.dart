import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Catering Service',
      theme: ThemeData(
        primaryColor: Colors.green.shade700,
        // accentColor: Colors.amber.shade600,
        brightness: Brightness.light,
        textTheme: TextTheme(
          bodyLarge: TextStyle(fontSize: 18, color: Colors.black87, fontFamily: 'Serif'),
          bodySmall: TextStyle(fontSize: 14, color: Colors.black54, fontFamily: 'Serif'),
          bodyMedium: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.green.shade700),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            // primary: Colors.green.shade800,
            // onPrimary: Colors.white,
            textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 25),
          ),
        ),
        cardTheme: CardTheme(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          elevation: 8,
        ),
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Catering Service', style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Serif',color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.green.shade800,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Header Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ChoiceChip(
                  label: Text('Breakfast', style: TextStyle(color: Colors.white)),
                  selected: true,
                  selectedColor: Colors.green.shade600,
                  onSelected: (selected) {},
                ),
                ChoiceChip(
                  label: Text('Lunch & Dinner', style: TextStyle(color: Colors.black)),
                  selected: false,
                  selectedColor: Colors.green.shade600,
                  onSelected: (selected) {},
                ),
                ChoiceChip(
                  label: Text('Snacks', style: TextStyle(color: Colors.black)),
                  selected: false,
                  selectedColor: Colors.green.shade600,
                  onSelected: (selected) {},
                ),
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.green.shade200,
                        child: Icon(Icons.fastfood, color: Colors.green.shade800),
                      ),
                      title: Text(
                        'Indian Soiree',
                        style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Serif'),
                      ),
                      subtitle: Text('₹299 per plate',
                          style: TextStyle(color: Colors.black54,fontSize: 18)),
                      trailing: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12)))
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PlatterDetailScreen(),
                            ),
                          );
                        },
                        child: Text('Customize',style: TextStyle(color: Colors.white),),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PlatterDetailScreen extends StatefulWidget {
  @override
  _PlatterDetailScreenState createState() => _PlatterDetailScreenState();
}

class _PlatterDetailScreenState extends State<PlatterDetailScreen> {
  int totalGuests = 1;
  int pricePerPlate = 299;

  void updatePrice(int guests) {
    // Dynamic Pricing Logic
    setState(() {
      totalGuests = guests;
      pricePerPlate = 299 - ((guests / 1500) * (299 - 189)).toInt();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Platter Details', style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Serif',color: Colors.white)),
        backgroundColor: Colors.green.shade800,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'South Indian Breakfast',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total Guests:', style: Theme.of(context).textTheme.bodyMedium),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        if (totalGuests > 1) {
                          updatePrice(totalGuests - 1);
                        }
                      },
                      icon: Icon(Icons.remove_circle_outline, color: Colors.green.shade800),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.green.shade50,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(totalGuests.toString(),
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                    IconButton(
                      onPressed: () {
                        if (totalGuests < 1500) {
                          updatePrice(totalGuests + 1);
                        }
                      },
                      icon: Icon(Icons.add_circle_outline, color: Colors.green.shade800),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            Text('Price per Plate: ₹$pricePerPlate',
                style: Theme.of(context).textTheme.bodyMedium),
            Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12))
                )
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OrderReviewScreen(
                      totalGuests: totalGuests,
                      pricePerPlate: pricePerPlate,
                    ),
                  ),
                );
              },
              child: Center(
                child: Text('Proceed to Review',style: TextStyle(color: Colors.white),),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class OrderReviewScreen extends StatelessWidget {
  final int totalGuests;
  final int pricePerPlate;

  OrderReviewScreen({required this.totalGuests, required this.pricePerPlate});

  @override
  Widget build(BuildContext context) {
    int totalPrice = totalGuests * pricePerPlate;
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Review', style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Serif',color: Colors.white)),
        backgroundColor: Colors.green.shade800,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Miller Breakfast', style: Theme.of(context).textTheme.bodyLarge),
            SizedBox(height: 20),
            Text('Total Guests: $totalGuests', style: Theme.of(context).textTheme.bodyLarge),
            Text('Price per Plate: ₹$pricePerPlate', style: Theme.of(context).textTheme.bodyLarge),
            Spacer(),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total Price: ₹$totalPrice', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12))
                    )
                  ),
                  onPressed: () {
                    // Place Order Logic
                  },
                  child: Center(
                    child: Text('Place Order',style: TextStyle(color: Colors.white),),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
