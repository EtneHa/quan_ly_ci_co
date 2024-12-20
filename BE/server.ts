import express, { Request, Response } from "express";
import bodyParser from "body-parser";
import authRoutes from "./routes/authRoutes";
import nhanvienRoutes from "./routes/nhanvienRoutes";
import chamcongRoutes from "./routes/chamcongRoutes";
import cors from "cors";
const corsOptions = {
  allowedHeaders: ["Content-Type", "Authorization", "User-Agent"], // Explicitly allow User-Agent
};
const app: express.Application = express();
const port: number = 3000;
app.use(cors(corsOptions));

app.use(bodyParser.json());
app.use("/api/auth", authRoutes);
app.use("/api/nhanvien", nhanvienRoutes);
app.use("/api/chamcong", chamcongRoutes);
app.listen(port, () => {
  console.log(`Server running at http://localhost:${port}`);
});
