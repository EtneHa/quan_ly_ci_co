import express, { Request, Response } from "express";
import { BaseResponse } from "../data_model";
import NhanVien, {
  CreateNhanVienRawData,
  NhanVienRawData,
  UpdateNhanVienRawData,
} from "../models/NhanVien";
import {
  CreateNhanVienResponse,
  GetAllNhanVienResponse,
  PaginationRequest,
  TaoNhanVienInput,
  UpdateNhanVienResponse,
  CapNhatNhanVienInput,
  TimKiemNhanVienInput,
} from "../data_model";

const router = express.Router();

router.post("/getAllNhanVien", (req: Request, res: Response): void => {
  const { limit, page, sortBy, search } = req.body as PaginationRequest;

  NhanVien.getAll(
    { limit, page, sortBy, search },
    (err: Error | null, users: NhanVienRawData[]) => {
      if (err) {
        console.error(err);
        return res.status(404).send("Error fetching users");
      }

      const response: GetAllNhanVienResponse = {
        success: true,
        message: "Get all nhan vien success",
        data: users,
      };

      res.json(response);
    }
  );
});

router.post("/createNhanVien", (req: Request, res: Response): void => {
  // Destructure the request body to get the necessary data
  const { ten, ngaysinh, sodienthoai, phongban, chucvu, ngaybatdau } =
    req.body as TaoNhanVienInput;

  // Validate required fields
  if (!ten || !phongban || !chucvu) {
    const response: CreateNhanVienResponse = {
      success: false,
      message: "All required fields must be provided.",
      data: null,
    };

    res.status(400).json(response);
  }

  // Create a new nhan vien object
  const data: CreateNhanVienRawData = {
    ten: ten!,
    ngaysinh: ngaysinh!,
    sodienthoai: sodienthoai!,
    phongban: phongban!,
    chucvu: chucvu!,
    ngaybatdau: ngaybatdau!,
  };
  NhanVien.create(data, (err: Error | null, id: number) => {
    if (err) {
      console.log(err);
      const response: CreateNhanVienResponse = {
        success: false,
        message: "Error creating nhan vien",
        data: null,
      };

      res.status(500).json(response);
    }

    const response: CreateNhanVienResponse = {
      success: true,
      message: "Create nhan vien success",
      data: { id },
    };
    res.json(response);
  });
});
// routes/nvRoutes.ts
router.post("/updateNhanVien", (req: Request, res: Response): void => {
  const {
    id,
    ten,
    ngaysinh,
    sodienthoai,
    phongban,
    chucvu,
    email,
    ngaybatdau,
  } = req.body as CapNhatNhanVienInput;

  // Kiểm tra trường hợp không có id hoặc các trường bắt buộc
  if (!id) {
    const response: UpdateNhanVienResponse = {
      success: false,
      message: "ID must be provided.",
      data: null,
    };
    res.status(400).json(response);
    return;
  }

  if (!ten || !phongban || !chucvu || !email) {
    const response: UpdateNhanVienResponse = {
      success: false,
      message: "All required fields must be provided.",
      data: null,
    };
    res.status(400).json(response);
    return;
  }

  // Kiểm tra email trùng
  NhanVien.getByEmail(
    email,
    (err: Error | null, results: NhanVienRawData[]) => {
      if (err) {
        const response: UpdateNhanVienResponse = {
          success: false,
          message: "Error checking email.",
          data: null,
        };
        return res.status(500).json(response);
      }

      if (results.length > 0 && results[0].id !== id) {
        const response: UpdateNhanVienResponse = {
          success: false,
          message: "Email is already in use by another user.",
          data: null,
        };
        return res.status(400).json(response);
      }

      // Cập nhật nhân viên
      const updateData: UpdateNhanVienRawData = {
        ten,
        ngaysinh,
        sodienthoai,
        phongban,
        chucvu,
        email,
        ngaybatdau,
      };

      NhanVien.update(id, updateData, (err: Error | null, result: any) => {
        if (err) {
          const response: UpdateNhanVienResponse = {
            success: false,
            message: "Error updating nhan vien",
            data: null,
          };
          return res.status(500).json(response);
        }

        const response: UpdateNhanVienResponse = {
          success: true,
          message: "Update nhan vien success",
          data: result,
        };
        res.json(response);
      });
    }
  );
});

// router.delete("/xoanhanvien/:id", (req: Request, res: Response): void => {
//   const id = parseInt(req.params.id);
//   NhanVien.delete(id, (err: Error | null) => {
//     if (err) {
//       console.log(err);
//       const response: CreateNhanVienResponse = {
//         success: false,
//         message: "Error deleting nhan vien",
//         data: null,
//       };
//       res.status(500).json(response);
//     }
//     const response: CreateNhanVienResponse = {
//       success: true,
//       message: "Delete nhan vien success",
//       data: null,
//     };
//     res.json(response);
//   });
// });

// routes/nvRoutes.ts
router.post("/deleteNhanVien", (req: Request, res: Response): void => {
  const { id } = req.body as { id: number };

  // Kiểm tra xem id có tồn tại không
  if (!id) {
    const response: BaseResponse = {
      success: false,
      message: "Employee ID must be provided.",
    };
    res.status(400).json(response);
    return;
  }

  // Xóa nhân viên chỉ trên UI, không thực hiện thao tác trong cơ sở dữ liệu
  // Bạn có thể thực hiện xóa trên frontend sau khi nhận phản hồi từ API
  const response: BaseResponse = {
    success: true,
    message: "Employee removed from the UI (not from the database).",
  };

  res.json(response);
});
// router.get("/searchNhanVien", (req: Request, res: Response): void => {
//   // Lấy từ khóa tìm kiếm từ query parameters
//   const { limit, page, sortBy } = req.query; // Dùng req.query thay vì req.body
//   const { searchTerm } = req.query;

//   // Kiểm tra xem từ khóa tìm kiếm có hợp lệ không
//   if (!searchTerm || typeof searchTerm !== "string") {
//     const response: TimKiemhanVienResponse = {
//       success: false,
//       message: "Search term is required and should be a string.",
//       data: [],
//     };
//     res.status(400).json(response); // Thêm return để dừng xử lý
//     return;
//   }

//   // Gọi phương thức search để tìm nhân viên
//   NhanVien.search(searchTerm, (err: Error | null, users: NhanVienRawData[]) => {
//     if (err) {
//       const response: TimKiemhanVienResponse = {
//         success: false,
//         message: "Error fetching search results",
//         data: [],
//       };
//       return res.status(500).json(response); // Thêm return để dừng xử lý
//     }

//     // Kiểm tra xem users có phải là một mảng hợp lệ không
//     if (!Array.isArray(users)) {
//       const response: TimKiemhanVienResponse = {
//         success: false,
//         message: "Unexpected response format",
//         data: [],
//       };
//       return res.status(500).json(response); // Thêm return để dừng xử lý
//     }

//     const response: TimKiemhanVienResponse = {
//       success: true,
//       message: "Search results fetched successfully",
//       data: users,
//     };
//     return res.json(response); // Thêm return để dừng xử lý
//   });
// });

// router.get("/searchNhanVien", (req: Request, res: Response): void => {
//   // Lấy tham số phân trang từ query parameters
//   const { limit, page, sortBy } = req.query;
//   const { searchTerm } = req.query;

//   // Kiểm tra xem từ khóa tìm kiếm có hợp lệ không
//   if (!searchTerm || typeof searchTerm !== "string") {
//     const response: TimKiemhanVienResponse = {
//       success: false,
//       message: "Search term is required and should be a string.",
//       data: [],
//     };
//     res.status(400).json(response);
//     return;
//   }

//   // Kiểm tra các tham số phân trang và đảm bảo giá trị hợp lệ
//   const pageNumber = page ? parseInt(page as string) : 1;
//   const pageLimit = limit ? parseInt(limit as string) : 10;
//   const offset = (pageNumber - 1) * pageLimit;

//   // Gọi phương thức search để tìm nhân viên với phân trang
//   NhanVien.searchWithPagination(
//     searchTerm,
//     offset,
//     pageLimit,
//     (
//       err: Error | null,
//       result: { users: NhanVienRawData[]; total: number }
//     ) => {
//       if (err) {
//         const response: TimKiemhanVienResponse = {
//           success: false,
//           message: "Error fetching search results",
//           data: [],
//         };
//         return res.status(500).json(response);
//       }

//       // Kiểm tra xem users có phải là một mảng hợp lệ không
//       if (!Array.isArray(result.users)) {
//         const response: TimKiemhanVienResponse = {
//           success: false,
//           message: "Unexpected response format",
//           data: [],
//         };
//         return res.status(500).json(response);
//       }

//       // Tính tổng số trang
//       const totalPages = Math.ceil(result.total / pageLimit);

//       const response: TimKiemhanVienResponse = {
//         success: true,
//         message: "Search results fetched successfully",
//         data: result.users,
//         pagination: {
//           total: result.total,
//           totalPages: totalPages,
//           currentPage: pageNumber,
//           limit: pageLimit,
//         },
//       };

//       return res.json(response);
//     }
//   );
// });

// router.get("/searchNhanVien", (req: Request, res: Response): void => {
//   // Lấy các tham số phân trang từ query parameters
//   const { limit, page, sortBy } = req.query;

//   // Lấy các tham số tìm kiếm từ query string
//   const { ten, ngaysinh, sodienthoai, phongban, chucvu, ngaybatdau } =
//     req.query;

//   // Kiểm tra nếu không có bất kỳ tham số tìm kiếm nào
//   const searchParams: TimKiemNhanVienInput = {
//     ten: ten as string,
//     ngaysinh: ngaysinh as string,
//     sodienthoai: sodienthoai as string,
//     phongban: phongban as string,
//     chucvu: chucvu as string,
//     ngaybatdau: ngaybatdau as string,
//   };

//   // Kiểm tra tham số phân trang
//   const pageNumber = page ? parseInt(page as string) : 1;
//   const pageLimit = limit ? parseInt(limit as string) : 10;
//   const offset = (pageNumber - 1) * pageLimit;

//   // Gọi phương thức search để tìm nhân viên với phân trang
//   NhanVien.searchWithPagination(
//     searchParams,
//     offset,
//     pageLimit,
//     (
//       err: Error | null,
//       result: { users: NhanVienRawData[]; total: number }
//     ) => {
//       if (err) {
//         const response: TimKiemNhanVienResponse = {
//           success: false,
//           message: "Error fetching search results",
//           data: [],
//         };
//         return res.status(500).json(response);
//       }

//       // Kiểm tra xem users có phải là một mảng hợp lệ không
//       if (!Array.isArray(result.users)) {
//         const response: TimKiemNhanVienResponse = {
//           success: false,
//           message: "Unexpected response format",
//           data: [],
//         };
//         return res.status(500).json(response);
//       }

//       // Tính tổng số trang
//       const totalPages = Math.ceil(result.total / pageLimit);

//       const response: TimKiemNhanVienResponse = {
//         success: true,
//         message: "Search results fetched successfully",
//         data: result.users,
//         pagination: {
//           total: result.total,
//           totalPages: totalPages,
//           currentPage: pageNumber,
//           limit: pageLimit,
//         },
//       };

//       return res.json(response);
//     }
//   );
// });
export default router;
