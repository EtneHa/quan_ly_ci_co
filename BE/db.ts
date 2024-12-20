import mysql, { Connection } from 'mysql2';

// Create the MySQL connection object with TypeScript type annotations
const connection: Connection = mysql.createConnection({
  host: "localhost",
  user: "root",  // MySQL user
  password: "",  // MySQL password
  database: "quanlynhanvien",  // Database name
});

// Establish the connection and handle errors
connection.connect((err: any | null) => {
  if (err) {
    console.error("Error connecting to MySQL: " + err.stack);
    return;
  }
  console.log("Connected to MySQL as id " + connection.threadId);
});

export default connection;
