import 'package:crud_assignment/models/product.dart';
import 'package:crud_assignment/screens/update_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart' as http;

class ProductItem extends StatefulWidget {
  const ProductItem({
    super.key, required this.product, required this.onDelete,
  });

  final Product product;
  final VoidCallback onDelete;
  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      tileColor: Colors.white,
      title: Text(widget.product.productName),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Product Code: ${widget.product.productCode}'),
          Text('Price: \$${widget.product.unitPrice}'),
          Text('Quantity: ${widget.product.quantity}'),
          Text('Total Price: \$${widget.product.totalPrice}'),
          const Divider(),
          ButtonBar(
            children: [
              TextButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return UpdateProductScreen(productId: widget.product.id,updateScreen:widget.onDelete ,);
                    }),
                  );
                },
                icon: const Icon(Icons.edit),
                label: const Text('Edit'),
              ),
              TextButton.icon(
                onPressed: () {
                  deleteProduct(widget.product.id);
                },
                icon: const Icon(
                  Icons.delete_outline,
                  color: Colors.red,
                ),
                label: const Text(
                  'Delete',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }


  Future<void> deleteProduct(String id) async {
    setState(() {
    });
    Uri url = Uri.parse('http://164.68.107.70:6060/api/v1/DeleteProduct/$id');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Product deleted successfully')),
        ); widget.onDelete();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to delete product: ${response.body}')),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $error')),
      );
    } finally {
      setState(() {
      });
    }
  }
}