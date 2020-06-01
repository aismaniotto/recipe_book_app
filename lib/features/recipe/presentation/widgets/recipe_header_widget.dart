import 'package:flutter/material.dart';
import 'package:recipe_book_app/core/utils/enum_to_string.dart';
import 'package:recipe_book_app/features/recipe/domain/entities/recipe.dart';

class RecipeHeaderWidget extends StatelessWidget {
  final String name;
  final String description;
  final Type type;
  final int qtdPeopleServide;
  final Difficulty difficulty;

  const RecipeHeaderWidget(
      {Key key,
      @required this.name,
      @required this.description,
      @required this.type,
      @required this.qtdPeopleServide,
      @required this.difficulty})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Center(
          child: Text(
            name.toUpperCase(),
            style: TextStyle(
                color: Colors.blueGrey,
                fontSize: 22,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic),
          ),
        ),
        SizedBox(height: 10),
        RichText(
          text: TextSpan(
            text: '',
            style: DefaultTextStyle.of(context).style,
            children: <TextSpan>[
              TextSpan(
                  text: 'Type: ',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(text: EnumToString.RecipeTypeToString(type)),
            ],
          ),
        ),
        SizedBox(height: 5),
        RichText(
          text: TextSpan(
            text: '',
            style: DefaultTextStyle.of(context).style,
            children: <TextSpan>[
              TextSpan(
                  text: 'Serve: ',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(text: '$qtdPeopleServide people'),
            ],
          ),
        ),
        SizedBox(height: 5),
        RichText(
          text: TextSpan(
            text: '',
            style: DefaultTextStyle.of(context).style,
            children: <TextSpan>[
              TextSpan(
                  text: 'Difficulty: ',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(text: EnumToString.DifficultyToString(difficulty)),
            ],
          ),
        ),
        SizedBox(height: 5),
        RichText(
          text: TextSpan(
            text: '',
            style: DefaultTextStyle.of(context).style,
            children: <TextSpan>[
              TextSpan(
                  text: 'Description: ',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(text: description),
            ],
          ),
        ),
      ],
    );
  }
}
