import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:recipe_book_app/core/localization_generated/locale_keys.g.dart';
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
                  text: LocaleKeys.type_.tr(),
                  style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(text: EnumToString.recipeTypeToString(type)),
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
                  text: LocaleKeys.serve_.tr(),
                  style: TextStyle(fontWeight: FontWeight.bold)),
              // TextSpan(text: '$qtdPeopleServide people'),
              (qtdPeopleServide > 1)
                  ? TextSpan(
                      text:
                          '$qtdPeopleServide ' + LocaleKeys.person_people.tr())
                  : TextSpan(
                      text:
                          '$qtdPeopleServide ' + LocaleKeys.person_person.tr())
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
                  text: LocaleKeys.difficulty_.tr(),
                  style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(text: EnumToString.difficultyToString(difficulty)),
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
                  text: LocaleKeys.description_.tr(),
                  style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(text: description),
            ],
          ),
        ),
      ],
    );
  }
}
