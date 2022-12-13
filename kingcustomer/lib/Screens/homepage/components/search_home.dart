import 'package:flutter/material.dart';

class SearchHome extends StatelessWidget {
  SearchHome({super.key});
  final TextEditingController _searchController = TextEditingController();
  _searchPeople(TextEditingController search) {
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: TextFormField(
            style: const TextStyle(fontSize: 20), controller: _searchController),
        actions: [
          IconButton(
            color: Colors.black,
            onPressed: () {
              _searchPeople(_searchController);
            },
            icon: const Icon(
              Icons.search,
            ),
          ),
        ],
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: ListView.builder(
          itemCount: 1,
          itemBuilder: (context, index) {
            return const SearchTile(
              title: "Areeb",
              subtitle: "Electrician",
              image: NetworkImage(
                "https://images.pexels.com/photos/1172253/pexels-photo-1172253.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
              ),
            );
          }),
    );
  }
}

class SearchTile extends StatelessWidget {
  const SearchTile({
    Key? key,
    required this.title,
    required this.subtitle,
    this.image,
  }) : super(key: key);
  final String title;
  final String subtitle;
  final ImageProvider<Object>? image;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      leading: CircleAvatar(
        backgroundImage: const AssetImage(
          "assets/images/logo-black-half.png",
        ),
        foregroundImage: image,
      ),
      trailing: PopupMenuButton(itemBuilder: (context) {
        return [
          const PopupMenuItem<int>(
            value: 0,
            child: Text("Remove this notification"),
          ),
          const PopupMenuItem<int>(
            value: 1,
            child: Text("Turn off notification about this."),
          ),
          const PopupMenuItem<int>(
            value: 2,
            child: Text("report"),
          ),
        ];
      }, onSelected: (value) {
        if (value == 0) {
        } else if (value == 1) {
        } else if (value == 2) {
        }
      }),
    );
  }
}
