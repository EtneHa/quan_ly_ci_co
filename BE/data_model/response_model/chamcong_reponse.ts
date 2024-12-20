import { ChamCong30RawData, ChamCongRawData } from "../../models/ChamCong";
import { BaseResponse } from "./base_response";

export type GetAllChamCongResponse = BaseResponse & {
  data: ChamCongRawData[];
};
export type GetAllChamCong30Response = BaseResponse & {
  success: boolean;
  message: string;
  data: ChamCong30RawData[]; // Kiểu mảng chứa các đối tượng ChamCongRawData
  totalCount: number;
};
export type CreateChamCongResponse = BaseResponse & {
  data: {
    id: number;
  } | null;
};

export type UpdateChamCongResponse = BaseResponse & {
  data: {
    id: number;
  } | null;
};

export type DeleteChamCongResponse = BaseResponse & {
  data: {
    id: number;
  } | null;
};

export type GetChamCongByIdResponse = BaseResponse & {
  data: ChamCongRawData | null;
};

export type ChamCongInLast30DaysResponse = BaseResponse & {
  data: ChamCongRawData | null;
};
