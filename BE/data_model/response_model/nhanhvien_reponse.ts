import { NhanVienRawData } from "../../models/NhanVien";
import { BaseResponse } from "./base_response";

export type GetAllNhanVienResponse = BaseResponse & {
  data: NhanVienRawData[];
  totalCount: number;
};

export type CreateNhanVienResponse = BaseResponse & {
  data: { id: number } | null;
};

export interface UpdateNhanVienResponse extends BaseResponse {
  data: any; // Dữ liệu trả về khi cập nhật thành công
}

export type GetNhanVienByIdResponse = BaseResponse & {
  data: NhanVienRawData | null;
};

export type DeleteNhanVienResponse = BaseResponse & {
  data: {
    id: number;
  } | null;
};

export type TimKiemNhanVienResponse = {
  success: boolean;
  message: string;
  data: NhanVienRawData[]; // Kết quả tìm kiếm
  pagination?: {
    total: number; // Tổng số nhân viên
    totalPages: number; // Tổng số trang
    currentPage: number; // Trang hiện tại
    limit: number; // Số lượng bản ghi mỗi trang
  };
};
