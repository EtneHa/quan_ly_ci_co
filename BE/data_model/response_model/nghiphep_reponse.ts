import { NghiPhepRawData } from "../../models/NghiPhep";
import { BaseResponse } from "./base_response";

export type GetAllNghiPhepResponse = BaseResponse & {
  data: NghiPhepRawData[];
};

export type CreateNghiPhepResponse = BaseResponse & {
  data: {
    id: number;
  } | null;
};
