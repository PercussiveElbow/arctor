-- +micrate Up
CREATE TABLE hosts (
  id BIGSERIAL PRIMARY KEY,
  ipv4 VARCHAR,
  ipv6 VARCHAR,
  source VARCHAR,
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);


-- +micrate Down
DROP TABLE IF EXISTS hosts;
