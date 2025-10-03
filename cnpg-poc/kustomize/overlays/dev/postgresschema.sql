CREATE TABLE source(
	source_id int NOT NULL GENERATED ALWAYS AS IDENTITY(START WITH 1 INCREMENT BY 1),
	name varchar(50) NOT NULL,
 CONSTRAINT PK_source_id PRIMARY KEY
(
	source_id
)
);

INSERT INTO source (name) VALUES ('Zvelo');
INSERT INTO source (name) VALUES ('Trellix');
INSERT INTO source (name) VALUES ('Other');


CREATE TABLE urls(
	url_id bigint NOT NULL GENERATED ALWAYS AS IDENTITY(START WITH 1 INCREMENT BY 1),
	url text NOT NULL,
	domain_name_trellix varchar(256) NULL,
	domain_name_zvelo varchar(256) NULL,
	active_domain varchar(10) NOT NULL,
	webrep smallint NOT NULL,
        source varchar(50) NOT NULL,
	prevalence int NOT NULL,
	publish_xl Boolean NOT NULL,
	publish_ts Boolean NOT NULL,
	publish_ng Boolean NOT NULL,
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

CREATE INDEX IX_urls_domain_name_trellix ON urls
(
	domain_name_trellix ASC
) ;

CREATE INDEX IX_urls_domain_name_zvelo ON urls
(
	domain_name_zvelo ASC
) ;

CREATE INDEX IX_urls_active_domain ON urls
(
	active_domain ASC
) ;

CREATE INDEX IX_urls_webrep ON urls
(
	webrep ASC
) ;

CREATE INDEX IX_urls_prevalence ON urls
(
	prevalence ASC
) ;



CREATE TABLE categories_trellix(
	cat_id int NOT NULL GENERATED ALWAYS AS IDENTITY(START WITH 1 INCREMENT BY 1),
	cat_short varchar(2) NOT NULL,
	cat_frame varchar(20) NOT NULL,
	cat_long varchar(50) NOT NULL,
	short_name varchar(4) NULL,
	cat_code_four int NULL,
	description Text NULL,
	webrep smallint NOT NULL,
	risk_group varchar(20) NOT NULL,
	functional_group varchar(30) NULL,
	modified_by int NULL,
	modified_date Timestamp(6) NOT NULL,
 CONSTRAINT PK_categories_trellix_id PRIMARY KEY
(
	cat_id
)
);

ALTER TABLE categories_trellix ALTER COLUMN webrep SET DEFAULT ((0)) ;

ALTER TABLE categories_trellix ALTER COLUMN modified_date SET DEFAULT (now()) ;

ALTER TABLE categories_trellix ADD CONSTRAINT FK_categories_trellix_modified_by FOREIGN KEY(modified_by)
REFERENCES source (source_id) NOT VALID;

ALTER TABLE categories_trellix VALIDATE CONSTRAINT FK_categories_trellix_modified_by;

CREATE INDEX IX_categories_trellix_cat_short ON categories_trellix
(
	cat_short ASC
) ;


CREATE TABLE categories_zvelo(
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
 CONSTRAINT PK_categories_zvelo_id PRIMARY KEY
(
	cat_id
)
);

ALTER TABLE categories_zvelo ALTER COLUMN webrep SET DEFAULT ((0)) ;

ALTER TABLE categories_zvelo ALTER COLUMN modified_date SET DEFAULT (now()) ;

ALTER TABLE categories_zvelo ADD CONSTRAINT FK_categories_zvelo_modified_by FOREIGN KEY(modified_by)
REFERENCES source (source_id) NOT VALID;

ALTER TABLE categories_zvelo VALIDATE CONSTRAINT FK_categories_zvelo_modified_by;

CREATE INDEX IX_categories_zvelo_cat_short ON categories_zvelo
(
	cat_short ASC
) ;


CREATE TABLE url_categories_trellix(
	url_cat_id bigint NOT NULL GENERATED ALWAYS AS IDENTITY(START WITH 1 INCREMENT BY 1),
	url_id bigint NOT NULL,
	cat_id int NOT NULL,
 CONSTRAINT PK_url_categories_trellix_id PRIMARY KEY
(
	url_cat_id
)
);

ALTER TABLE url_categories_trellix ADD CONSTRAINT FK_url_categories_trellix_cat_id FOREIGN KEY(cat_id)
REFERENCES categories_trellix (cat_id);

ALTER TABLE url_categories_trellix VALIDATE CONSTRAINT FK_url_categories_trellix_cat_id;

ALTER TABLE url_categories_trellix ADD CONSTRAINT FK_url_categories_trellix_url_id FOREIGN KEY(url_id)
REFERENCES urls (url_id) NOT VALID;

ALTER TABLE url_categories_trellix VALIDATE CONSTRAINT FK_url_categories_trellix_url_id;

CREATE INDEX IX_url_categories_trellix_url_id ON url_categories_trellix
(
	url_id ASC
) ;

CREATE INDEX IX_url_categories_trellix_cat_id ON url_categories_trellix
(
	cat_id ASC
) ;


CREATE TABLE url_categories_zvelo(
	url_cat_id bigint NOT NULL GENERATED ALWAYS AS IDENTITY(START WITH 1 INCREMENT BY 1),
	url_id bigint NOT NULL,
	cat_id int NOT NULL,
 CONSTRAINT PK_url_categories_zvelo_id PRIMARY KEY
(
	url_cat_id
)
);

ALTER TABLE url_categories_zvelo ADD CONSTRAINT FK_url_categories_zvelo_cat_id FOREIGN KEY(cat_id)
REFERENCES categories_zvelo (cat_id);

ALTER TABLE url_categories_zvelo VALIDATE CONSTRAINT FK_url_categories_zvelo_cat_id;

ALTER TABLE url_categories_zvelo ADD CONSTRAINT FK_url_categories_zvelo_url_id FOREIGN KEY(url_id)
REFERENCES urls (url_id) NOT VALID;

ALTER TABLE url_categories_zvelo VALIDATE CONSTRAINT FK_url_categories_zvelo_url_id;

CREATE INDEX IX_url_categories_zvelo_url_id ON url_categories_zvelo
(
	url_id ASC
) ;

CREATE INDEX IX_url_categories_zvelo_cat_id ON url_categories_zvelo
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

INSERT INTO audit_trail_attributes (attribute, modified_by, modified_date) VALUES ('URL Category Deleted', 2, now());
INSERT INTO audit_trail_attributes (attribute, modified_by, modified_date) VALUES ('URL Category Updated', 2, now());
INSERT INTO audit_trail_attributes (attribute, modified_by, modified_date) VALUES ('URL Domain Deleted', 2, now());
INSERT INTO audit_trail_attributes (attribute, modified_by, modified_date) VALUES ('URL Domain Updated', 2, now());
INSERT INTO audit_trail_attributes (attribute, modified_by, modified_date) VALUES ('URL Web Reputation Updated', 2, now());
INSERT INTO audit_trail_attributes (attribute, modified_by, modified_date) VALUES ('URL Prevalence Updated', 2, now());


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
