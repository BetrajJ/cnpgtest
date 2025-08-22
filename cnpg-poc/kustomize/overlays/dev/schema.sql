-- Create schema
CREATE SCHEMA IF NOT EXISTS data_schema;

-- Users table
CREATE TABLE IF NOT EXISTS data_schema.users (
  id SERIAL PRIMARY KEY,
  username VARCHAR(50) UNIQUE NOT NULL,
  email VARCHAR(100) UNIQUE NOT NULL,
  first_name VARCHAR(50),
  last_name VARCHAR(50),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  status VARCHAR(20) DEFAULT 'active' CHECK (status IN ('active', 'inactive', 'suspended'))
);

-- Indexes for users
CREATE INDEX IF NOT EXISTS idx_users_username ON data_schema.users(username);
CREATE INDEX IF NOT EXISTS idx_users_email ON data_schema.users(email);
CREATE INDEX IF NOT EXISTS idx_users_status ON data_schema.users(status);
CREATE INDEX IF NOT EXISTS idx_users_created_at ON data_schema.users(created_at);

-- Orders table
CREATE TABLE IF NOT EXISTS data_schema.orders (
  id SERIAL PRIMARY KEY,
  user_id INTEGER REFERENCES data_schema.users(id),
  order_number VARCHAR(20) UNIQUE NOT NULL,
  total_amount DECIMAL(10,2),
  order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Indexes for orders
CREATE INDEX IF NOT EXISTS idx_orders_user_id ON data_schema.orders(user_id);
CREATE INDEX IF NOT EXISTS idx_orders_order_number ON data_schema.orders(order_number);
