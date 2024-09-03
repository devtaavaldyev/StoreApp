import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskproject/future/data/model/store_model.dart';
import 'package:taskproject/future/presentation/provider/store_provider.dart';
import 'package:taskproject/future/presentation/widgets/custom_textfield.dart';

class CreateFormScreen extends StatefulWidget {
  @override
  _CreateFormScreenState createState() => _CreateFormScreenState();
}

class _CreateFormScreenState extends State<CreateFormScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final _formKey = GlobalKey<FormState>();

  TextEditingController _titleController = TextEditingController();

  TextEditingController _categoryController = TextEditingController();

  TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    StoreProvider storeProvider = Provider.of<StoreProvider>(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Add product'),
      ),
      body: Form(
        key: _formKey,
        child: Center(
          child: SingleChildScrollView(
            child: Consumer<StoreProvider>(
              builder: (context, state, _) {
                StoreModel user = state.thisProduct;

                return Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: <Widget>[
                      CustomTextField(
                          title: 'Title',
                          controller: _titleController,
                          onChange: (value) {
                            user.title = value;
                            // user.copyWith(title: _titleController.text = value);
                          },
                          validator: (value) {
                            if (value!.length < 1) {
                              return 'Title cannot be empty';
                            }
                            return null;
                          }),
                      CustomTextField(
                          title: 'Category',
                          controller: _categoryController,
                          onChange: (value) {
                            user.category = value;
                          },
                          validator: (value) {
                            if (value!.length < 1) {
                              return 'this line cannot be empty';
                            }
                            return null;
                          }),
                      CustomTextField(
                          title: 'Description',
                          controller: _descriptionController,
                          onChange: (value) {
                            user.description = value;
                          },
                          validator: (value) {
                            if (value!.length < 1) {
                              return 'Description cannot be empty';
                            }
                            return null;
                          }),
                      ElevatedButton(
                        child: Text('Создать'),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            user.id == null
                                ? storeProvider.createProduct(
                                    product: user as StoreModel)
                                : storeProvider.createProduct(
                                    product: user as StoreModel);
                            Navigator.pop(context);
                          }
                        },
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
