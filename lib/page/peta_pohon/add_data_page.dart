import 'package:flutter/material.dart';

class AddDataPage extends StatefulWidget {
  const AddDataPage({Key? key}) : super(key: key);

  @override
  State<AddDataPage> createState() => _AddDataPageState();
}

class _AddDataPageState extends State<AddDataPage> {
  final _formKey = GlobalKey<FormState>();
  final _idController = TextEditingController();
  final _sectionController = TextEditingController();
  final _vendorController = TextEditingController();
  final _dateController = TextEditingController();
  final _coordinatesController = TextEditingController();
  final _explanationController = TextEditingController();
  final _treeNameController = TextEditingController();
  final _priorityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Data Pohon'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _idController,
                decoration: const InputDecoration(
                  labelText: 'Id Pohon*',
                  hintText: 'Masukkan ID pohon',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'ID Pohon wajib diisi';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _sectionController,
                decoration: const InputDecoration(
                  labelText: 'Section',
                  hintText: 'Masukkan section',
                ),
              ),
              TextFormField(
                controller: _vendorController,
                decoration: const InputDecoration(
                  labelText: 'Vendor VB',
                  hintText: 'Masukkan vendor',
                ),
              ),
              TextFormField(
                controller: _dateController,
                decoration: const InputDecoration(
                  labelText: 'Tanggal*',
                  hintText: 'Pilih tanggal',
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                readOnly: true,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (pickedDate != null) {
                    _dateController.text = "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";
                  }
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Tanggal wajib diisi';
                  }
                  return null;
                },
              ),
              GestureDetector(
                onTap: () {
                  // TODO: Implementasi ambil foto pohon menggunakan camera/image_picker package
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Row(
                    children: const [
                      Icon(Icons.camera_alt, size: 32, color: Colors.black54),
                      SizedBox(width: 12),
                      Text('Foto Pohon*', style: TextStyle(fontSize: 16)),
                    ],
                  ),
                ),
              ),
              TextFormField(
                controller: _coordinatesController,
                decoration: const InputDecoration(
                  labelText: 'Koordinat*',
                  hintText: 'Masukkan koordinat (lat,long)',
                  suffixIcon: Icon(Icons.location_on),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Koordinat wajib diisi';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _explanationController,
                decoration: const InputDecoration(
                  labelText: 'Tujuan Penjadwalan',
                  hintText: 'Masukkan tujuan penjadwalan',
                ),
              ),
              TextFormField(
                controller: _treeNameController,
                decoration: const InputDecoration(
                  labelText: 'Nama Pohon*',
                  hintText: 'Masukkan nama pohon',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama Pohon wajib diisi';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _priorityController,
                decoration: const InputDecoration(
                  labelText: 'Prioritas',
                  hintText: 'Masukkan prioritas',
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // TODO: Simpan data dan tambah marker ke MapPage
                      // Contoh: Parse _coordinatesController.text ke LatLng, lalu gunakan Provider atau Navigator untuk update markers
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
    _sectionController.dispose();
    _vendorController.dispose();
    _dateController.dispose();
    _coordinatesController.dispose();
    _explanationController.dispose();
    _treeNameController.dispose();
    _priorityController.dispose();
    super.dispose();
  }
}