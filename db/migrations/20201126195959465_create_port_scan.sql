-- +micrate Up
CREATE TABLE port_scans (
  id BIGSERIAL PRIMARY KEY,
  ports INTEGER[],
  services TEXT[],
  host_id BIGSERIAL NOT NULL,
  FOREIGN KEY (host_id) REFERENCES hosts(id),
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);


-- +micrate Down
DROP TABLE IF EXISTS port_scans;
