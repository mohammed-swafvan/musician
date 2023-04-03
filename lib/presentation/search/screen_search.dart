import 'package:flutter/material.dart';
import 'package:musician/controller/core/themes/back_gound_design.dart';
import 'package:musician/presentation/widgets/back_drop_widget.dart';
import 'package:musician/controller/Provider/search/search_provider.dart';
import 'package:musician/presentation/search/widgets/search_list_view.dart';
import 'package:musician/controller/core/themes/usually_colors.dart';

import 'package:provider/provider.dart';


class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final searchPrivider = Provider.of<SearchProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      searchPrivider.songsAreLoading();
    });
    return Scaffold(
      backgroundColor: bgColor,
      body: Stack(
        children: [
          const Blue(),
          const Purple(),
          const BackdropWidget(),
          SafeArea(
            child: SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: ListView(
                shrinkWrap: true,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios_new,
                          size: 26,
                          color: Colors.white38,
                        ),
                      ),
                      const Text('Search',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 38,
                              shadows: [Shadow(offset: Offset(4.0, 4.0), blurRadius: 3.0, color: Colors.white10)]))
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: SizedBox(
                      width: double.infinity,
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.deepPurple[50],
                              borderRadius:
                                  const BorderRadius.only(topLeft: Radius.circular(30), bottomLeft: Radius.circular(30)),
                            ),
                            height: 50,
                            width: 45,
                            child: const Padding(padding: EdgeInsets.only(left: 7.0), child: Icon(Icons.search)),
                          ),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.deepPurple[50],
                                  borderRadius:
                                      const BorderRadius.only(bottomRight: Radius.circular(30), topRight: Radius.circular(30))),
                              height: 50,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(),
                                child: TextField(
                                  onChanged: (value) => searchPrivider.updatedList(value),
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                                  decoration: const InputDecoration(
                                      filled: true,
                                      fillColor: Colors.transparent,
                                      border: InputBorder.none,
                                      hintText: 'Songs',
                                      hintStyle: TextStyle(color: Colors.black87, fontSize: 18, fontWeight: FontWeight.w500)),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SearchScreenListTile(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
