import express, { Request, Response } from "express";
import NghiPhep, {
  CreateNghiPhepRawData,
  NghiPhepRawData,
} from "../models/NghiPhep";
import {
  CreateNghiPhepResponse,
  GetAllNghiPhepResponse,
  PaginationRequest,
  TaoNghiPhepInput,
} from "../data_model";

const router = express.Router();

router.get("/getAllNghiPhep", (req: Request, res: Response): void => {
  const { limit, page, sortBy } = req.body as PaginationRequest;

  NghiPhep.getAll((err: Error | null, users: NghiPhepRawData[]) => {
    if (err) {
      return res.status(404).send("Error fetching users");
    }

    const response: GetAllNghiPhepResponse = {
      success: true,
      message: "Get all nhan vien success",
      data: users,
    };

    res.json(response);
  });
});

router.post("/createNhanVien", (req: Request, res: Response): void => {
  // Destructure the request body to get the necessary data
  const { id_nhanvien, ngaynghi, lydo, trangthai } =
    req.body as TaoNghiPhepInput;

  // Validate required fields
  if (!id_nhanvien || !ngaynghi || !lydo) {
    const response: CreateNghiPhepResponse = {
      success: false,
      message: "All required fields must be provided.",
      data: null,
    };

    res.status(400).json(response);
  }

  // Create a new nhan vien object
  const data: CreateNghiPhepRawData = {
    id_nhanvien: id_nhanvien!,
    ngaynghi: ngaynghi!,
    lydo: lydo!,
    trangthai: trangthai!,
  };
  NghiPhep.create(data, (err: Error | null, id: number) => {
    if (err) {
      console.log(err);
      const response: CreateNghiPhepResponse = {
        success: false,
        message: "Error creating nhan vien",
        data: null,
      };

      res.status(500).json(response);
    }

    const response: CreateNghiPhepResponse = {
      success: true,
      message: "Create nhan vien success",
      data: { id },
    };
    res.json(response);
  });
});
export default router;
