-- +micrate Up
CREATE TABLE sub_domains (
  id BIGSERIAL PRIMARY KEY,
  fqdn VARCHAR,
  a TEXT[],
  aaaa TEXT[],
  ns VARCHAR,
  mx VARCHAR,
  txt VARCHAR,
  source VARCHAR,
  created_at TIMESTAMP,
  updated_at TIMESTAMP,
  domain_id BIGSERIAL NOT NULL,
  FOREIGN KEY (domain_id) REFERENCES domains(id)
);


-- +micrate Down
DROP TABLE IF EXISTS sub_domains;
