import express, { Request, Response } from "express";
import ChamCong, {
  DiemDanhRawData,
  ChamCongRawData,
  UpdateChamCongRawData,
  ChamCong30DaysRawData,
  ChamCong30RawData,
} from "../models/ChamCong";
import {
  CreateChamCongResponse,
  GetAllChamCongResponse,
  PaginationRequest,
  TaoChamCongInput,
  UpdateChamCongResponse,
  CapNhatChamCongInput,
  ChamCong30ngayInput,
  ChamCongInLast30DaysResponse,
  GetAllChamCong30Response,
} from "../data_model";
import { QueryError } from "mysql2";
import NhanVien, { NhanVienRawData } from "../models/NhanVien";

const router = express.Router();

router.get("/getAllChamCong", (req: Request, res: Response): void => {
  const { limit, page, sortBy } = req.body as PaginationRequest;

  ChamCong.getAll((err: Error | null, users: ChamCongRawData[]) => {
    if (err) {
      return res.status(404).send("Error fetching users");
    }

    const response: GetAllChamCongResponse = {
      success: true,
      message: "Get all nhan vien success",
      data: users,
    };

    res.json(response);
  });
});

router.post("/diemdanh", (req: Request, res: Response): void => {
  // Destructure the request body to get the necessary data
  const { id_nhanvien, ngay, gio } = req.body as TaoChamCongInput;

  // Validate required fields
  if (!id_nhanvien || !ngay || !gio) {
    const response: CreateChamCongResponse = {
      success: false,
      message: "All required fields must be provided.",
      data: null,
    };

    res.status(400).json(response);
  }

  // Create a new nhan vien object
  const data: DiemDanhRawData = {
    id_nhanvien: id_nhanvien!,
    ngay: ngay!,
    gio: gio!,
  };

  ChamCong.diemdanh(data, (err: Error | null, id: number) => {
    if (err) {
      console.log(err);
      const response: CreateChamCongResponse = {
        success: false,
        message: "Error creating diem danh",
        data: null,
      };

      res.status(500).json(response);
    }

    const response: CreateChamCongResponse = {
      success: true,
      message: "Create diem danh success",
      data: { id },
    };
    res.json(response);
  });
});

router.post("/capnhatdiemdanh", (req: Request, res: Response): void => {
  // Destructure the request body to get the necessary data
  const { id_nhanvien, ngay, giovao, giora } = req.body as CapNhatChamCongInput;
  // Validate required fields
  if (!id_nhanvien || !ngay || !giovao || !giora) {
    const response: UpdateChamCongResponse = {
      success: false,
      message: "All required fields must be provided.",
      data: null,
    };
    res.status(400).json(response);
    return;

    // Create a new nhan vien object
  }
  const data: UpdateChamCongRawData = {
    id_nhanvien: id_nhanvien!,
    ngay: ngay!,
    giovao: giovao!,
    giora: giora!,
  };
  ChamCong.update(data, (err: Error | null) => {
    if (err) {
      console.log(err);
      const response: UpdateChamCongResponse = {
        success: false,
        message: "Error updating nhan vien",
        data: null,
      };
      res.status(500).json(response);
    }
    const response: UpdateChamCongResponse = {
      success: true,
      message: "Update nhan vien success",
      data: null,
    };
    res.json(response);
  });
});
router.get("chamcong30days", (req: Request, res: Response): void => {
  const { limit, page, sortBy, search } = req.body as PaginationRequest;

  NhanVien.getAll(
    { limit, page, sortBy, search },
    (err: Error | null, users: NhanVienRawData[]) => {
      if (err) {
        console.error(err);
        return res.status(404).send("Error fetching users");
      }

      const response = users.map((user) => {
        let userChamCong: {
          id_nhanvien: number;
          ten: string;
          phong_ban: string;
          cham_congs: ChamCong30DaysRawData[];
        } = {
          id_nhanvien: user.id,
          ten: user.ten,
          phong_ban: user.phongban,
          cham_congs: [],
        };

        ChamCong.ChamCongInLast30Days(
          { id: user.id.toString() },
          (err, results) => {
            if (err) {
              console.error(err);
              return res.status(500).json({
                success: false,
                message: "Error fetching cham cong data",
                data: null,
              });
            }
            userChamCong.cham_congs = results;
          }
        );
      });


      res.json({
        success: true,
        message: "Get all cham cong in last 30 days success",
        data: response,
      });
    }
  );
});
// router.get("/getAllChamCong", (req: Request, res: Response): void => {
//   const { limit = 10, page = 1 } = req.query; // Mặc định lấy 10 nhân viên mỗi trang

//   ChamCong.getAllWithPagination(
//     Number(page),
//     Number(limit),
//     (err: Error | null, users: ChamCong30RawData[], totalCount: number) => {
//       if (err) {
//         return res.status(500).json({
//           success: false,
//           message: "Lỗi khi lấy dữ liệu chấm công",
//           data: null,
//         });
//       }

//       // Tổ chức lại dữ liệu chấm công cho mỗi nhân viên
//       const formattedUsers = users.map((user) => {
//         // Lấy chấm công của từng nhân viên trong 30 ngày gần nhất
//         ChamCong.getAttendanceByNhanVien(
//           user.id_nhanvien,
//           (attendanceErr, attendanceRecords) => {
//             if (attendanceErr) {
//               return res.status(500).json({
//                 success: false,
//                 message: "Lỗi khi lấy dữ liệu chấm công của nhân viên",
//                 data: null,
//               });
//             }

//             // Tổ chức dữ liệu chấm công
//             const chamCongs = attendanceRecords.map((attendance) => ({
//               gio_vao: attendance.giovao,
//               gio_ra: attendance.giora,
//             }));

//             return {
//               id_nhan_vien: user.id_nhanvien,
//               ten: user.ten,
//               phong_ban: user.phong_ban,
//               cham_congs: chamCongs.slice(0, 30), // Giới hạn chỉ lấy 30 ngày gần nhất
//             };
//           }
//         );
//       });

//       const response: GetAllChamCong30Response = {
//         success: true,
//         message: "Lấy dữ liệu chấm công thành công",
//         data: users.map((user) => {
//           return {
//             id_nhan_vien: user.id_nhanvien,
//             cham_congs: [{ gio_vao: user.giovao, gio_ra: user.giora }],
//             ten: user.ten, // Tên nhân viên
//             phong_ban: user.phong_ban, // Phòng ban
//           };
//         }),
//         totalCount, // Trả về tổng số bản ghi trong cơ sở dữ liệu
//       };

//       res.json(response);
//     }
//   );
// });

// router.get("/getAllChamCong", (req: Request, res: Response): void => {
//   const { limit = 10, page = 1 } = req.query; // Mặc định lấy 10 nhân viên mỗi trang

//   // Lấy danh sách nhân viên với phân trang
//   ChamCong.getAllWithPagination(
//     Number(page),
//     Number(limit),
//     (err: Error | null, users: ChamCong30RawData[], totalCount: number) => {
//       if (err) {
//         return res.status(500).json({
//           success: false,
//           message: "Lỗi khi lấy dữ liệu chấm công",
//           data: null,
//         });
//       }

//       // Trả về danh sách nhân viên đã được chấm công với dữ liệu đúng
//       const response: GetAllChamCong30Response = {
//         success: true,
//         message: "Lấy dữ liệu chấm công thành công",
//         data: users,
//         totalCount, // Trả về tổng số nhân viên có dữ liệu
//       };

//       res.json(response);
//     }
//   );
// });
// router.get("/getChamCongByPage", (req: Request, res: Response): void => {
//   const { page = 1, limit = 10 } = req.query; // Lấy tham số phân trang từ query params

//   ChamCong.getChamCongByPage(
//     parseInt(page as string),
//     parseInt(limit as string),
//     (err: Error | null, results: ChamCong30RawData[], totalCount: number) => {
//       if (err) {
//         console.error(err);
//         return res.status(500).json({
//           success: false,
//           message: "Lỗi khi lấy dữ liệu chấm công.",
//           data: null,
//         });
//       }

//       const response: GetAllChamCong30Response = {
//         success: true,
//         message: "Lấy dữ liệu chấm công thành công.",
//         data: results,
//         totalCount: totalCount,
//       };

//       res.json(response);
//     }
//   );
// });
router.get("/getAllChamCong", (req: Request, res: Response): void => {
  const { limit, page, sortBy, search } = req.body as PaginationRequest;

  const pagination = { limit, page, sortBy, search };

  ChamCong.getChamCongByNhanVien(
    pagination,
    (
      err: QueryError | null,
      chamCongData: ChamCong30RawData[],
      totalCount: number
    ) => {
      if (err) {
        return res.status(404).send("Error fetching cham cong data");
      }

      const response: GetAllChamCong30Response = {
        success: true,
        message: "Get all cham cong data success",
        data: chamCongData,
        totalCount: totalCount,
      };

      res.json(response);
    }
  );
});
export default router;
