import { Connection, QueryError } from "mysql2";
import connection from "../db"; // Assuming db.ts uses a connection pool

interface UserData {
  username: string;
  email: string;
  password: string;
}
const tableName = "users";
class User {
  // Using the correct types for callback
  static create(
    data: UserData,
    callback: (err: QueryError | null, results: any) => void
  ): void {
    const { username, email, password } = data;
    const query = `INSERT INTO ${tableName} (username, email, password) VALUES (?, ?, ?)`;

    connection.query(query, [username, email, password], callback);
  }

  static getAll(
    callback: (err: QueryError | null, results: any) => void
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
    id: number,
    data: UserData,
    callback: (err: QueryError | null, results: any) => void
  ): void {
    const { username, email, password } = data;
    const query = `UPDATE ${tableName} SET username = ?, email = ?, password = ? WHERE id = ?`;

    connection.query(query, [username, email, password, id], callback);
  }

  static delete(
    id: number,
    callback: (err: QueryError | null, results: any) => void
  ): void {
    const query = `DELETE FROM ${tableName} WHERE id = ?`;
    connection.query(query, [id], callback);
  }
}

export default User;
