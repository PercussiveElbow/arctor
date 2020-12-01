-- +micrate Up
CREATE TABLE screenshots (
  id BIGSERIAL PRIMARY KEY,
  subdomain_id BIGSERIAL NOT NULL,
  FOREIGN KEY (subdomain_id) REFERENCES sub_domains(id),
  image VARCHAR,
  port INTEGER,
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);


-- +micrate Down
DROP TABLE IF EXISTS screenshots;
