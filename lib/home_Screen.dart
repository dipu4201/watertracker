import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _glassCountController =
  TextEditingController(text: '1');
  int count = 0;
  List<int> history = [];

  void _incrementCount() {
    int glassCount = int.tryParse(_glassCountController.text) ?? 1;
    setState(() {
      count += glassCount;
      history.add(count); // Record the current count into history
    });
    _glassCountController.clear(); // Clear the text field after incrementing count
  }

  Future<bool> _showDeleteHistoryItemDialog(int index) async {
    return await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: const Text(
            'Delete Item History',
            style: TextStyle(
              color: Colors.deepPurpleAccent,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: const Text(
            'Are you sure you want to delete this item?',
            style: TextStyle(fontSize: 16),
          ),
          actions: [
            TextButton(
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.grey),
              ),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: const Text(
                'Delete',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    ) ?? false;
  }

  // void _deleteHistoryItem(int index) async {
  //   bool shouldDelete = await _showDeleteHistoryItemDialog(index);
  //   if (shouldDelete) {
  //     setState(() {
  //       history.removeAt(index);
  //     });
  //   }
  // }

  void _clearHistory() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: const Text(
            'Clear History',
            style: TextStyle(
              color: Colors.redAccent,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: const Text(
            'Are you sure you want to clear the history?',
            style: TextStyle(fontSize: 16),
          ),
          actions: [
            TextButton(
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.grey),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text(
                'Clear',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                setState(() {
                  count = 0;
                  history.clear();
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: Colors.deepPurpleAccent,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.clear),
            onPressed: _clearHistory,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Tap Here To Drink Water',
              style: TextStyle(fontSize: 22),
            ),
            const SizedBox(height: 16),
            Text('Today\'s water intake: $count'),
            const SizedBox(height: 16),
            const SizedBox(height: 24),
            GestureDetector(
              onTap: _incrementCount,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(
                    color: Colors.amberAccent,
                    width: 8,
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(24.0),
                  child: Icon(
                    Icons.water_drop_outlined,
                    size: 32,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: 60,
              child: TextField(
                controller: _glassCountController,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'History',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.deepPurpleAccent),
            ),
            Expanded(
              child: Center(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ListView.builder(
                    itemCount: history.length,
                    itemBuilder: (context, index) {
                      return Dismissible(
                        key: UniqueKey(),
                        direction: DismissDirection.endToStart,
                        confirmDismiss: (direction) async {
                          return await _showDeleteHistoryItemDialog(index);
                        },
                        background: Container(
                          color: Colors.red,
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: const Icon(Icons.delete, color: Colors.white),
                        ),
                        onDismissed: (direction) {
                          setState(() {
                            history.removeAt(index);
                          });
                        },
                        child: ListTile(
                          title: Text('Glass Count: ${history[index]}'),
                          leading: const CircleAvatar(
                            child: Icon(Icons.water_drop), // Updated to an icon
                          ),
                        ),
                      );
                    },
                  )
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
