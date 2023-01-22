import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/product.dart';
import 'package:shop_app/providers/prov_products.dart';

class EditProductScreen extends StatefulWidget {
  const EditProductScreen({super.key});
  static const routeName = "/edit-product-screen";

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _imageURLController = TextEditingController();
  final _imageURLFocusNode = FocusNode();
  final _formkey = GlobalKey<FormState>();
  var _editedProduct =
      Product(id: "", title: "", description: "", imageURL: "", price: 0);

  @override
  void initState() {
    // TODO: implement initState
    _imageURLFocusNode.addListener(_updateImageURL);
    super.initState();
  }

  @override
  void dispose() {
    _imageURLController.dispose();
    _imageURLFocusNode.removeListener(_updateImageURL);
    _imageURLFocusNode.dispose();
    super.dispose();
  }

  _updateImageURL() {
    if (!_imageURLFocusNode.hasFocus) {
      if (_imageURLController.text.isEmpty) {
        setState(() {});
        return;
      }
      if (!_imageURLController.text.startsWith("http") &&
          !_imageURLController.text.startsWith("https")) {
        return;
      }
      if (!_imageURLController.text.endsWith(".png") &&
          !_imageURLController.text.endsWith("jpg") &&
          !_imageURLController.text.endsWith("jpeg")) {
        return;
      }

      setState(() {});
    }
  }

  void saveForm() {
    final isValid = _formkey.currentState?.validate();
    if (!isValid!) {
      return;
    }
    _formkey.currentState?.save();
    Provider.of<Products>(context, listen: false).addProduct(_editedProduct);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Product"),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: saveForm,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
            key: _formkey,
            child: ListView(
              children: [
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please Enter Title";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(labelText: "Title"),
                  textInputAction: TextInputAction.next,
                  onSaved: (newValue) {
                    _editedProduct = _editedProduct.copyWith(title: newValue);
                  },
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please Enter Price";
                    }
                    if (double.tryParse(value) == null) {
                      return "Please Enter A Valid Number";
                    }
                    if (double.parse(value) <= 0) {
                      return "Price Must Be Greater Than 0";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(labelText: "Price"),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  onSaved: (newValue) {
                    _editedProduct =
                        _editedProduct.copyWith(price: double.parse(newValue!));
                  },
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please Enter Description";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(labelText: "Description"),
                  maxLines: 3,
                  keyboardType: TextInputType.multiline,
                  onSaved: (newValue) {
                    _editedProduct =
                        _editedProduct.copyWith(description: newValue);
                  },
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      margin: const EdgeInsets.only(top: 8, right: 10),
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.grey)),
                      child: _imageURLController.text.isEmpty
                          ? const Text("Enter an image URL")
                          : FittedBox(
                              fit: BoxFit.fill,
                              child: Image.network(_imageURLController.text),
                            ),
                    ),
                    Expanded(
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please Enter ImageURL";
                          }
                          if (!value.startsWith("http") &&
                              !value.startsWith("https")) {
                            return "Please Enter A Valid URL";
                          }
                          if (!value.endsWith(".png") &&
                              !value.endsWith("jpg") &&
                              !value.endsWith("jpeg")) {
                            return "Please Enter A Valid Image URL";
                          }
                          return null;
                        },
                        decoration:
                            const InputDecoration(labelText: "Image URL"),
                        keyboardType: TextInputType.url,
                        textInputAction: TextInputAction.done,
                        controller: _imageURLController,
                        focusNode: _imageURLFocusNode,
                        onEditingComplete: () {
                          setState(() {});
                        },
                        onSaved: (newValue) {
                          _editedProduct =
                              _editedProduct.copyWith(imageURL: newValue);
                        },
                      ),
                    )
                  ],
                )
              ],
            )),
      ),
    );
  }
}
