
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/wager_provider.dart';
import '../providers/auth_provider.dart'; // Assuming you have this for token
import '../widgets/custom_button.dart'; // Assuming you have a custom button widget

class CreateWagerScreen extends StatefulWidget {
  const CreateWagerScreen({Key? key}) : super(key: key);

  @override
  _CreateWagerScreenState createState() => _CreateWagerScreenState();
}

class _CreateWagerScreenState extends State<CreateWagerScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _outcomeAController = TextEditingController();
  final TextEditingController _outcomeBController = TextEditingController();
  
  DateTime _deadline = DateTime.now().add(const Duration(days: 7));

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _amountController.dispose();
    _outcomeAController.dispose();
    _outcomeBController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _deadline,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null && picked != _deadline) {
      setState(() {
        _deadline = picked;
      });
    }
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final wagerProvider = Provider.of<WagerProvider>(context, listen: false);
      
      final token = authProvider.token;
      if (token == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please connect your wallet first')),
        );
        return;
      }
      
      final success = await wagerProvider.createWager(
        title: _titleController.text,
        description: _descriptionController.text,
        deadline: _deadline,
        amount: double.parse(_amountController.text),
        outcomeA: _outcomeAController.text,
        outcomeB: _outcomeBController.text,
        token: token,
      );
      
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Wager created successfully!')),
        );
        Navigator.pop(context); // Go back to previous screen
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${wagerProvider.error}')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final wagerProvider = Provider.of<WagerProvider>(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Wager'),
      ),
      body: wagerProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      controller: _titleController,
                      decoration: const InputDecoration(
                        labelText: 'Title',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a title';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _descriptionController,
                      decoration: const InputDecoration(
                        labelText: 'Description',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 3,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a description';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _amountController,
                      decoration: const InputDecoration(
                        labelText: 'Amount',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter an amount';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Please enter a valid number';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Deadline: ${_deadline.toLocal().toString().split(' ')[0]}',
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () => _selectDate(context),
                          child: const Text('Select Date'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _outcomeAController,
                      decoration: const InputDecoration(
                        labelText: 'Outcome A',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter outcome A';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _outcomeBController,
                      decoration: const InputDecoration(
                        labelText: 'Outcome B',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter outcome B';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: _submitForm,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text('Create Wager'),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}