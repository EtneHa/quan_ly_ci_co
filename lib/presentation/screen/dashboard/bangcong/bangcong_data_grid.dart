import 'package:flutter/material.dart';
import 'package:quan_ly_ci_co/core/styles/text_styles_app.dart';
import 'package:quan_ly_ci_co/domain/models/bangcong_model.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class BangCongDataGrid extends StatelessWidget {
  BangCongDataGrid({super.key, required this.data});

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

  List<GridColumn> chamCongColumns(List<ChamCongModel> chamCong) {
    return chamCong
        .map((e) => GridColumn(
              columnName: e.label,
              label: _renderChamCongColumnHeader(
                child: Text(
                  e.label,
                  style: _headerStyle,
                ),
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
                  columns: [..._columns, ...chamCongColumns(data[0].chamCong)],
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
    Alignment alignment = Alignment.centerLeft,
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
                        child: _buildStringCell(data[index].name)),
                  )),
              ...data[index].chamCong.map((e) => DataGridCell<Widget>(
                  columnName: e.label,
                  value: SizedBox(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: (e.checkIn != null || e.checkOut != null)
                          ? Column(
                              children: [
                                if (e.checkIn != null)
                                  Expanded(child: Text(e.checkIn ?? '')),
                                if (e.checkOut != null)
                                  Expanded(child: Text(e.checkOut ?? '')),
                              ],
                            )
                          : const Expanded(child: Text('-')),
                    ),
                  )))
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
