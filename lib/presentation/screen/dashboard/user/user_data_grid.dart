import 'package:flutter/material.dart';
import 'package:quan_ly_ci_co/core/styles/text_styles_app.dart';
import 'package:quan_ly_ci_co/domain/models/user_model.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class UserDataGrid extends StatelessWidget {
  UserDataGrid(
      {super.key,
      required this.onPageChanged,
      required this.data,
      required this.total,
      required this.page,
      required this.limit});

  final columnTitles = [
    'Mã nhân viên',
    'Họ và tên',
    'Phòng ban',
    'Chức danh',
    'Ngày bắt đầu vào làm'
  ];

  List<GridColumn> get _columns => List.generate(
        columnTitles.length,
        (index) => GridColumn(
          columnName: columnTitles[index],
          columnWidthMode: ColumnWidthMode.fill,
          label: _renderBaseColumnHeader(
            child: Text(
              columnTitles[index],
              style: _headerStyle,
            ),
          ),
        ),
      );
  final List<UserModel> data;
  final int total;
  final int page;
  final int limit;
  final Function(int page, int limit) onPageChanged;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, cs) {
      return Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                SfDataGrid(
                  source: _DataSource(data: data),
                  columns: _columns,
                  headerGridLinesVisibility: GridLinesVisibility.none,
                  gridLinesVisibility: GridLinesVisibility.none,
                  columnWidthMode: ColumnWidthMode.fill,
                  defaultColumnWidth: cs.maxWidth / columnTitles.length,
                  isScrollbarAlwaysShown: false,
                  rowsPerPage: 10,
                ),
              ],
            ),
          ),
          Row(
            children: [
              Spacer(),
              Text('Rows per page: '),
              DropdownButton<int>(
                value: 10,
                items: [10, 20, 50, 100]
                    .map((e) => DropdownMenuItem<int>(
                          value: e,
                          child: Text(e.toString()),
                        ))
                    .toList(),
                onChanged: (value) {
                  onPageChanged(1, value ?? limit);
                },
              ),
              SizedBox(width: 16),
              Text('${page * limit - (limit - 1)}-${page * limit} of ${total}'),
              SizedBox(width: 16),
              IconButton(
                padding: const EdgeInsets.all(10),
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () {
                  if (page == 1) return;
                  onPageChanged(page - 1, limit);
                },
              ),
              IconButton(
                padding: const EdgeInsets.all(10),
                icon: Icon(Icons.arrow_forward_ios),
                onPressed: () {
                  if (page * limit > total) return;
                  onPageChanged(page + 1, limit);
                },
              ),
            ],
          )
        ],
      );
    });
  }

  Widget _renderBaseColumnHeader({
    required Widget child,
    Alignment alignment = Alignment.centerLeft,
  }) {
    return Container(
        alignment: alignment,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: const BoxDecoration(
            border: Border(
          bottom: BorderSide(
            color: Colors.blue,
            width: 1,
          ),
        )),
        child: child);
  }

  // TODO change header style
  TextStyle get _headerStyle => TextStylesApp.subtitle4(color: Colors.black);
}

/// Data source
class _DataSource extends DataGridSource {
  _DataSource({required List<UserModel> data}) {
    dataGridRows = List.generate(
        data.length,
        (index) => DataGridRow(cells: [
              DataGridCell<String>(
                  columnName: 'Mã nhân viên', value: data[index].id),
              DataGridCell<String>(
                  columnName: 'Họ và tên', value: data[index].name),
              DataGridCell<String>(
                  columnName: 'Phòng ban', value: data[index].department),
              DataGridCell<String>(
                  columnName: 'Chức danh', value: data[index].role),
              DataGridCell<String>(
                  columnName: 'Ngày bắt đầu vào làm',
                  value: data[index].onboardDate),
            ])).toList();
  }

  List<DataGridRow> dataGridRows = [];

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        color: rows.indexOf(row) % 2 == 1 ? Colors.amber[50] : Colors.white,
        cells: [
          _buildStringCell(row.getCells()[0].value),
          _buildStringCell(row.getCells()[1].value),
          _buildStringCell(row.getCells()[2].value),
          _buildStringCell(row.getCells()[3].value),
          _buildStringCell(row.getCells()[4].value),
        ]);
  }

  Widget _buildStringCell(String? value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      alignment: Alignment.centerLeft,
      child: Text(
        value ?? '',
        style: TextStylesApp.regular(color: Colors.black),
      ),
    );
  }
}
