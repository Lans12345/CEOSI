import 'package:ceosi_app/constants/colors.dart';
import 'package:ceosi_app/screens/ceosi_company_app/widgets/addbutton_widget.dart';
import 'package:ceosi_app/screens/ceosi_company_app/widgets/addtextformfield_widget.dart';
import 'package:ceosi_app/screens/ceosi_company_app/widgets/drawer_widget.dart';
import 'package:ceosi_app/screens/ceosi_company_app/widgets/dialog_widget.dart';
import 'package:ceosi_app/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AddTeamScreen extends StatefulWidget {
  const AddTeamScreen({super.key});

  @override
  State<AddTeamScreen> createState() => _AddTeamScreenState();
}

class _AddTeamScreenState extends State<AddTeamScreen> {
  final GlobalKey<FormState> _addTeamFormKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _positionController = TextEditingController();
  final _departmentController = TextEditingController();
  final _emailController = TextEditingController();
  final _birthdateController = TextEditingController();
  final bool _isProcessing = false;
  File? _pickedImage;

  @override
  void dispose() {
    _nameController.dispose();
    _positionController.dispose();
    _departmentController.dispose();
    _emailController.dispose();
    _birthdateController.dispose();
    super.dispose();
  }

  void _pickDatePicker() async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1990),
        lastDate: DateTime(2050));

    if (pickedDate != null) {
      String formattedDate = DateFormat('MM-dd-yyyy').format(pickedDate);

      setState(() {
        _birthdateController.text = formattedDate;
      });
    } else {
      return null;
    }
  }

  displayEmployeePhoto() {
    if (_pickedImage == null) {
      return const AssetImage('assets/images/profile.png');
    } else {
      return FileImage(_pickedImage!);
    }
  }

  Future<void> _showSelectionDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) => DialogWidget(
            imageFromGallery: handleImageFromGallery,
            imageFromCamera: handleImageFromCamera));
  }

  handleImageFromGallery() async {
    final XFile? pickedImage = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (pickedImage != null) {
      setState(() {
        _pickedImage = File(pickedImage.path);
        Navigator.of(context).pop();
      });
    }
  }

  handleImageFromCamera() async {
    final XFile? pickedImage = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 80);
    if (pickedImage != null) {
      setState(() {
        _pickedImage = File(pickedImage.path);
        Navigator.of(context).pop();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: CustomColors.greyAccent,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _addTeamFormKey,
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                  onTap: () {
                    _showSelectionDialog(context);
                  },
                  child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Stack(children: [
                        CircleAvatar(
                            radius: 65,
                            backgroundImage: displayEmployeePhoto()),
                        CircleAvatar(
                            radius: 65,
                            backgroundColor: Colors.black54,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(
                                    Icons.add_photo_alternate,
                                    size: 35,
                                    color: Colors.white,
                                  )
                                ]))
                      ]))),
              const SizedBox(
                height: 10,
              ),
              AddtextformfieldWidget(
                textFieldController: _nameController,
                label: 'Name',
              ),
              const SizedBox(
                height: 10,
              ),
              AddtextformfieldWidget(
                textFieldController: _positionController,
                label: 'Position',
              ),
              const SizedBox(
                height: 10,
              ),
              AddtextformfieldWidget(
                textFieldController: _departmentController,
                label: 'Department',
              ),
              const SizedBox(
                height: 10,
              ),
              AddtextformfieldWidget(
                textFieldController: _emailController,
                label: 'Email',
              ),
              const SizedBox(
                height: 10,
              ),
              AddtextformfieldWidget(
                textFieldController: _birthdateController,
                label: 'Birth Date',
                readOnly: true,
                onTap: () {
                  _pickDatePicker();
                },
              ),
              const SizedBox(
                height: 30,
              ),
              AddButtonWidget(
                borderRadius: 100,
                buttonHeight: 50,
                buttonWidth: 300,
                textWidget: const BoldTextWidget(
                    color: Colors.white, fontSize: 18, text: 'Add Team'),
                formKey: _addTeamFormKey,
                isProcessing: _isProcessing,
                validated: () {
                  if (_addTeamFormKey.currentState!.validate()) {
                    print('Validated');
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
