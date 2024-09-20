import 'package:easy_localization/easy_localization.dart';
import 'package:exam_6/data/models/cahrt_data.dart';
import 'package:exam_6/utils/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartCreator extends StatefulWidget {
  const ChartCreator(
      {super.key, required this.state, required this.centerText});
  final dynamic state;
  final String centerText;

  @override
  State<ChartCreator> createState() => _ChartCreatorState();
}

class _ChartCreatorState extends State<ChartCreator> {
  List<ChartData> data = [
    ChartData('Empty Data'.tr(), 0, 0),
  ];
  late TooltipBehavior _tooltip;
  @override
  void initState() {
    _tooltip = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: SfCircularChart(
        tooltipBehavior: _tooltip,
        annotations: [CircularChartAnnotation(widget: Text(widget.centerText))],
        series: <CircularSeries<ChartData, String>>[
          DoughnutSeries<ChartData, String>(
            dataLabelSettings: DataLabelSettings(
              isVisible: true,
              labelPosition: ChartDataLabelPosition.outside,
              textStyle: TextStyle(color: AppColors.colorsBlack),
            ),
            dataSource: widget.state.list.isNotEmpty ? widget.state.list : data,
            xValueMapper: (ChartData data, _) => data.category,
            yValueMapper: (ChartData data, _) => data.percent,
            dataLabelMapper: (ChartData data, _) => '''${data.category}
      ${data.percent.toStringAsFixed(1)}% (\$${data.summ})''',
          ),
        ],
      ),
    );
  }
}
