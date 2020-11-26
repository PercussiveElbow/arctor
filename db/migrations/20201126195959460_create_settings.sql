-- +micrate Up
CREATE TABLE settings (
  id BIGSERIAL PRIMARY KEY,
  shodan_key VARCHAR,
  pushover_user_key VARCHAR,
  pushover_app_key VARCHAR,
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);


-- +micrate Down
DROP TABLE IF EXISTS settings;
