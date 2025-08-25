-- Create schema
CREATE SCHEMA IF NOT EXISTS test_schema;

-- workers table
CREATE TABLE IF NOT EXISTS test_schema.workers (
  id SERIAL PRIMARY KEY,
  username VARCHAR(50) UNIQUE NOT NULL,
  email VARCHAR(100) UNIQUE NOT NULL,
  first_name VARCHAR(50),
  last_name VARCHAR(50),
  phone_number VARCHAR(20),
  address TEXT,
  department VARCHAR(100),                
  role VARCHAR(50),                       
  hire_date DATE DEFAULT CURRENT_DATE,   
  salary NUMERIC(12,2),                   
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  last_login TIMESTAMP,
  status VARCHAR(20) DEFAULT 'active' CHECK (status IN ('active', 'inactive', 'suspended'))
);

-- Indexes for workers
CREATE INDEX IF NOT EXISTS idx_workers_username ON test_schema.workers(username);
CREATE INDEX IF NOT EXISTS idx_workers_email ON test_schema.workers(email);
CREATE INDEX IF NOT EXISTS idx_workers_status ON test_schema.workers(status);
CREATE INDEX IF NOT EXISTS idx_workers_created_at ON test_schema.workers(created_at);

-- purchase table
CREATE TABLE IF NOT EXISTS test_schema.purchase (
  id SERIAL PRIMARY KEY,
  worker_id INTEGER REFERENCES test_schema.workers(id) ON DELETE CASCADE ON UPDATE CASCADE,
  order_number VARCHAR(20) UNIQUE NOT NULL,
  product_name VARCHAR(100),
  quantity INTEGER DEFAULT 1,  
  total_amount DECIMAL(10,2),
  currency VARCHAR(10) DEFAULT 'USD',
  shipping_address TEXT,
  billing_address TEXT,
  payment_method VARCHAR(50),
  tracking_number VARCHAR(50),
  order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  status VARCHAR(20) DEFAULT 'pending' CHECK (status IN ('pending', 'paid', 'shipped', 'cancelled'))
);

-- Indexes for purchase
CREATE INDEX IF NOT EXISTS idx_purchase_worker_id ON test_schema.purchase(worker_id);
CREATE INDEX IF NOT EXISTS idx_purchase_order_number ON test_schema.purchase(order_number);
CREATE INDEX IF NOT EXISTS idx_purchase_status ON test_schema.purchase(status);
CREATE INDEX IF NOT EXISTS idx_purchase_order_date ON test_schema.purchase(order_date);
