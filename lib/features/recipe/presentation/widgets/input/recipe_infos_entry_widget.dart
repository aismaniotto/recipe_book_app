import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:recipe_book_app/core/utils/enum_to_string.dart';
import 'package:recipe_book_app/features/recipe/domain/entities/recipe.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:recipe_book_app/core/localization_generated/locale_keys.g.dart';

class RecipeInfosEntryWidget extends StatelessWidget {
  final String title;
  final ValueChanged<String> onTitleChanged;
  final String description;
  final ValueChanged<String> onDescriptionChanged;
  final Type type;
  final ValueChanged<Type> onTypeChanged;
  final int quantityPeopleServide;
  final ValueChanged<int> onQuantityPeopleServideChanged;
  final Difficulty difficulty;
  final ValueChanged<Difficulty> onDifficultyChanged;

  const RecipeInfosEntryWidget(
      {Key key,
      @required this.title,
      @required this.onTitleChanged,
      @required this.description,
      @required this.onDescriptionChanged,
      @required this.type,
      @required this.onTypeChanged,
      @required this.quantityPeopleServide,
      @required this.onQuantityPeopleServideChanged,
      @required this.difficulty,
      @required this.onDifficultyChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: <Widget>[
        TextFormField(
            decoration:
                InputDecoration(labelText: LocaleKeys.recipe_title.tr()),
            initialValue: title,
            onChanged: onTitleChanged,
            autovalidate: true,
            validator: (value) =>
                value.isEmpty ? LocaleKeys.title_required.tr() : null),
        TextFormField(
          decoration: InputDecoration(labelText: LocaleKeys.description.tr()),
          initialValue: description,
          keyboardType: TextInputType.multiline,
          maxLines: null,
          onChanged: onDescriptionChanged,
        ),
        DropdownButtonFormField(
            decoration: InputDecoration(labelText: LocaleKeys.type.tr()),
            value: type,
            onChanged: onTypeChanged,
            autovalidate: true,
            validator: (value) =>
                value == null ? LocaleKeys.type_required.tr() : null,
            items: <Type>[
              Type.breakfast,
              Type.meal,
              Type.side,
              Type.snack,
              Type.drink,
              Type.dessert,
              Type.other
            ].map<DropdownMenuItem<Type>>((Type value) {
              return DropdownMenuItem<Type>(
                value: value,
                child: Text(EnumToString.recipeTypeToString(value)),
              );
            }).toList(),
            onTap: () => {FocusScope.of(context).unfocus()}),
        TextFormField(
            decoration:
                InputDecoration(labelText: LocaleKeys.peoples_serves.tr()),
            initialValue: quantityPeopleServide?.toString(),
            onChanged: (String value) =>
                onQuantityPeopleServideChanged(int.parse(value)),
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              WhitelistingTextInputFormatter.digitsOnly
            ]),
        DropdownButtonFormField(
            decoration:
                InputDecoration(labelText: LocaleKeys.difficulty_level.tr()),
            value: difficulty,
            onChanged: onDifficultyChanged,
            autovalidate: true,
            validator: (value) =>
                value == null ? LocaleKeys.difficulty_required.tr() : null,
            items: <Difficulty>[
              Difficulty.easy,
              Difficulty.medium,
              Difficulty.hard
            ].map<DropdownMenuItem<Difficulty>>((Difficulty value) {
              return DropdownMenuItem<Difficulty>(
                value: value,
                child: Text(EnumToString.difficultyToString(value)),
              );
            }).toList(),
            onTap: () => {FocusScope.of(context).unfocus()}),
      ],
    );
  }
}
