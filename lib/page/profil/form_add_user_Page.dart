import 'package:flutter/material.dart';

class FormAddUserPage extends StatefulWidget {
  const FormAddUserPage({super.key});

  @override
  State<FormAddUserPage> createState() => _FormAddUserPageState();
}

class _FormAddUserPageState extends State<FormAddUserPage> {
  final _formKey = GlobalKey<FormState>();

  String? selectedUnit;
  final List<String> units = ["Unit A", "Unit B", "Unit C"];

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2E5D6F),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2E5D6F),
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Tambah User",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFFFFD700),
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
          ),
        ),
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Dropdown Unit
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: "Unit",
                  filled: true,
                  fillColor: Colors.green[50],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
                value: selectedUnit,
                items: units
                    .map((unit) => DropdownMenuItem(
                          value: unit,
                          child: Text(unit),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedUnit = value;
                  });
                },
                validator: (value) =>
                    value == null ? "Pilih Unit dulu" : null,
              ),

              const SizedBox(height: 16),

              // Full Name
              TextFormField(
                controller: fullNameController,
                decoration: InputDecoration(
                  labelText: "Full Nama",
                  filled: true,
                  fillColor: Colors.green[50],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
                validator: (value) =>
                    value!.isEmpty ? "Nama tidak boleh kosong" : null,
              ),

              const SizedBox(height: 16),

              // Username
              TextFormField(
                controller: usernameController,
                decoration: InputDecoration(
                  labelText: "Username",
                  filled: true,
                  fillColor: Colors.green[50],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
                validator: (value) =>
                    value!.isEmpty ? "Username tidak boleh kosong" : null,
              ),

              const SizedBox(height: 16),

              // Password
              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Password",
                  filled: true,
                  fillColor: Colors.green[50],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
                validator: (value) =>
                    value!.isEmpty ? "Password tidak boleh kosong" : null,
              ),

              const SizedBox(height: 24),

              // Tombol Simpan
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2E5D6F),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Buat data user baru
                      final newUser = {
                        "unit": selectedUnit,
                        "nama": fullNameController.text,
                        "username": usernameController.text,
                      };

                      // Tampilkan pesan sukses
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("User berhasil disimpan!"),
                          backgroundColor: Colors.green,
                        ),
                      );

                      // Kembalikan data user baru ke halaman sebelumnya
                      Navigator.pop(context, newUser);
                    }
                  },
                  child: const Text(
                    "Simpan",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFFD700),
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
