-- +micrate Up
CREATE TABLE shodan_infos (
  id BIGSERIAL PRIMARY KEY,
  ports INTEGER[],
  os VARCHAR,
  org VARCHAR,
  last_update VARCHAR,
  tags TEXT[],
  country_code VARCHAR,
  region_code VARCHAR,
  area_code VARCHAR,
  postal_code VARCHAR,
  city VARCHAR,
  country_name VARCHAR,
  dma_code VARCHAR,
  longitude FLOAT,
  latitude FLOAT,
  domains TEXT[],
  hostnames TEXT[],

  host_id BIGSERIAL NOT NULL,
  FOREIGN KEY (host_id) REFERENCES hosts(id),
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);


-- +micrate Down
DROP TABLE IF EXISTS shodan_infos;
