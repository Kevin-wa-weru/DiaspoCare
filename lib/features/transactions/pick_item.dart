import 'package:diasporacare/features/transactions/cubit/search_items_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PickItem extends StatefulWidget {
  const PickItem({super.key});

  @override
  State<PickItem> createState() => _PickItemState();
}

class _PickItemState extends State<PickItem> {
  @override
  void initState() {
    context.read<SearchItemsCubit>().searchItem('a');
    super.initState();
  }

  final searchController = TextEditingController();

  List fakeList = ['1', '', '', '', '', '', '', '', ''];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: const Color(0xFF145DA0),
        title: const Text(
          'Search Items',
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
        ),
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              right: 20.0,
              bottom: 8,
              top: 8,
            ),
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                height: 20,
                width: 40,
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(800),
                  border: Border.all(
                    color: Colors.black12,
                    width: 1.2,
                  ),
                ),
                child: Center(
                  child: SizedBox(
                    height: 20,
                    width: 20,
                    child: SvgPicture.asset(
                      'assets/icons/cancel2.svg',
                      color: Colors.white70,
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
              left: 10,
              right: 16,
              bottom: 20,
            ),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.06,
              child: TextFormField(
                  keyboardType: TextInputType.text,
                  controller: searchController,
                  onChanged: (value) {
                    context
                        .read<SearchItemsCubit>()
                        .searchItem(searchController.text);
                  },
                  style: const TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.w500,
                      fontSize: 12),
                  decoration: InputDecoration(
                    hintText: 'Search items',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          const BorderSide(color: Colors.transparent, width: 1),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          const BorderSide(color: Colors.black26, width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.black26, width: 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                  )),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: BlocBuilder<SearchItemsCubit, SearchItemsState>(
                builder: (context, state) {
                  return state.when(initial: () {
                    return Container();
                  }, loading: () {
                    return Column(
                      children: fakeList.map((e) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 25.0, left: 15.0),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.search,
                                color: Colors.black12,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: Container(
                                  color: Colors.transparent,
                                  child: Container(
                                    height: MediaQuery.of(context).size.width *
                                        0.02,
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    decoration: const BoxDecoration(
                                      color: Colors.black12,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    );
                  }, loaded: (items) {
                    if (items.isEmpty) {
                      return const Padding(
                        padding: EdgeInsets.only(top: 20.0),
                        child: Text('No item found'),
                      );
                    } else {
                      return Column(
                        children: items
                            .map(
                              (e) => InkWell(
                                onTap: () {
                                  Navigator.pop(
                                    context,
                                    e['drug_name'],
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 25.0, left: 15.0),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.search),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 15.0),
                                        child: Text(
                                          overflow: TextOverflow.ellipsis,
                                          '${e['drug_name']}',
                                          //  '${e['drug_name']} by ${e['manufucturer']}',
                                          style: const TextStyle(
                                            fontSize: 14,
                                            overflow: TextOverflow.ellipsis,
                                            // overflow: TextOverflow.ellipsis,
                                            color: Colors.black87,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      );
                    }
                  }, error: (message) {
                    return Center(
                      child: Text(message.toString()),
                    );
                  });
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
