import { Connection, QueryError } from "mysql2";
import connection from "../db"; // Assuming db.ts uses a connection pool

interface AdminUserData {
  username: string;
  email: string;
  password: string;
}

class AdminUser {
  // Using the correct types for callback
  static create(
    data: AdminUserData,
    callback: (err: QueryError | null, results: any) => void
  ): void {
    const { username, email, password } = data;
    const query = `INSERT INTO admin_users (username, email, password) VALUES (?, ?, ?)`;

    connection.query(query, [username, email, password], callback);
  }

  static getAll(
    callback: (err: QueryError | null, results: any) => void
  ): void {
    const query = `SELECT * FROM admin_users`;
    connection.query(query, callback);
  }

  static getById(
    id: number,
    callback: (err: QueryError | null, results: any) => void
  ): void {
    const query = `SELECT * FROM admin_users WHERE id = ?`;
    connection.query(query, [id], callback);
  }

  static update(
    id: number,
    data: AdminUserData,
    callback: (err: QueryError | null, results: any) => void
  ): void {
    const { username, email, password } = data;
    const query = `UPDATE admin_users SET username = ?, email = ?, password = ? WHERE id = ?`;

    connection.query(query, [username, email, password, id], callback);
  }

  static delete(
    id: number,
    callback: (err: QueryError | null, results: any) => void
  ): void {
    const query = `DELETE FROM admin_users WHERE id = ?`;
    connection.query(query, [id], callback);
  }
}

export default AdminUser;
