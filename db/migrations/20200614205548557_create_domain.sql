-- +micrate Up
CREATE TABLE domains (
  id BIGSERIAL PRIMARY KEY,
  fqdn VARCHAR,
  created_at TIMESTAMP,
  updated_at TIMESTAMP
  -- scan_id BIGSERIAL NOT NULL,
  -- FOREIGN KEY (scan_id) REFERENCES scans(id)
);


-- +micrate Down
DROP TABLE IF EXISTS domains;
-- 20200614205548557
-- 20200614205848696