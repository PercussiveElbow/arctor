-- +micrate Up
CREATE TABLE scans (
  id BIGSERIAL PRIMARY KEY,
  scan_status VARCHAR,
  error_reason VARCHAR,
  stages TEXT[],
  target_query VARCHAR,
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);


-- +micrate Down
DROP TABLE IF EXISTS scans;
