import { Connection, QueryError, QueryResult, FieldPacket } from "mysql2";
import connection from "../db"; // Assuming db.ts uses a connection pool
import { PaginationRequest } from "../data_model";

export interface NhanVienRawData {
  id: number;
  ten: string;
  ngaysinh: string;
  sodienthoai: string;
  phongban: string;
  chucvu: string;
  email: string;
  ngaybatdau: string;
}

export interface CreateNhanVienRawData {
  ten: string;
  ngaysinh?: string;
  sodienthoai?: string;
  phongban: string;
  chucvu: string;
  email?: string;
  ngaybatdau?: string;
}

export interface UpdateNhanVienRawData {
  ten?: string;
  ngaysinh?: string;
  sodienthoai?: string;
  phongban?: string;
  chucvu?: string;
  email?: string;
  ngaybatdau?: string;
}

const tableName = "nhanvien";

class NhanVien {
  // Using the correct types for callback
  static create(
    data: CreateNhanVienRawData,
    callback: (err: QueryError | null, results: any) => void
  ): void {
    const { ten, ngaysinh, sodienthoai, phongban, chucvu, email, ngaybatdau } =
      data;
    const query = `INSERT INTO ${tableName} (ten, ngaysinh, sodienthoai, phongban, chucvu, email, ngaybatdau) VALUES (?, ?, ?, ?, ?, ?, ?)`;

    connection.query(
      query,
      [ten, ngaysinh, sodienthoai, phongban, chucvu, email, ngaybatdau],
      callback
    );
  }

  static getAll(
    pagination: PaginationRequest,
    callback: (err: QueryError | null, result: any, totalCount: number) => void
  ): void {
    const { limit, page, sortBy, search } = pagination;

    const offset = ((page ?? 0) - 1) * (limit ?? 0);

    let query = `SELECT * FROM ${tableName}`;

    if (search) {
      query += ` WHERE ten LIKE ? OR sodienthoai LIKE ? OR phongban LIKE ? OR chucvu LIKE ?`;
    }

    query += ` ORDER BY ${sortBy || "id"} ASC LIMIT ? OFFSET ?`;

    const queryParams: any[] = search
      ? [
          `%${search}%`,
          `%${search}%`,
          `%${search}%`,
          `%${search}%`,
          limit,
          offset,
        ]
      : [limit, offset];

    connection.query(
      query,
      queryParams,
      (err: QueryError | null, results: any[]) => {
        if (err) {
          return callback(err, [], 0);
        }

        let countQuery = `SELECT COUNT(*) AS totalCount FROM ${tableName}`;
        if (search) {
          countQuery += ` WHERE ten LIKE ? OR sodienthoai LIKE ? OR phongban LIKE ? OR chucvu LIKE ?`;
        }

        const countQueryParams: any[] = search
          ? [`%${search}%`, `%${search}%`, `%${search}%`, `%${search}%`]
          : [];

        connection.query(
          countQuery,
          countQueryParams,
          (countErr: QueryError | null, countResult: any[]) => {
            if (countErr) {
              return callback(countErr, [], 0);
            }

            const totalCount = countResult[0]?.totalCount || 0;

            callback(null, results, totalCount);
          }
        );
      }
    );
  }

  static getById(
    id: number,
    callback: (err: QueryError | null, results: any) => void
  ): void {
    const query = `SELECT * FROM ${tableName} WHERE id = ?`;
    connection.query(query, [id], callback);
  }

  // static getByEmail(
  //   email: string,
  //   callback: (err: QueryError | null, results: NhanVienRawData[]) => void
  // ): void {
  //   const query = `SELECT * FROM ${tableName} WHERE email = ?`;
  //   connection.query(
  //     query,
  //     [email],
  //     (err: QueryError | null, results: QueryResult, fields: FieldPacket[]) => {
  //       if (err) {
  //         return callback(err, []);
  //       }

  //       // Kiểm tra và chuyển đổi dữ liệu trả về từ QueryResult sang mảng NhanVienRawData[]
  //       const rawData: NhanVienRawData[] = results as NhanVienRawData[]; // Chuyển kiểu QueryResult sang NhanVienRawData[]

  //       callback(null, rawData); // Trả về mảng dữ liệu đúng kiểu
  //     }
  //   );
  // }
  static getByEmail(
    email: string,
    callback: (err: QueryError | null, results: NhanVienRawData[]) => void
  ): void {
    const query = `SELECT * FROM ${tableName} WHERE email = ?`;
    connection.query(
      query,
      [email],
      (err: QueryError | null, results: QueryResult) => {
        if (err) {
          return callback(err, []);
        }

        // Chuyển results sang kiểu NhanVienRawData[]
        const rawData: NhanVienRawData[] = results as NhanVienRawData[];
        callback(null, rawData);
      }
    );
  }

  // Cập nhật nhân viên
  static update(
    id: number,
    data: UpdateNhanVienRawData,
    callback: (err: QueryError | null, results: any) => void
  ): void {
    const { ten, ngaysinh, sodienthoai, phongban, chucvu, email, ngaybatdau } =
      data;
    const query = `UPDATE ${tableName} SET ten = ?, ngaysinh = ?, sodienthoai = ?, phongban = ?, chucvu = ?, email = ?, ngaybatdau = ? WHERE id = ?`;
    connection.query(
      query,
      [ten, ngaysinh, sodienthoai, phongban, chucvu, email, ngaybatdau, id],
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
  static search(
    searchTerm: string,
    callback: (err: QueryError | null, results: any[]) => void
  ): void {
    const querytimkiem = `SELECT * FROM ${tableName} WHERE ten LIKE ? OR phongban LIKE ? OR chucvu LIKE ?`;
    const searchPattern = `%${searchTerm}%`; // Tìm kiếm với ký tự wildcard
    connection.query(
      querytimkiem,
      [searchPattern, searchPattern, searchPattern],
      callback
    );
  }
}
// static searchWithPagination(
//   searchParams: TimKiemNhanVienInput,
//   offset: number,
//   limit: number,
//   callback: (err: Error | null, result: { users: NhanVienRawData[], total: number }) => void
// ): void {
//   let query = `SELECT * FROM ${tableName} WHERE 1=1`;  // Start with a base query

//   // Add conditions based on available search params
//   if (searchParams.ten) {
//     query += ` AND ten LIKE ?`;
//   }
//   if (searchParams.ngaysinh) {
//     query += ` AND ngaysinh LIKE ?`;
//   }
//   if (searchParams.sodienthoai) {
//     query += ` AND sodienthoai LIKE ?`;
//   }
//   if (searchParams.phongban) {
//     query += ` AND phongban LIKE ?`;
//   }
//   if (searchParams.chucvu) {
//     query += ` AND chucvu LIKE ?`;
//   }
//   if (searchParams.ngaybatdau) {
//     query += ` AND ngaybatdau LIKE ?`;
//   }

//   query += ` LIMIT ? OFFSET ?`;  // Add limit and offset for pagination

//   const params: any[] = [
//     ...(searchParams.ten ? [`%${searchParams.ten}%`] : []),
//     ...(searchParams.ngaysinh ? [`%${searchParams.ngaysinh}%`] : []),
//     ...(searchParams.sodienthoai ? [`%${searchParams.sodienthoai}%`] : []),
//     ...(searchParams.phongban ? [`%${searchParams.phongban}%`] : []),
//     ...(searchParams.chucvu ? [`%${searchParams.chucvu}%`] : []),
//     ...(searchParams.ngaybatdau ? [`%${searchParams.ngaybatdau}%`] : []),
//     limit,
//     offset,
//   ];

//   // Run the search query
//   connection.query(query, params, (err, results) => {
//     if (err) {
//       return callback(err, { users: [], total: 0 });
//     }

//     // Lấy tổng số bản ghi
//     const countQuery = `SELECT COUNT(*) AS total FROM ${tableName} WHERE 1=1`;
//     const countParams: any[] = [
//       ...(searchParams.ten ? [`%${searchParams.ten}%`] : []),
//       ...(searchParams.ngaysinh ? [`%${searchParams.ngaysinh}%`] : []),
//       ...(searchParams.sodienthoai ? [`%${searchParams.sodienthoai}%`] : []),
//       ...(searchParams.phongban ? [`%${searchParams.phongban}%`] : []),
//       ...(searchParams.chucvu ? [`%${searchParams.chucvu}%`] : []),
//       ...(searchParams.ngaybatdau ? [`%${searchParams.ngaybatdau}%`] : []),
//     ];

//     connection.query(countQuery, countParams, (countErr, countResults) => {
//       if (countErr) {
//         return callback(countErr, { users: [], total: 0 });
//       }

//       const total = countResults[0].total;
//       callback(null, { users: results, total });
//     });
//   });
// }

export default NhanVien;
