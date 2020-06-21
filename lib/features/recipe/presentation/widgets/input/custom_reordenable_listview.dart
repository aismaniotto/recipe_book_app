import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:recipe_book_app/features/recipe/domain/entities/identificable_text.dart';
import 'package:uuid/uuid.dart';

class CustomReordenableListView extends StatelessWidget {
  final List<IdentificableText> items;
  final Function(String, int) onItemChange;
  final Function(int) onItemDelete;
  final Function() onItemAdd;
  final Function(int, int) onItemReorder;
  final String hintTextItem;

  const CustomReordenableListView(
      {Key key,
      @required this.items,
      @required this.onItemChange,
      @required this.onItemDelete,
      @required this.onItemAdd,
      @required this.onItemReorder,
      this.hintTextItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return ReorderableListView(
            onReorder: onItemReorder,
            children: items.map((step) {
              int index = items.indexOf(step);
              return Row(
                key: Key(Uuid().v4()),
                children: <Widget>[
                  Flexible(
                    child: TextFormField(
                      decoration: InputDecoration(hintText: hintTextItem),
                      initialValue: items[index].text,
                      onChanged: (String value) => onItemChange(
                          value, index), // losing focus on typing...
                    ),
                  ),
                  (index + 1 == items.length || items.length == 1)
                      ? IconButton(
                          icon: Icon(Icons.add),
                          color: Colors.green,
                          onPressed: () => onItemAdd(),
                        )
                      : IconButton(
                          icon: Icon(Icons.clear),
                          color: Colors.red,
                          onPressed: () => onItemDelete(index),
                        ),
                  Icon(Icons.dehaze),
                ],
              );
            }).toList());
      },
    );
  }
}

// return ListView.builder(
//     itemCount: steps.length,
//     itemBuilder: (_, index) {
//       return Row(
//         children: <Widget>[
//           Flexible(
//             child: TextFormField(
//               onChanged: (String value) => onItemChange(value, index),
//             ),
//           ),
//           (index + 1 == steps.length || steps.length == 1)
//               ? IconButton(
//                   icon: Icon(Icons.add),
//                   color: Colors.green,
//                   onPressed: () => onItemAdd(),
//                 )
//               : IconButton(
//                   icon: Icon(Icons.clear),
//                   color: Colors.red,
//                   onPressed: () => onItemDelete(index),
//                 ),
//         ],
//       );
//     });
