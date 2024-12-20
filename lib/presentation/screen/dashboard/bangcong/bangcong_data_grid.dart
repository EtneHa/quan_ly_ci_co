import 'package:flutter/material.dart';
import 'package:quan_ly_ci_co/core/styles/text_styles_app.dart';
import 'package:quan_ly_ci_co/domain/models/bangcong_model.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

final monthLabel = List.generate(31, (dayIndex) => '${dayIndex + 1}/12');

class BangCongDataGrid extends StatelessWidget {
  BangCongDataGrid(
      {super.key,
      required this.onPageChanged,
      required this.data,
      required this.total,
      required this.page,
      required this.limit});

  final columnTitles = ['Mã nhân viên', 'Họ và tên', 'Phòng ban'];

  List<GridColumn> get _columns => List.generate(
        columnTitles.length,
        (index) => GridColumn(
          columnName: columnTitles[index],
          label: _renderBaseColumnHeader(
            child: Text(
              columnTitles[index],
              style: _headerStyle,
            ),
          ),
        ),
      );
  final List<BangCongModel> data;
  final int total;
  final int page;
  final int limit;
  final Function(int page, int limit) onPageChanged;

  List<GridColumn> chamCongColumns() {
    return monthLabel
        .map((e) => GridColumn(
              columnName: e,
              label: _renderChamCongColumnHeader(
                child: Text(e, style: _headerStyle),
              ),
            ))
        .toList();
  }

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
                  columns: [..._columns, ...chamCongColumns()],
                  headerGridLinesVisibility: GridLinesVisibility.none,
                  gridLinesVisibility: GridLinesVisibility.none,
                  columnWidthMode: ColumnWidthMode.fitByCellValue,
                  // defaultColumnWidth: cs.maxWidth / columnTitles.length,
                  isScrollbarAlwaysShown: false,
                  onQueryRowHeight: (RowHeightDetails details) {
                    return 70.0;
                  },
                  // rowsPerPage: 10,
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

  Widget _renderChamCongColumnHeader({
    required Widget child,
    Alignment alignment = Alignment.center,
  }) {
    return Container(
        alignment: alignment,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: const BoxDecoration(
            color: Color.fromRGBO(33, 150, 243, 0.3),
            border: Border(
              bottom: BorderSide(
                color: Colors.blue,
                width: 1,
              ),
            )),
        child: child);
  }

  TextStyle get _headerStyle => TextStylesApp.subtitle4(color: Colors.black);
}

/// Data source
class _DataSource extends DataGridSource {
  _DataSource({required List<BangCongModel> data}) {
    dataGridRows = List.generate(
        data.length,
        (index) => DataGridRow(cells: [
              DataGridCell<Widget>(
                  columnName: 'Mã nhân viên',
                  value: _buildStringCell(data[index].id)),
              DataGridCell<Widget>(
                  columnName: 'Họ và tên',
                  value: _buildStringCell(data[index].name)),
              DataGridCell<Widget>(
                  columnName: 'Phòng ban',
                  value: SizedBox(
                    width: 10,
                    child: Container(
                        decoration: const BoxDecoration(
                          border: Border(
                              right: BorderSide(
                                  color: Color.fromRGBO(0, 0, 0, 0.12))),
                        ),
                        child: _buildStringCell(data[index].department)),
                  )),
              ...List.generate(monthLabel.length, (i) {
                final chamcong = i < data[index].chamCong.length
                    ? data[index].chamCong[i]
                    : null;
                return DataGridCell<Widget>(
                  columnName: monthLabel[i],
                  value: SizedBox(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: (chamcong?.checkIn != null ||
                              chamcong?.checkOut != null)
                          ? Column(
                              children: [
                                if (chamcong?.checkIn != null)
                                  Expanded(
                                      child: Text(chamcong?.checkIn ?? '')),
                                if (chamcong?.checkOut != null)
                                  Expanded(
                                      child: Text(chamcong?.checkOut ?? '')),
                              ],
                            )
                          : const Expanded(child: Text('-')),
                    ),
                  ),
                );
              }),
            ])).toList();
  }

  List<DataGridRow> dataGridRows = [];

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        // color: rows.indexOf(row) % 2 == 1 ? Colors.amber[50] : Colors.white,
        cells: row.getCells().map<Widget>((e) => e.value).toList());
  }

  Widget _buildStringCell(String? value) {
    return SizedBox(
      width: 10,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        alignment: Alignment.centerLeft,
        child: Text(
          value ?? '',
          style: TextStylesApp.regular(color: Colors.black),
        ),
      ),
    );
  }
}
