-- +micrate Up
CREATE TABLE shodan_services (
  id BIGSERIAL PRIMARY KEY,
  shodan_info_id BIGSERIAL NOT NULL,
  isp VARCHAR,
  asn VARCHAR,
  os VARCHAR,
  banner VARCHAR,
  version VARCHAR,
  product VARCHAR,
  domains TEXT[],
  hostnames TEXT[],
  cpes TEXT[],
  port INTEGER,
  hash bigint,
  FOREIGN KEY (shodan_info_id) REFERENCES shodan_infos(id),
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);


-- +micrate Down
DROP TABLE IF EXISTS shodan_services;
