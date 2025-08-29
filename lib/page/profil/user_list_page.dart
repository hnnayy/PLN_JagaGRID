import 'package:flutter/material.dart';
import 'edit_user_page.dart';
import 'form_add_user_page.dart'; // ✅ pastikan ada import form tambah user

class UserListPage extends StatefulWidget {
  const UserListPage({super.key});

  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  final TextEditingController searchController = TextEditingController();

  // Dummy data sementara
  List<Map<String, String>> users = [
    {
      "name": "Master John Walkin",
      "username": "@JohnWalkin",
      "unit": "Ulp Makassar",
      "added": "01 Juli 2024",
    },
    {
      "name": "Jane Doe",
      "username": "@JaneDoe",
      "unit": "Ulp Bone",
      "added": "05 Juli 2024",
    },
    {
      "name": "Michael Scott",
      "username": "@Michael",
      "unit": "Ulp Makassar",
      "added": "10 Juli 2024",
    },
  ];

  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    final filteredUsers = users.where((user) {
      final query = searchQuery.toLowerCase();
      return user["name"]!.toLowerCase().contains(query) ||
          user["username"]!.toLowerCase().contains(query) ||
          user["unit"]!.toLowerCase().contains(query) ||
          user["added"]!.toLowerCase().contains(query);
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFF2E5D6F),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2E5D6F),
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Daftar User",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFFFFD700),
          ),
        ),
      ),

      // FAB untuk tambah user
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFFFD700),
        child: const Icon(Icons.add, color: Colors.black),
        onPressed: () async {
          final newUser = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const FormAddUserPage()),
          );

          if (newUser != null) {
            setState(() {
              users.add({
                "name": newUser["nama"],
                "username": newUser["username"],
                "unit": newUser["unit"],
                "added": DateTime.now().toString().split(" ")[0], // tgl hari ini
              });
            });

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("User baru berhasil ditambahkan")),
            );
          }
        },
      ),

      body: Column(
        children: [
          // 🔎 Search bar dengan tombol clear
          Container(
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.9),
              borderRadius: BorderRadius.circular(12),
            ),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: "Cari user...",
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                suffixIcon: searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear, color: Colors.grey),
                        onPressed: () {
                          setState(() {
                            searchController.clear();
                            searchQuery = "";
                          });
                        },
                      )
                    : null,
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 14),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
            ),
          ),

          // 📋 List User
          Expanded(
            child: filteredUsers.isEmpty
                ? const Center(
                    child: Text(
                      "User tidak ditemukan",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: filteredUsers.length,
                    itemBuilder: (context, index) {
                      final user = filteredUsers[index];
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        margin: const EdgeInsets.only(bottom: 16),
                        color: Colors.white,
                        elevation: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const CircleAvatar(
                                    backgroundColor: Color(0xFF5A8CA7),
                                    child: Icon(Icons.person,
                                        color: Colors.white),
                                  ),
                                  const SizedBox(width: 12),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        user["name"]!,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      Text(
                                        user["username"]!,
                                        style: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),

                              RichText(
                                text: TextSpan(
                                  text: 'Unit: ',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: user["unit"],
                                      style: const TextStyle(
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  text: 'Ditambahkan: ',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: user["added"],
                                      style: const TextStyle(
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(height: 12),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(0xFFFFD700),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                      ),
                                      onPressed: () async {
                                        final updatedUser =
                                            await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                EditUserPage(user: user),
                                          ),
                                        );

                                        if (updatedUser != null) {
                                          setState(() {
                                            final oldIndex = users.indexWhere(
                                                (u) =>
                                                    u["username"] ==
                                                    user["username"]);
                                            if (oldIndex != -1) {
                                              users[oldIndex] =
                                                  Map<String, String>.from(
                                                      updatedUser);
                                            }
                                          });

                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                  "${user["username"]} berhasil diupdate"),
                                            ),
                                          );
                                        }
                                      },
                                      child: const Text(
                                        "Edit",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(0xFFC6B21F),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          users.removeWhere((u) =>
                                              u["username"] ==
                                              user["username"]);
                                        });
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                                "${user["username"]} berhasil dihapus"),
                                          ),
                                        );
                                      },
                                      child: const Text(
                                        "Hapus",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
