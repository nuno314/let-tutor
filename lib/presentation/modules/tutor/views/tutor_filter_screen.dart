import 'dart:math';

import 'package:flutter/material.dart';
import 'package:let_tutor/common/constants.dart';
import 'package:let_tutor/domain/entities/date_range.entity.dart';
import 'package:let_tutor/domain/entities/tutor_list_filter.entity.dart';
import 'package:let_tutor/presentation/common_widget/export.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../generated/assets.dart';
import '../../../common_widget/box_color.dart';
import '../../../common_widget/date_picker/calendar_date_picker.dart';
import '../../../extentions/extention.dart';
import '../../../theme/theme_button.dart';
import '../../../theme/theme_color.dart';

class TutorFilterScreen extends StatefulWidget {
  final TutorListFilter filter;
  const TutorFilterScreen({
    required this.filter,
  });

  @override
  State<TutorFilterScreen> createState() => _TutorFilterScreenState();
}

class _TutorFilterScreenState extends State<TutorFilterScreen> {
  late List<Specialty> specialtiesFilter;
  late List<TutorNationality> nationalitiesFilter;
  late final specialties = <Specialty>[...widget.filter.specialties];
  late final nationalities = <TutorNationality>[...widget.filter.nationalities];

  late ThemeData _themeData;

  TextTheme get textTheme => _themeData.textTheme;

  late AppLocalizations trans;

  @override
  Widget build(BuildContext context) {
    _themeData = Theme.of(context);
    trans = translate(context);
    specialtiesFilter = Specialty.values;
    nationalitiesFilter = TutorNationality.values;
    return ScreenForm(
      headerColor: AppColor.primaryColor,
      bgColor: AppColor.scaffoldColor,
      title: trans.tutorFilter,
      showHeaderImage: false,
      trans: trans,
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    trans.nationality,
                    style: textTheme.bodyText1?.copyWith(
                      fontSize: 14,
                    ),
                  ),
                  _buildNationalityFilter(),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    trans.specialty,
                    style: textTheme.bodyText1?.copyWith(
                      fontSize: 14,
                    ),
                  ),
                  _buildGroupFilter(),
                ],
              ),
            ),
          ),
          _buildBottomButtons(),
        ],
      ),
    );
  }

  Widget _buildBottomButtons() {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      padding: EdgeInsets.only(
        bottom: max(MediaQuery.of(context).padding.bottom, 16),
        right: 16,
        left: 16,
        top: 16,
      ),
      child: Row(
        children: [
          Expanded(
            child: ThemeButton.outline(
              context: context,
              title: trans.reset,
              onPressed: () {
                Navigator.pop(context, widget.filter.copyWithNullable());
              },
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: ThemeButton.primary(
              context: context,
              title: trans.apply,
              onPressed: () {
                Navigator.pop(
                  context,
                  widget.filter.copyWith(
                    specialties: specialties,
                    nationalities: nationalities,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGroupFilter() {
    return Wrap(
      children: [
        ...specialtiesFilter.map(_buildCategoryItem),
      ],
    );
  }

  Widget _buildCategoryItem(Specialty e) {
    final selected = specialties.contains(e);
    return Padding(
      padding: const EdgeInsets.only(right: 12, top: 12),
      child: ChipItem(
        onTap: (selected) {
          setState(() {
            var gs = <Specialty>[];
            if (selected) {
              if (e == Specialty.all) {
                gs.clear();
              } else {
                gs = [...specialties..removeWhere((element) => element == e)];
              }
            } else if (!selected) {
              if (e == Specialty.all) {
                gs = [...specialtiesFilter];
              } else {
                gs = [...specialties, e];
              }
            } else {
              gs = [...specialties];
            }

            specialties
              ..clear()
              ..addAll(gs);
            print(specialties);
          });
        },
        text: e.localized(trans),
        selected: selected,
        textTheme: textTheme,
      ),
    );
  }

  Widget _buildNationalityFilter() {
    return Wrap(
      children: [
        ...nationalitiesFilter.map(_buildNationalityItem),
      ],
    );
  }

  Widget _buildNationalityItem(TutorNationality e) {
    final selected = nationalities.contains(e);
    return Padding(
      padding: const EdgeInsets.only(right: 12, top: 12),
      child: ChipItem(
        onTap: (selected) {
          setState(() {
            var gs = <TutorNationality>[];
            if (selected) {
              gs = [...nationalities..removeWhere((element) => element == e)];
            } else if (!selected) {
              gs = [...nationalities, e];
            } else {
              gs = [...nationalities];
            }

            nationalities
              ..clear()
              ..addAll(gs);
            print(nationalities);
          });
        },
        text: e.localized(trans),
        selected: selected,
        textTheme: textTheme,
      ),
    );
  }
}
