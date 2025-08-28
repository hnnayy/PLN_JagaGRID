import 'package:flutter/material.dart';

class AddDataPage extends StatefulWidget {
  const AddDataPage({Key? key}) : super(key: key);

  @override
  State<AddDataPage> createState() => _AddDataPageState();
}

class _AddDataPageState extends State<AddDataPage> {
  final _formKey = GlobalKey<FormState>();
  final _idController = TextEditingController();
  final _up3Controller = TextEditingController();
  final _ulpController = TextEditingController();
  final _penyulangController = TextEditingController();
  final _zonaProteksiController = TextEditingController();
  final _sectionController = TextEditingController();
  final _kmsAsetController = TextEditingController();
  final _vendorController = TextEditingController();
  final _dateController = TextEditingController();
  final _treeNameController = TextEditingController();
  final _coordinatesController = TextEditingController();
  final _explanationController = TextEditingController();
  final _noteController = TextEditingController();
  final _priorityController = TextEditingController(); // New controller for Prioritas

  // Reusable InputDecoration for TextFormField
  InputDecoration _buildInputDecoration(String label, String hint, {Icon? suffixIcon}) {
    return InputDecoration(
      filled: true,
      fillColor: const Color(0xFFD3E0EA), // Light input background
      labelText: label,
      labelStyle: const TextStyle(
        color: Colors.black54, // Label color
        fontWeight: FontWeight.w400,
      ),
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.black54),
      suffixIcon: suffixIcon,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20), // Rounded corners like the example
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(
          color: Colors.black54,
          width: 2.0,
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
      floatingLabelBehavior: FloatingLabelBehavior.never, // Keep label above input
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tambah Data Pohon',
          style: TextStyle(
            color: Color(0xFFEFE62E),
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFFEFE62E)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: const Color(0xFF125E72),
      ),
      body: Container(
        color: const Color(0xFF125E72), // Teal background to match the example
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _idController,
                style: const TextStyle(color: Colors.black),
                decoration: _buildInputDecoration('Id Pohon', 'Masukkan ID pohon'),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _up3Controller,
                style: const TextStyle(color: Colors.black),
                decoration: _buildInputDecoration('UP3', 'Masukkan UP3'),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _ulpController,
                style: const TextStyle(color: Colors.black),
                decoration: _buildInputDecoration('ULP', 'Masukkan ULP'),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _penyulangController,
                style: const TextStyle(color: Colors.black),
                decoration: _buildInputDecoration('Penyulang', 'Masukkan Penyulang'),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _zonaProteksiController,
                style: const TextStyle(color: Colors.black),
                decoration: _buildInputDecoration('Zona Proteksi', 'Masukkan Zona Proteksi'),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _sectionController,
                style: const TextStyle(color: Colors.black),
                decoration: _buildInputDecoration('Section', 'Masukkan section'),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _kmsAsetController,
                style: const TextStyle(color: Colors.black),
                decoration: _buildInputDecoration('Kms Aset', 'Masukkan Kms Aset'),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _vendorController,
                style: const TextStyle(color: Colors.black),
                decoration: _buildInputDecoration('Vendor VB', 'Masukkan vendor'),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _dateController,
                style: const TextStyle(color: Colors.black),
                decoration: _buildInputDecoration(
                  'Tanggal Penjadwalan',
                  'Pilih tanggal',
                  suffixIcon: const Icon(Icons.calendar_today, color: Colors.black),
                ),
                readOnly: true,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                    builder: (context, child) {
                      return Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: const ColorScheme.light(
                            primary: Color(0xFF125E72), // Dark teal for selected date
                            onPrimary: Colors.white, // Text color on selected date
                            onSurface: Colors.black87, // Text color for other dates
                          ),
                          textButtonTheme: TextButtonThemeData(
                            style: TextButton.styleFrom(
                              foregroundColor: Color(0xFF125E72), // Cancel/OK button color
                            ),
                          ),
                        ),
                        child: child!,
                      );
                    },
                  );
                  if (pickedDate != null) {
                    _dateController.text = "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";
                  }
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _treeNameController,
                style: const TextStyle(color: Colors.black),
                decoration: _buildInputDecoration('Nama Pohon', 'Masukkan nama pohon'),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  // TODO: Implementasi ambil foto pohon menggunakan camera/image_picker package
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFD3E0EA),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Row(
                    children: const [
                      Icon(Icons.camera_alt, size: 32, color: Colors.black54),
                      SizedBox(width: 12),
                      Text('Foto Pohon', style: TextStyle(fontSize: 16, color: Colors.black)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _coordinatesController,
                style: const TextStyle(color: Colors.black),
                decoration: _buildInputDecoration(
                  'Koordinat',
                  'Masukkan koordinat (lat,long)',
                  suffixIcon: const Icon(Icons.location_on, color: Colors.black),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _explanationController,
                style: const TextStyle(color: Colors.black),
                decoration: _buildInputDecoration('Tujuan Penjadwalan', 'Masukkan tujuan penjadwalan'),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _priorityController, // New Prioritas field
                style: const TextStyle(color: Colors.black),
                decoration: _buildInputDecoration('Prioritas', 'Masukkan prioritas'),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _noteController,
                minLines: 2,
                maxLines: 4,
                style: const TextStyle(color: Colors.black, fontSize: 16),
                decoration: _buildInputDecoration('Catatan', 'Masukkan catatan'),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFEFE62E),
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Data berhasil disimpan!')),
                      );
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Simpan', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _idController.dispose();
    _up3Controller.dispose();
    _ulpController.dispose();
    _penyulangController.dispose();
    _zonaProteksiController.dispose();
    _sectionController.dispose();
    _kmsAsetController.dispose();
    _vendorController.dispose();
    _dateController.dispose();
    _treeNameController.dispose();
    _coordinatesController.dispose();
    _explanationController.dispose();
    _noteController.dispose();
    _priorityController.dispose(); // Dispose the new controller
    super.dispose();
  }
}