import 'package:chat_app/providers/userAdons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final uAdonProv = Provider.of<UserAdons>(context);

    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Container(
        padding: EdgeInsets.all(3),
        decoration: BoxDecoration(
            border: Border.all(width: 2, color: Colors.blueAccent),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5)
            ]),
        child: CircleAvatar(
          backgroundImage: NetworkImage(
              "https://c4.wallpaperflare.com/wallpaper/695/974/527/anime-attack-on-titan-attack-on-titan-levi-ackerman-shingeki-no-kyojin-hd-wallpaper-preview.jpg"),
          radius: 25,
        ),
      ),
      Expanded(
        child: Container(
          height: 42,
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Material(
            borderRadius: BorderRadius.circular(7),
            elevation: 1,
            child: TextFormField(
              onFieldSubmitted: ((value) {
                if (value.isNotEmpty) {
                  Navigator.of(context).pushNamed("/goto_search");
                  uAdonProv.searchUsers(value);
                }
              }),
              decoration: InputDecoration(
                prefixIcon: InkWell(
                  onTap: () {},
                  child: const Padding(
                    padding: EdgeInsets.only(
                      left: 6,
                    ),
                    child: Icon(
                      Icons.search,
                      color: Colors.black,
                      size: 23,
                    ),
                  ),
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.only(top: 10),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(7),
                  ),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(7),
                  ),
                  borderSide: BorderSide(
                    color: Colors.black38,
                    width: 1,
                  ),
                ),
                hintText: 'Search by username ...',
                hintStyle: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 17,
                ),
              ),
            ),
          ),
        ),
      )
    ]);
  }
}
