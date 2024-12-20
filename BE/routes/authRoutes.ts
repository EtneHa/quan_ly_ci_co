import express, { Request, Response } from "express";
import AdminUser from "../models/AdminUser";
import User from "../models/User";
import { LoginResponse } from "../data_model";

interface LoginInput {
  email: string;
  password: string;
}
const router = express.Router();

// Login route
router.post("/login", (req: Request, res: Response): void => {
  const { email, password } = req.body as LoginInput;

  AdminUser.getAll(
    (err: Error | null, users: Array<{ email: string; password: string }>) => {
      if (err) {
        return res.status(500).send("Internal server error");
      }

      const user = users.find((u) => u.email === email);
      console.log(user);

      if (!user) {
        return res.status(404).send("Login failed: User not found");
      }

      if (user.password === password) {
        const response: LoginResponse = {
          message: "Login success",
          success: true,
        };
        return res.json(response);
      } else {
        return res.status(400).send("Login failed: Incorrect password");
      }
    }
  );

  // User.getAll(
  //   (err: Error | null, users: Array<{ email: string; password: string }>) => {
  //     if (err) {
  //       return res.status(500).send("Internal server error");
  //     }

  //     const user = users.find((u) => u.email === email);
  //     console.log(user);

  //     if (!user) {
  //       return res.status(404).send("Login failed: User not found");
  //     }

  //     if (user.password === password) {
  //       const response: LoginResponse = {
  //         message: "Login success",
  //         success: true,
  //       };
  //       return res.json(response);
  //     } else {
  //       return res.status(400).send("Login failed: Incorrect password");
  //     }
  //   }
  // );
});

export default router;
