import 'package:easy_localization/easy_localization.dart';
import 'package:exam_6/bloc/cahrt_expanse/chart_expanse_bloc.dart';
import 'package:exam_6/bloc/cahrt_expanse/chart_expanse_state.dart';
import 'package:exam_6/bloc/chart_income/chart_income_bloc.dart';
import 'package:exam_6/bloc/chart_income/chart_income_state.dart';
import 'package:exam_6/ui/screens/charts/widgets/chart_creator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

List<Widget> chartBlocs = [
  SizedBox(
    child: BlocBuilder<ChartIncomeBloc, ChartIncomeState>(
        builder: (context, state) {
      if (state is LoadingChartIncomeState) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      if (state is ErrorChartIncomeState) {
        return Center(
          child: Text(state.message),
        );
      }
      if (state is LoadedChartIncomeState) {
        return ChartCreator(
          state: state,
          centerText: 'Income'.tr(),
        );
      }
      return Center(
        child: Text("Empty data".tr()),
      );
    }),
  ),
  SizedBox(
    child: BlocBuilder<ChartExpanseBloc, ChartExpanseState>(
        builder: (context, state) {
      if (state is LoadingChartExpanseState) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      if (state is ErrorChartExpanseState) {
        return Center(
          child: Text(state.message),
        );
      }
      if (state is LoadedChartExpanseState) {
        return ChartCreator(
          state: state,
          centerText: 'Expense'.tr(),
        );
      }
      return Center(
        child: Text("Empty data".tr()),
      );
    }),
  ),
];
