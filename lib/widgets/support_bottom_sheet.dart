import 'package:flutter/material.dart';
import '../config/email_config.dart';

class SupportBottomSheet extends StatefulWidget {
  const SupportBottomSheet({Key? key}) : super(key: key);

  @override
  State<SupportBottomSheet> createState() => _SupportBottomSheetState();
}

class _SupportBottomSheetState extends State<SupportBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  String _selectedApp = 'EasyDrill';
  final List<String> _apps = ['EasyDrill', 'JsonClock', 'Other'];

  Map<String, bool> _isHovering = {'send_button': false};

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      try {
        // Show loading indicator
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Colors.black.withOpacity(0.8),
              content: Row(
                children: [
                  CircularProgressIndicator(color: Colors.white),
                  SizedBox(width: 20),
                  Text(
                    "Sending email...",
                    style: TextStyle(color: Colors.white, fontFamily: 'D-Din'),
                  ),
                ],
              ),
            );
          },
        );

        // Send email using HTTP service
        final success = await EmailConfig.sendEmail(
          firstName: _firstNameController.text,
          lastName: _lastNameController.text,
          email: _emailController.text,
          subject: _subjectController.text,
          message: _messageController.text,
          app: _selectedApp,
        );

        // Close loading dialog
        if (mounted) Navigator.of(context).pop();

        if (success) {
          // Show success message
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Email sent successfully!',
                  style: TextStyle(fontFamily: 'D-Din'),
                ),
                backgroundColor: Colors.green,
              ),
            );

            // Clear form and close bottom sheet
            _formKey.currentState!.reset();
            _firstNameController.clear();
            _lastNameController.clear();
            _emailController.clear();
            _subjectController.clear();
            _messageController.clear();
            setState(() {
              _selectedApp = _apps[0];
            });

            Navigator.of(context).pop(); // Close bottom sheet
          }
        } else {
          throw 'Failed to send email';
        }
      } catch (e) {
        // Close loading dialog if open
        if (mounted && Navigator.of(context).canPop()) {
          Navigator.of(context).pop();
        }

        // Show error message
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Failed to send email: $e',
                style: TextStyle(fontFamily: 'D-Din'),
              ),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }

  Widget _buildStyledTextField({
    required TextEditingController controller,
    required String labelText,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      style: TextStyle(color: Colors.white, fontFamily: 'D-Din', fontSize: 16),
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(
          color: Colors.white70,
          fontFamily: 'D-Din',
          fontSize: 16,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(0),
          borderSide: BorderSide(color: Colors.white, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(0),
          borderSide: BorderSide(color: Colors.white, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(0),
          borderSide: BorderSide(color: Colors.red, width: 2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(0),
          borderSide: BorderSide(color: Colors.red, width: 2),
        ),
        errorStyle: TextStyle(color: Colors.red, fontFamily: 'D-Din'),
      ),
      validator: validator,
    );
  }

  Widget _buildStyledDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedApp,
      style: TextStyle(color: Colors.white, fontFamily: 'D-Din', fontSize: 16),
      dropdownColor: Colors.black,
      decoration: InputDecoration(
        labelText: 'Application',
        labelStyle: TextStyle(
          color: Colors.white70,
          fontFamily: 'D-Din',
          fontSize: 16,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(0),
          borderSide: BorderSide(color: Colors.white, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(0),
          borderSide: BorderSide(color: Colors.white, width: 2),
        ),
      ),
      items:
          _apps
              .map(
                (app) => DropdownMenuItem(
                  value: app,
                  child: Text(
                    app,
                    style: TextStyle(color: Colors.white, fontFamily: 'D-Din'),
                  ),
                ),
              )
              .toList(),
      onChanged: (value) {
        setState(() {
          _selectedApp = value!;
        });
      },
    );
  }

  Widget _buildStyledButton() {
    return MouseRegion(
      onEnter:
          (_) => setState(() {
            _isHovering['send_button'] = true;
          }),
      onExit:
          (_) => setState(() {
            _isHovering['send_button'] = false;
          }),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        width: double.infinity,
        decoration: BoxDecoration(
          color:
              _isHovering['send_button']! ? Colors.white : Colors.transparent,
          border: Border.all(color: Colors.white, width: 2),
          borderRadius: BorderRadius.circular(0),
        ),
        child: OutlinedButton(
          onPressed: _submitForm,
          style: OutlinedButton.styleFrom(
            backgroundColor: Colors.transparent,
            side: BorderSide(color: Colors.transparent, width: 2),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              'SEND',
              style: TextStyle(
                color:
                    _isHovering['send_button']! ? Colors.black : Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'D-Din',
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.9),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          // Handle bar
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            width: 50,
            height: 5,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(2.5),
            ),
          ),

          // Title
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              'SUPPORT',
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
                fontFamily: 'D-Din',
              ),
            ),
          ),

          // Form
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildStyledDropdown(),
                    SizedBox(height: 20),

                    Row(
                      children: [
                        Expanded(
                          child: _buildStyledTextField(
                            controller: _firstNameController,
                            labelText: 'First Name',
                            validator:
                                (value) =>
                                    value == null || value.isEmpty
                                        ? 'Please enter your first name'
                                        : null,
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: _buildStyledTextField(
                            controller: _lastNameController,
                            labelText: 'Last Name',
                            validator:
                                (value) =>
                                    value == null || value.isEmpty
                                        ? 'Please enter your last name'
                                        : null,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),

                    _buildStyledTextField(
                      controller: _emailController,
                      labelText: 'Email',
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                        if (!emailRegex.hasMatch(value)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),

                    _buildStyledTextField(
                      controller: _subjectController,
                      labelText: 'Subject',
                      validator:
                          (value) =>
                              value == null || value.isEmpty
                                  ? 'Please enter a subject'
                                  : null,
                    ),
                    SizedBox(height: 20),

                    _buildStyledTextField(
                      controller: _messageController,
                      labelText: 'Message',
                      maxLines: 5,
                      validator:
                          (value) =>
                              value == null || value.isEmpty
                                  ? 'Please enter your message'
                                  : null,
                    ),
                    SizedBox(height: 30),

                    _buildStyledButton(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
