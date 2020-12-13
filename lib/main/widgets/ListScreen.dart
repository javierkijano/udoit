import 'package:flutter/material.dart';
import 'package:udoit/main/widgets/IniativesListItem.dart';

abstract class ItemFetcher {
  //int count = 103;
  int itemsPerPage = 5;
  int currentPage = 0;

  ItemFetcher(
      {/*this.count,*/ this.itemsPerPage = 10} /*, this.currentPage=0}*/);

  Future<List<dynamic>> fetch() async {
    List<dynamic> list;
    //final n = min(itemsPerPage, count - currentPage * itemsPerPage);
    final n = itemsPerPage;

    // Uncomment the following line to see in real time now items are loaded lazily.
    // print('Now on page $_currentPage');
    list = await fetchFcn(n);
    currentPage++;
    return list;
  }

  //abstract method
  Future<List<dynamic>> fetchFcn(n);
}

class ListScreen extends StatefulWidget {
  final _itemFetcher;

  ListScreen(this._itemFetcher);

  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  List<dynamic> _itemList;
  final _biggerFont = const TextStyle(fontSize: 18.0);

  bool _isLoading = true;
  bool _hasMore = true;

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    _hasMore = true;
    _itemList = <dynamic>[];
    _loadMore();
  }

  // Triggers fecth() and then add new items or change _hasMore flag
  void _loadMore() {
    _isLoading = true;
    widget._itemFetcher.fetch().then((List<dynamic> fetchedList) {
      if (fetchedList.isEmpty) {
        setState(() {
          _isLoading = false;
          _hasMore = false;
        });
      } else {
        setState(() {
          _isLoading = false;
          _itemList.addAll(fetchedList);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      // Need to display a loading tile if more items are coming
      itemCount: _hasMore ? _itemList.length + 1 : _itemList.length,
      itemBuilder: (BuildContext context, int index) {
        // Uncomment the following line to see in real time how ListView.builder works
        // print('ListView.builder is building index $index');
        if (index >= _itemList.length) {
          // Don't trigger if one async loading is already under way
          if (!_isLoading) {
            _loadMore();
          }
          return Center(
            child: SizedBox(
              child: CircularProgressIndicator(),
              height: 24,
              width: 24,
            ),
          );
        }
        return IniativesListItem(_itemList[index], index: index);
      },
    );
  }
}
