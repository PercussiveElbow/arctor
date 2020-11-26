-- +micrate Up
CREATE TABLE shodan_http_service (
  id BIGSERIAL PRIMARY KEY,
  shodan_service_id BIGSERIAL NOT NULL,
  FOREIGN KEY (shodan_service_id) REFERENCES shodan_services(id),
  html TEXT,
  html_hash bigint,
  securitytxt VARCHAR,
  securitytxt_hash bigint,
  robots VARCHAR,
  robots_hash bigint,
  sitemap VARCHAR,
  sitemap_hash bigint,
  location VARCHAR,
  server VARCHAR,
  title VARCHAR,
  host VARCHAR,
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);


-- +micrate Down
DROP TABLE IF EXISTS shodan_http_service;
