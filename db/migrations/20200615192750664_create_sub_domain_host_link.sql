-- +micrate Up
CREATE TABLE sub_domain_host_link (
  id BIGSERIAL PRIMARY KEY,
  created_at TIMESTAMP,
  updated_at TIMESTAMP,
  sub_domain_id BIGSERIAL NOT NULL,
  host_id BIGSERIAL NOT NULL,
  FOREIGN KEY (sub_domain_id) REFERENCES sub_domains(id),
  FOREIGN KEY (host_id) REFERENCES hosts(id)
);


-- +micrate Down
DROP TABLE IF EXISTS hosts;
