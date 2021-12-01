import 'package:flutter/material.dart';
import 'package:quick_recipes/widgets/Main_Drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters';
  final Function saveFilter;

  final Map<String, bool> currentFilters;
  const FiltersScreen({this.saveFilter, this.currentFilters});

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _glutenFree = false;
  bool _vegetarian = false;
  bool _vegen = false;
  bool _lactoseFree = false;

  @override
  initState() {
    _glutenFree = widget.currentFilters['gluten'];
    _lactoseFree = widget.currentFilters['lactose'];
    _vegen = widget.currentFilters['vegen'];
    _vegetarian = widget.currentFilters['vegetarian'];
    super.initState();
  }

  Widget builtTogelSwitch(String Title, String description, bool currentValue,
      Function updateValue) {
    return SwitchListTile(
        title: Text(Title),
        value: currentValue,
        subtitle: Text("only glten Free meals."),
        onChanged: updateValue);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Filters'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              final selectedFilters = {
                'gluten': _glutenFree,
                'lactose': _lactoseFree,
                'vegen': _vegen,
                'vegetarian': _vegetarian,
              };
              widget.saveFilter(selectedFilters);
            },
          )
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              "Adjest Your meal selection.",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                builtTogelSwitch(
                  "Gluten_free",
                  "only Include Gluten_free Meals",
                  _glutenFree,
                  (newValue) {
                    setState(() {
                      _glutenFree = newValue;
                    });
                  },
                ),
                builtTogelSwitch(
                  "Lactose_free",
                  "only Include Lactose_free Meals",
                  _lactoseFree,
                  (newValue) {
                    setState(() {
                      _lactoseFree = newValue;
                    });
                  },
                ),
                builtTogelSwitch(
                  "Vegitarian",
                  "only Include Vagitarian Meals",
                  _vegetarian,
                  (newValue) {
                    setState(() {
                      _vegetarian = newValue;
                    });
                  },
                ),
                builtTogelSwitch(
                  "Vegen",
                  "only Include Vegen Meals",
                  _vegen,
                  (newValue) {
                    setState(() {
                      _vegen = newValue;
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
