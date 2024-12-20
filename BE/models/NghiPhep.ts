import { Connection, QueryError } from "mysql2";
import connection from "../db"; // Assuming db.ts uses a connection pool

export interface NghiPhepRawData {
  id: number;
  id_nhanvien: string;
  ngaynghi: string;
  lydo: string;
  trangthai: string;
}

export interface CreateNghiPhepRawData {
  id_nhanvien: string;
  ngaynghi: string;
  lydo: string;
  trangthai: string;
}

const tableName = "nghiphep";

class NghiPhep {
  // Using the correct types for callback
  static create(
    data: CreateNghiPhepRawData,
    callback: (err: QueryError | null, results: any) => void
  ): void {
    const { id_nhanvien, ngaynghi, lydo, trangthai } = data;
    const query = `INSERT INTO ${tableName} (id_nhanvien, ngaynghi, lydo, trangthai) VALUES (?, ?, ?, ?)`;

    connection.query(query, [id_nhanvien, ngaynghi, lydo, trangthai], callback);
  }

  static getAll(
    callback: (err: QueryError | null, results: NghiPhepRawData[]) => void
  ): void {
    const query = `SELECT * FROM ${tableName}`;
    connection.query(query, callback);
  }

  static getById(
    id: number,
    callback: (err: QueryError | null, results: any) => void
  ): void {
    const query = `SELECT * FROM ${tableName} WHERE id = ?`;
    connection.query(query, [id], callback);
  }

  static update(
    id: number,
    data: NghiPhepRawData,
    callback: (err: QueryError | null, results: any) => void
  ): void {
    const { id_nhanvien, ngaynghi, lydo, trangthai } = data;
    const query = `UPDATE ${tableName} SET id_nhanvien = ?, ngaynghi = ?, lydo = ? , trangthai = ? WHERE id = ?`;

    connection.query(
      query,
      [id_nhanvien, ngaynghi, lydo, trangthai, id],
      callback
    );
  }

  static delete(
    id: number,
    callback: (err: QueryError | null, results: any) => void
  ): void {
    const query = `DELETE FROM ${tableName} WHERE id = ?`;
    connection.query(query, [id], callback);
  }
}

export default NghiPhep;
