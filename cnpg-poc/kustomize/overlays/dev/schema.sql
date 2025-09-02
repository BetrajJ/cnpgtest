CREATE TABLE source(
	source_id int NOT NULL GENERATED ALWAYS AS IDENTITY(START WITH 1 INCREMENT BY 1),
	name varchar(50) NOT NULL,
 CONSTRAINT PK_source_id PRIMARY KEY 
(
	source_id
) 
);

CREATE TABLE urls(
	url_id bigint NOT NULL GENERATED ALWAYS AS IDENTITY(START WITH 1 INCREMENT BY 1),
	url text NOT NULL,
	domain_name varchar(256) NULL,
	webrep smallint NOT NULL,
	source varchar(50) NOT NULL,
	memo text NULL,
	modified_by int NULL,
	modified_date Timestamp(6) NOT NULL,
 CONSTRAINT PK_urls_id PRIMARY KEY 
(
	url_id
) 
);

ALTER TABLE urls ADD  CONSTRAINT CK_urls_source CHECK  ((source = 'Cerberian' or (source = 'CLT' or (source = 'Customer' or (source = 'Legacy' or (source = 'N2H2' or (source = 'Rulespace' or (source = 'WebWasher' or (source = 'Saudi' or (source = 'Siemens' or source = 'VertexLink')))))))))) NOT VALID;
 
ALTER TABLE urls VALIDATE CONSTRAINT CK_urls_source;

ALTER TABLE urls ADD CONSTRAINT FK_urls_modified_by FOREIGN KEY(modified_by)
REFERENCES source (source_id) NOT VALID;
 
ALTER TABLE urls VALIDATE CONSTRAINT FK_urls_modified_by;


CREATE INDEX IX_urls_domain_name ON urls
(
	domain_name ASC
) ;

CREATE INDEX IX_urls_webrep ON urls
(
	webrep ASC
) ;


CREATE TABLE categories(
	cat_id int NOT NULL GENERATED ALWAYS AS IDENTITY(START WITH 1 INCREMENT BY 1),
	cat_short varchar(2) NOT NULL,
	cat_frame varchar(10) NOT NULL,
	cat_long varchar(50) NOT NULL,
	short_name varchar(2) NULL,
	cat_code_four int NULL,
	description Text NULL,
	webrep smallint NOT NULL,
	risk_group varchar(20) NOT NULL,
	functional_group varchar(30) NULL,
	modified_by int NULL,
	modified_date Timestamp(6) NOT NULL,
 CONSTRAINT PK_categories_id PRIMARY KEY 
(
	cat_id
) 
);

ALTER TABLE categories ALTER COLUMN webrep SET DEFAULT ((0)) ;

ALTER TABLE categories ALTER COLUMN modified_date SET DEFAULT (now()) ;

ALTER TABLE categories ADD CONSTRAINT FK_categories_modified_by FOREIGN KEY(modified_by)
REFERENCES source (source_id) NOT VALID;
 
ALTER TABLE categories VALIDATE CONSTRAINT FK_categories_modified_by;
 
CREATE INDEX IX_categories_cat_short ON categories
(
	cat_short ASC
) ;


CREATE TABLE url_categories(
	url_cat_id bigint NOT NULL GENERATED ALWAYS AS IDENTITY(START WITH 1 INCREMENT BY 1),
	url_id bigint NOT NULL,
	cat_id int NOT NULL,
 CONSTRAINT PK_url_categories_id PRIMARY KEY 
(
	url_cat_id
) 
);

ALTER TABLE url_categories ADD CONSTRAINT FK_url_categories_cat_id FOREIGN KEY(cat_id)
REFERENCES categories (cat_id);
 
ALTER TABLE url_categories VALIDATE CONSTRAINT FK_url_categories_cat_id;

ALTER TABLE url_categories ADD CONSTRAINT FK_url_categories_url_id FOREIGN KEY(url_id)
REFERENCES urls (url_id) NOT VALID;
 
ALTER TABLE url_categories VALIDATE CONSTRAINT FK_url_categories_url_id;
 
CREATE INDEX IX_url_categories_url_id ON url_categories
(
	url_id ASC
) ;
 
CREATE INDEX IX_url_categories_cat_id ON url_categories
(
	cat_id ASC
) ;


CREATE TABLE url_attribute_types(
	url_attribute_types_id int GENERATED ALWAYS AS IDENTITY(START WITH 1 INCREMENT BY 1) NOT NULL,
	attribute varchar(50) NOT NULL,
	description varchar(255) NULL,
	webrep smallint NOT NULL,
	modified_by int NULL,
	modified_date Timestamp(6) NOT NULL,
 CONSTRAINT PK_url_attribute_types_id PRIMARY KEY 
(
	url_attribute_types_id
) 
);

ALTER TABLE url_attribute_types ADD CONSTRAINT FK_url_attribute_types_modified_by FOREIGN KEY(modified_by)
REFERENCES source (source_id) NOT VALID;
 
ALTER TABLE url_attribute_types VALIDATE CONSTRAINT FK_url_attribute_types_modified_by;
 

CREATE TABLE url_attributes(
	url_attributes_id int NOT NULL GENERATED ALWAYS AS IDENTITY(START WITH 1 INCREMENT BY 1),
	url_id bigint NOT NULL,
	attribute_type_id int NOT NULL,
 CONSTRAINT PK_url_attributes_id PRIMARY KEY 
(
	url_attributes_id
) 
);

ALTER TABLE url_attributes ADD  CONSTRAINT FK_url_attributes_attribute_type_id FOREIGN KEY(attribute_type_id)
REFERENCES url_attribute_types (url_attribute_types_id);
 
ALTER TABLE url_attributes VALIDATE CONSTRAINT FK_url_attributes_attribute_type_id;
 
ALTER TABLE url_attributes ADD  CONSTRAINT FK_url_attributes_url_id FOREIGN KEY(url_id)
REFERENCES urls (url_id) NOT VALID;
 
ALTER TABLE url_attributes VALIDATE CONSTRAINT FK_url_attributes_url_id;
 
CREATE INDEX IX_url_attributes_url_id ON url_attributes
(
	url_id ASC
) ;
 
CREATE INDEX IX_url_attributes_attribute_type_id ON url_attributes
(
	attribute_type_id ASC
) ;


CREATE TABLE prevalence(
	prevalence_id int NOT NULL GENERATED ALWAYS AS IDENTITY(START WITH 1 INCREMENT BY 1),
	url_id bigint NOT NULL,
	prevalence int NOT NULL,
	publish_xl Boolean NOT NULL,
	publish_ts Boolean NOT NULL,
	publish_ng Boolean NOT NULL,
	modified_by int NULL,
	modified_date Timestamp(6) NOT NULL,
 CONSTRAINT PK_prevalence_id PRIMARY KEY 
(
	prevalence_id
) 
);

ALTER TABLE prevalence ADD  CONSTRAINT FK_prevalence_url_id FOREIGN KEY(url_id)
REFERENCES urls (url_id);
 
ALTER TABLE prevalence VALIDATE CONSTRAINT FK_prevalence_url_id;

ALTER TABLE prevalence ADD CONSTRAINT FK_prevalence_modified_by FOREIGN KEY(modified_by)
REFERENCES source (source_id) NOT VALID;
 
ALTER TABLE prevalence VALIDATE CONSTRAINT FK_prevalence_modified_by;

 
CREATE INDEX IX_prevalence_url_id ON prevalence
(
	url_id ASC
) ;
 
CREATE INDEX IX_prevalence_prevalence ON prevalence
(
	prevalence ASC
) ;


CREATE TABLE web_reputation_levels(
	type_id smallint NOT NULL GENERATED ALWAYS AS IDENTITY(START WITH 1 INCREMENT BY 1),
	name varchar(20) NOT NULL,
	description varchar(200) NOT NULL,
	min smallint NOT NULL,
	max smallint NOT NULL,
 CONSTRAINT PK_web_reputation_levels_id PRIMARY KEY
(
	type_id
) 
); 


CREATE TABLE tlds(
	tld_id int NOT NULL GENERATED ALWAYS AS IDENTITY(START WITH 1 INCREMENT BY 1),
	tld varchar(50) NOT NULL,
	active Smallint NULL,
	modified_by int NULL,
	modified_date Timestamp(6) NOT NULL,
 CONSTRAINT PK_tlds_id PRIMARY KEY 
(
	tld_id
) 
);

ALTER TABLE tlds ALTER COLUMN active  SET DEFAULT ((1)) ;

ALTER TABLE tlds ADD CONSTRAINT FK_tlds_modified_by FOREIGN KEY(modified_by)
REFERENCES source (source_id) NOT VALID;
 
ALTER TABLE tlds VALIDATE CONSTRAINT FK_tlds_modified_by;


CREATE INDEX IX_tlds_tld ON tlds
(
	tld ASC
) ;


CREATE TABLE audit_trail_attributes(
	audit_trail_attribute_id int NOT NULL GENERATED ALWAYS AS IDENTITY(START WITH 1 INCREMENT BY 1),
	attribute varchar(50) NOT NULL,
	modified_by int NULL,
	modified_date Timestamp(6) NOT NULL,
 CONSTRAINT PK_audit_trail_attributes_id PRIMARY KEY 
(
	audit_trail_attribute_id
) 
);

ALTER TABLE audit_trail_attributes ALTER COLUMN modified_date SET DEFAULT (now()) ;

ALTER TABLE audit_trail_attributes ADD CONSTRAINT FK_audit_trail_attributes_modified_by FOREIGN KEY(modified_by)
REFERENCES source (source_id) NOT VALID;
 
ALTER TABLE audit_trail_attributes VALIDATE CONSTRAINT FK_audit_trail_attributes_modified_by;


CREATE TABLE audit_trail(
	audit_trail_id int NOT NULL GENERATED ALWAYS AS IDENTITY(START WITH 1 INCREMENT BY 1),
	modified_attribute_id int NOT NULL,
	modified_url_id bigint NULL,
	old_value text NOT NULL,
	new_value text NOT NULL,
	modified_by int NULL,
	modified_date Timestamp(6) NOT NULL,
 CONSTRAINT PK_audit_trail_id PRIMARY KEY 
(
	audit_trail_id
) 
);

ALTER TABLE audit_trail ADD CONSTRAINT FK_audit_trail_audit_trail_id FOREIGN KEY(modified_attribute_id)
REFERENCES audit_trail_attributes (audit_trail_attribute_id);
 
ALTER TABLE audit_trail VALIDATE CONSTRAINT FK_audit_trail_audit_trail_id;

ALTER TABLE audit_trail ALTER COLUMN modified_date SET DEFAULT (now()) ;

ALTER TABLE audit_trail ADD CONSTRAINT FK_audit_trail_modified_by FOREIGN KEY(modified_by)
REFERENCES source (source_id) NOT VALID;
 
ALTER TABLE audit_trail VALIDATE CONSTRAINT FK_audit_trail_modified_by;

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
  landmark,
  department VARCHAR(100),                
  role VARCHAR(50),                       
  hire_date DATE DEFAULT CURRENT_DATE,   
  salary NUMERIC(12,2),                   
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  last_login TIMESTAMP,
  status VARCHAR(20) DEFAULT 'active' CHECK (status IN ('active', 'inactive', 'suspended'))
);
i
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
  payment_status VARCHAR(50),
  tracking_number VARCHAR(50),
  order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  status VARCHAR(20) DEFAULT 'pending' CHECK (status IN ('pending', 'paid', 'shipped', 'cancelled'))
);

-- Indexes for purchase
CREATE INDEX IF NOT EXISTS idx_purchase_worker_id ON test_schema.purchase(worker_id);
CREATE INDEX IF NOT EXISTS idx_purchase_order_number ON test_schema.purchase(order_number);
CREATE INDEX IF NOT EXISTS idx_purchase_status ON test_schema.purchase(status);
CREATE INDEX IF NOT EXISTS idx_purchase_order_date ON test_schema.purchase(order_date);
