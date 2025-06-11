import 'package:flutter/material.dart';
import 'package:servana/view/screens/section_3/home_screen.dart';

class WalletScreen extends StatefulWidget {
  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  final double walletBalance = 120.00;

  final List<Map<String, dynamic>> transactions = [
    {"id": "#1284", "amount": -30.0, "date": "10 June"},
    {"id": "#1233", "amount": 50.0, "date": "5 June"},
    {"id": "#1232", "amount": -20.0, "date": "5 June"},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? Colors.black : Colors.white;

    return Scaffold(
      backgroundColor: bgColor,
    //  backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title:  Text("Wallet"),
        centerTitle: true,
        backgroundColor: Colors.teal,
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            color: Colors.teal,
            padding: const EdgeInsets.only(bottom: 16),
            child: Column(
              children: [
                const SizedBox(height: 7),
                Image.asset(
                  'assets/images/wallet.png',
                  height: 170,
                ),
                // const SizedBox(height: 3),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.orange[50],
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(color: Colors.black12, blurRadius: 10),
                    ],
                  ),
                  child: Column(
                    children: [
                      const Text(
                        "Your Balance",
                        style: TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "\$${walletBalance.toStringAsFixed(2)}",
                        style: const TextStyle(
                          fontSize: 34,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.teal,
                            ),
                            icon: const Icon(Icons.add),
                            label: const Text("Add Money"),
                            onPressed: () {},
                          ),
                          const SizedBox(width: 10),
                          OutlinedButton.icon(
                            icon: const Icon(Icons.arrow_back),
                            label: const Text("Withdraw"),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomeScreen(),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Transaction History",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: transactions.length,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemBuilder: (context, index) {
                final tx = transactions[index];
                final bool isPositive = tx['amount'] > 0;

                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: isPositive ? Colors.green : Colors.red,
                      child: Icon(
                        isPositive ? Icons.add : Icons.remove,
                        color: Colors.white,
                      ),
                    ),
                    title: Text(tx['id']),
                    subtitle: Text(tx['date']),
                    trailing: Text(
                      "${isPositive ? '+' : '-'}\$${tx['amount'].abs()}",
                      style: TextStyle(
                        color: isPositive ? Colors.green : Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
