-- +micrate Up
CREATE TABLE sub_domains (
  id BIGSERIAL PRIMARY KEY,
  fqdn VARCHAR,
  a VARCHAR,
  aaaa VARCHAR,
  ns VARCHAR,
  mx VARCHAR,
  txt VARCHAR,
  created_at TIMESTAMP,
  updated_at TIMESTAMP,
  domain_id BIGSERIAL NOT NULL,
  FOREIGN KEY (domain_id) REFERENCES domains(id)
);


-- +micrate Down
DROP TABLE IF EXISTS sub_domains;
