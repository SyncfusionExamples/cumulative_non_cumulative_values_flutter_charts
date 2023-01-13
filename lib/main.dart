import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  late List<String>? cumulativeDataLabel;
  late List<ChartData> chartData;

  @override
  void initState() {
    chartData = <ChartData>[
      ChartData('China', 11, 12, 13, 18),
      ChartData('USA', 12, 14, 18, 23),
      ChartData('UK', 14, 13, 15, 20),
      ChartData('Brazil', 18, 16, 17, 22),
    ];
    cumulativeDataLabel = dataLabel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SfCartesianChart(
          annotations: getAnnotation(),
          primaryXAxis: CategoryAxis(),
          series: <ChartSeries<ChartData, String>>[
            StackedColumnSeries<ChartData, String>(
                name: 'series1',
                dataLabelSettings: const DataLabelSettings(isVisible: true),
                dataSource: chartData,
                xValueMapper: (ChartData sales, _) => sales.x,
                yValueMapper: (ChartData sales, _) => sales.y1),
            StackedColumnSeries<ChartData, String>(
                name: 'series2',
                dataLabelSettings: const DataLabelSettings(isVisible: true),
                dataSource: chartData,
                xValueMapper: (ChartData sales, _) => sales.x,
                yValueMapper: (ChartData sales, _) => sales.y2),
            StackedColumnSeries<ChartData, String>(
                name: 'series3',
                dataLabelSettings: const DataLabelSettings(isVisible: true),
                dataSource: chartData,
                xValueMapper: (ChartData sales, _) => sales.x,
                yValueMapper: (ChartData sales, _) => sales.y3),
            StackedColumnSeries<ChartData, String>(
                name: 'series4',
                dataLabelSettings: const DataLabelSettings(isVisible: true),
                dataSource: chartData,
                xValueMapper: (ChartData sales, _) => sales.x,
                yValueMapper: (ChartData sales, _) => sales.y4)
          ]),
    );
  }

  List<String> dataLabel() {
    final List<String> labels = <String>[];
    for (int i = 0; i < chartData.length; i++) {
      labels.add((chartData[i].y1 +
              chartData[i].y2 +
              chartData[i].y3 +
              chartData[i].y4)
          .toString());
    }
    return labels;
  }

  List<CartesianChartAnnotation> getAnnotation() {
    cumulativeDataLabel = dataLabel();
    final List<CartesianChartAnnotation> annotations =
        <CartesianChartAnnotation>[];
    for (int i = 0; i < cumulativeDataLabel!.length; i++) {
      annotations.add(CartesianChartAnnotation(
          widget: Text(cumulativeDataLabel![i]),
          coordinateUnit: CoordinateUnit.point,
          x: chartData[i].x,
          y: int.parse(cumulativeDataLabel![i]) + 2));
    }
    return annotations;
  }
}

class ChartData {
  ChartData(this.x, this.y1, this.y2, this.y3, this.y4);
  final String x;
  final num y1;
  final num y2;
  final num y3;
  final num y4;
}
