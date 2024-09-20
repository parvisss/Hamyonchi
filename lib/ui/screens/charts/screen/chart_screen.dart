import 'package:easy_localization/easy_localization.dart';
import 'package:exam_6/bloc/cahrt_expanse/chart_expanse_bloc.dart';
import 'package:exam_6/bloc/cahrt_expanse/chart_expanse_event.dart';
import 'package:exam_6/bloc/chart_income/chart_income_bloc.dart';
import 'package:exam_6/bloc/chart_income/chart_income_event.dart';
import 'package:exam_6/ui/screens/charts/data/cahrts_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChartScreen extends StatefulWidget {
  const ChartScreen({super.key});

  @override
  State<ChartScreen> createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {
  late PageController _pageController;

  @override
  void initState() {
    context.read<ChartExpanseBloc>().add(CalculateChartExpanseEvent());
    context.read<ChartIncomeBloc>().add(CalculateChartIncomeEvent());
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Scaffold(
        appBar: AppBar(
          title:  Text('Charts'.tr()),
        ),
        body: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  PageView.builder(
                    controller: _pageController,
                    itemCount: chartBlocs.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(20),
                        child: chartBlocs[index],
                      );
                    },
                  ),
                  Positioned(
                    left: 10,
                    top: MediaQuery.of(context).size.height * 0.4,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios),
                      onPressed: () {
                        if (_pageController.page! > 0) {
                          _pageController.previousPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        }
                      },
                    ),
                  ),
                  Positioned(
                    right: 10,
                    top: MediaQuery.of(context).size.height * 0.4,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_forward_ios),
                      onPressed: () {
                        if (_pageController.page! < chartBlocs.length - 1) {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
