import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Product List'),
          actions: [
            IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CartPage()),
                );
              },
            )
          ],
        ),
        body: ProductList(),
      ),
    );
  }
}

class ProductList extends StatefulWidget {
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  List<Product> products = [
    Product(name: 'Pen ', price: 10),
    Product(name: 'Pencil ', price: 15),
    Product(name: 'cap ', price: 20),
    Product(name: 'water ', price: 10),
    Product(name: 'moneybag ', price: 150),
    Product(name: 'shapner ', price: 20),

  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(products[index].name),
          subtitle: Text('Price: \$${products[index].price.toStringAsFixed(2)}'),
          trailing: ProductCounter(
            product: products[index],
            onBuyNowPressed: () {
              setState(() {
                products[index].incrementCounter();
                if (products[index].counter == 5) {
                  _showCongratulationsDialog(products[index]);
                }
              });
            },
          ),
        );
      },
    );
  }

  void _showCongratulationsDialog(Product product) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Congratulations!'),
          content: Text('You\'ve bought 5 ${product.name}!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

class Product {
  final String name;
  final double price;
  int counter = 0;

  Product({required this.name, required this.price});

  void incrementCounter() {
    counter++;
  }
}

class ProductCounter extends StatelessWidget {
  final Product product;
  final Function()? onBuyNowPressed;

  ProductCounter({required this.product, required this.onBuyNowPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Qty: ${product.counter}'),
        SizedBox(width: 10),
        ElevatedButton(
          onPressed: onBuyNowPressed,
          child: Text('Buy Now'),
        ),
      ],
    );
  }
}

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int totalProductsBought = getTotalProductsBought();
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: Center(
        child: Text('Total Products Bought: $totalProductsBought'),
      ),
    );
  }

  int getTotalProductsBought() {
    // Calculate the total products bought from your data source (e.g., a cart).
    // You can implement your logic here.
    // For this example, we will return a static value.
    return 15;
  }
}
