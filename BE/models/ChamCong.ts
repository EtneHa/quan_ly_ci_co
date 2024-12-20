import { Connection, QueryError, QueryResult } from "mysql2";
import connection from "../db"; // Assuming db.ts uses a connection pool
import { PaginationRequest } from "../data_model";

export interface ChamCongRawData {
  id: number;
  id_nhanvien: string;
  ngay: string;
  giovao: string;
  giora: string;
}
export interface ChamCong30RawData {
  id_nhanvien: string; // ID nhân viên
  ten: string; // Tên nhân viên
  phong_ban: string; // Phòng ban
  cham_congs: {
    // Mảng các ngày chấm công
    gio_vao: string; // Giờ vào
    gio_ra: string; // Giờ ra
  }[];
}

export interface DiemDanhRawData {
  id_nhanvien: string;
  ngay: string;
  gio: string;
}

export interface UpdateChamCongRawData {
  id_nhanvien: string;
  ngay: string;
  giovao: string;
  giora: string;
}

export interface ChamCong30DaysRawData {
  giovao?: string;
  giora?: string;
}

const tableName = "chamcong";

class ChamCong {
  // Using the correct types for callback
  static diemdanh(
    data: DiemDanhRawData,
    callback: (err: QueryError | null, results: any) => void
  ): void {
    const { id_nhanvien, ngay, gio } = data;
    const queryChamCong = `SELECT * FROM ${tableName} WHERE id_nhanvien = ? AND ngay = ?`;
    connection.query(
      queryChamCong,
      [id_nhanvien, ngay],
      (error, results: QueryResult) => {
        console.log(results);
        if (error) {
          const query = `INSERT INTO ${tableName} (id_nhanvien, ngay, giovao) VALUES (?, ?, ?)`;
          connection.query(query, [id_nhanvien, ngay, gio], callback);
        }
        if (results) {
          const query = `UPDATE ${tableName} SET giora = ? WHERE id_nhanvien = ? AND ngay = ?`;
          connection.query(query, [gio, id_nhanvien, ngay], callback);
          return;
        }
      }
    );
  }

  static getAll(
    callback: (err: QueryError | null, results: ChamCongRawData[]) => void
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
    data: UpdateChamCongRawData,
    callback: (err: QueryError | null, results: any) => void
  ): void {
    const { id_nhanvien, ngay, giovao, giora } = data;
    const queryChamCong = `SELECT * FROM ${tableName} WHERE id_nhanvien = ? AND ngay = ?`;
    connection.query(
      queryChamCong,
      [id_nhanvien, ngay],
      (error, results: QueryResult) => {
        console.log(results);
        if (error) {
          const query = `INSERT INTO ${tableName} (id_nhanvien, ngay, giovao ,giora) VALUES (?, ?, ?, ?)`;
          connection.query(query, [id_nhanvien, ngay, giovao, giora], callback);
        }
        if (results) {
          const query = `UPDATE ${tableName} SET giovao = ?, giora = ? WHERE id_nhanvien = ? AND ngay = ?`;
          connection.query(query, [giovao, giora, id_nhanvien, ngay], callback);
          return;
        }
      }
    );
  }

  static delete(
    id: number,
    callback: (err: QueryError | null, results: any) => void
  ): void {
    const query = `DELETE FROM ${tableName} WHERE id = ?`;
    connection.query(query, [id], callback);
  }
  static ChamCongInLast30Days(
    data: {id: string},
    callback: (err: QueryError | null, results: ChamCong30DaysRawData[]) => void
  ): void {
    const querychamcong30ngay = `SELECT * FROM ${tableName} WHERE id_nhanvien = ? AND ngay >= CURDATE() - INTERVAL 30 DAY ORDER BY ngay DESC`;
    connection.query(
      querychamcong30ngay,
      [data.id],
      (error: QueryError | null, results: any) => {
        if (error) {
          callback(error, []);
          return;
        }
        callback(null, results as ChamCong30DaysRawData[]);
      }
    );
  }
  // static getAllWithPagination(
  //   page: number,
  //   limit: number,
  //   callback: (
  //     err: QueryError | null,
  //     results: ChamCong30RawData[],
  //     totalCount: number
  //   ) => void
  // ): void {
  //   const offset = (page - 1) * limit;

  //   // Truy vấn lấy dữ liệu nhân viên với phân trang
  //   const query = `
  //     SELECT c.id_nhanvien, c.ten, c.phong_ban
  //     FROM ${tableName} c
  //     GROUP BY c.id_nhanvien
  //     ORDER BY c.ten ASC
  //     LIMIT ? OFFSET ?`;

  //   connection.query(
  //     query,
  //     [limit, offset],
  //     (err: QueryError | null, results: any) => {
  //       if (err) {
  //         return callback(err, [], 0);
  //       }

  //       // Truy vấn lấy tổng số bản ghi trong cơ sở dữ liệu
  //       const countQuery = `SELECT COUNT(DISTINCT id_nhanvien) AS total FROM ${tableName}`;
  //       connection.query(countQuery, (countErr, countResults: any) => {
  //         if (countErr) {
  //           return callback(countErr, [], 0);
  //         }

  //         const totalCount = countResults[0].total;

  //         // Lặp qua các nhân viên và lấy thông tin chấm công trong 30 ngày gần nhất
  //         const chamCongResults: ChamCong30RawData[] = [];
  //         let processedUsers = 0;

  //         results.forEach((user: any) => {
  //           // Lấy dữ liệu chấm công cho từng nhân viên trong vòng 30 ngày
  //           ChamCong.getAttendanceByNhanVien(
  //             user.id_nhanvien,
  //             (attendanceErr, attendanceRecords) => {
  //               if (attendanceErr) {
  //                 return callback(attendanceErr, [], totalCount);
  //               }

  //               // Chuyển dữ liệu chấm công thành mảng với giờ vào, giờ ra
  //               const chamCongs = attendanceRecords.map((attendance: any) => ({
  //                 gio_vao: attendance.giovao,
  //                 gio_ra: attendance.giora,
  //               }));

  //               chamCongResults.push({
  //                 id_nhanvien: user.id_nhanvien,
  //                 ten: user.ten,
  //                 phong_ban: user.phong_ban,
  //                 cham_congs: chamCongs.slice(0, 30), // Chỉ lấy 30 ngày gần nhất
  //               });

  //               processedUsers++;

  //               // Nếu đã xử lý tất cả nhân viên, gọi callback
  //               if (processedUsers === results.length) {
  //                 callback(null, chamCongResults, totalCount);
  //               }
  //             }
  //           );
  //         });
  //       });
  //     }
  //   );
  // }

  // static getAttendanceByNhanVien(
  //   id_nhanvien: number,
  //   callback: (err: QueryError | null, results: ChamCong30RawData[]) => void
  // ): void {
  //   // Truy vấn lấy dữ liệu chấm công của nhân viên trong 30 ngày gần nhất
  //   const query = `
  //     SELECT * FROM ${tableName}
  //     WHERE id_nhanvien = ? AND ngay >= CURDATE() - INTERVAL 30 DAY
  //     ORDER BY ngay DESC`;

  //   connection.query(
  //     query,
  //     [id_nhanvien],
  //     (err: QueryError | null, results: any) => {
  //       if (err) {
  //         return callback(err, []);
  //       }

  //       // Chuyển kết quả thành kiểu ChamCongRawData[]
  //       const chamCongResults: ChamCong30RawData[] =
  //         results as ChamCong30RawData[];

  //       callback(null, chamCongResults);
  //     }
  //   );
  // }
  // static getAllWithPagination(
  //   page: number,
  //   limit: number,
  //   callback: (
  //     err: QueryError | null,
  //     results: ChamCong30RawData[],
  //     totalCount: number
  //   ) => void
  // ): void {
  //   const offset = (page - 1) * limit;

  //   // Truy vấn lấy dữ liệu nhân viên và chấm công trong 30 ngày gần nhất
  //   const query = `
  //     SELECT c.id_nhanvien, c.ten, c.phong_ban, 
  //            a.giovao, a.giora, a.ngay
  //     FROM nhanvien c
  //     LEFT JOIN chamcong a ON c.id_nhanvien = a.id_nhanvien 
  //     WHERE a.ngay >= CURDATE() - INTERVAL 30 DAY
  //     GROUP BY c.id_nhanvien
  //     ORDER BY c.ten ASC
  //     LIMIT ? OFFSET ?`;

  //   connection.query(
  //     query,
  //     [limit, offset],
  //     (err: QueryError | null, results: any) => {
  //       if (err) {
  //         return callback(err, [], 0);
  //       }

  //       // Truy vấn lấy tổng số bản ghi trong cơ sở dữ liệu
  //       const countQuery = `SELECT COUNT(DISTINCT id_nhanvien) AS total FROM nhanvien`;
  //       connection.query(countQuery, (countErr, countResults: any) => {
  //         if (countErr) {
  //           return callback(countErr, [], 0);
  //         }

  //         const totalCount = countResults[0].total;

  //         // Tổ chức lại dữ liệu chấm công theo nhân viên
  //         const chamCongResults: ChamCong30RawData[] = [];

  //         results.forEach((user: any) => {
  //           // Tổ chức dữ liệu chấm công của mỗi nhân viên
  //           chamCongResults.push({
  //             id_nhanvien: user.id_nhanvien,
  //             ten: user.ten,
  //             phong_ban: user.phong_ban,
  //             cham_congs: [
  //               {
  //                 gio_vao: user.giovao,
  //                 gio_ra: user.giora,
  //               },
  //             ],
  //           });
  //         });

  //         // Gọi lại callback sau khi xử lý xong tất cả
  //         callback(null, chamCongResults, totalCount);
  //       });
  //     }
  //   );
  // }

//   static getChamCongByPage(
//     page: number, 
//     limit: number, 
//     callback: (err: QueryError | null, results: ChamCong30RawData[], totalCount: number) => void
//   ): void {
//     const offset = (page - 1) * limit;

//     // Truy vấn để lấy dữ liệu chấm công của 10 nhân viên
//     const query = `SELECT c.id_nhanvien, c.ten, c.phong_ban, GROUP_CONCAT(JSON_OBJECT('gio_vao', c.giovao, 'gio_ra', c.giora)) AS cham_congs
//                    FROM ${tableName} c
//                    GROUP BY c.id_nhanvien
//                    LIMIT ? OFFSET ?`;
    
//     connection.query(query, [limit, offset], (err: QueryError | null, results: any) => {
//       if (err) {
//         callback(err, [], 0);
//         return;
//       }

//       // Truy vấn để lấy tổng số nhân viên để dùng cho phân trang
//       const countQuery = `SELECT COUNT(DISTINCT id_nhanvien) AS totalCount FROM ${tableName}`;
//       connection.query(countQuery, (countErr: QueryError | null, countResult: any) => {
//         if (countErr) {
//           callback(countErr, [], 0);
//           return;
//         }

//         const totalCount = countResult[0].totalCount;
//         callback(null, results as ChamCong30RawData[], totalCount);
//       });
//     });
//   }
static getChamCongByNhanVien(
  pagination: PaginationRequest,
  callback: (err: QueryError | null, results: ChamCong30RawData[], totalCount: number) => void
): void {
  const { limit, page, sortBy, search } = pagination;
  const offset = ((page ?? 0) - 1) * (limit ?? 0);

  let queryNhanVien = `SELECT * FROM nhanvien`; 
  if (search) {
    queryNhanVien += ` WHERE ten LIKE ? OR phongban LIKE ?`;
  }
  queryNhanVien += ` ORDER BY ${sortBy || "id"} ASC LIMIT ? OFFSET ?`;

  const queryParams = search
    ? [`%${search}%`, `%${search}%`, limit, offset]
    : [limit, offset];

  connection.query(queryNhanVien, queryParams, (err: QueryError | null, nhanViens: any[]) => {
    if (err) {
      return callback(err, [], 0);
    }

    let countQuery = `SELECT COUNT(*) AS totalCount FROM nhanvien`;
    if (search) {
      countQuery += ` WHERE ten LIKE ? OR phongban LIKE ?`;
    }

    const countQueryParams = search
      ? [`%${search}%`, `%${search}%`]
      : [];

    connection.query(countQuery, countQueryParams, (countErr: QueryError | null, countResult: any[]) => {
      if (countErr) {
        return callback(countErr, [], 0);
      }

      const totalCount = countResult[0]?.totalCount || 0;
      
      // Lấy chấm công của từng nhân viên
      const chamCongQuery = `
        SELECT id_nhanvien, ngay, giovao, giora
        FROM chamcong
        WHERE id_nhanvien IN (?);
      `;
      const nhanVienIds = nhanViens.map(nv => nv.id);
      connection.query(chamCongQuery, [nhanVienIds], (ccErr: QueryError | null, chamCongs: any[]) => {
        if (ccErr) {
          return callback(ccErr, [], totalCount);
        }

        const result = nhanViens.map(nv => {
          const chamCongForNv = chamCongs.filter(cc => cc.id_nhanvien === nv.id).map(cc => ({
            gio_vao: cc.giovao,
            gio_ra: cc.giora,
          }));
          return {
            id_nhanvien: nv.id,
            ten: nv.ten,
            phong_ban: nv.phongban,
            cham_congs: chamCongForNv.slice(0, 30), // Lấy 30 ngày đầu
          };
        });

        callback(null, result, totalCount);
      });
    });
  });
}
}

export default ChamCong;
