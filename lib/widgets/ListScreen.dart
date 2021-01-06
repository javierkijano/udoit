import 'package:flutter/material.dart';

class ListScreen extends StatefulWidget {
  //ListScreenItemFetcherBase _itemFetcher;
  Future<List<Widget>> Function(int, int) _itemFetcher;
  int numItemsPerPage;

  ListScreen(
      {@required Future<List<Widget>> Function(int, int) itemFetcher,
      this.numItemsPerPage = 10}) {
    _itemFetcher = itemFetcher;
  }

  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  List<Widget> _itemList;
  final _biggerFont = const TextStyle(fontSize: 18.0);

  bool _isLoading = true;
  bool _hasMore = true;

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    _hasMore = true;
    _itemList = <Widget>[];
    _loadMore();
  }

  // Triggers fecth() and then add new items or change _hasMore flag
  void _loadMore() {
    _isLoading = true;
    widget
        ._itemFetcher(
            _itemList.length, _itemList.length + widget.numItemsPerPage)
        .then((List<Widget> fetchedList) {
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
    super.build(context);
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
        return _itemList[index];
      },
    );
  }
}
