CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

CREATE TABLE auth.users (
                            id          UUID         PRIMARY KEY DEFAULT gen_random_uuid(),
                            email       VARCHAR(255) NOT NULL,
                            name        VARCHAR(255) NOT NULL,
                            status      VARCHAR(50)  NOT NULL DEFAULT 'ACTIVE',
                            created_at  TIMESTAMPTZ  NOT NULL DEFAULT now(),
                            updated_at  TIMESTAMPTZ  NOT NULL DEFAULT now(),

                            CONSTRAINT uq_users_email  UNIQUE (email),
                            CONSTRAINT ck_users_status CHECK  (status IN ('ACTIVE', 'INACTIVE', 'BLOCKED'))
);

CREATE TABLE auth.credentials (
                                  id          UUID         PRIMARY KEY DEFAULT gen_random_uuid(),
                                  user_id     UUID         NOT NULL REFERENCES auth.users(id),
                                  type        VARCHAR(50)  NOT NULL,
                                  value       TEXT         NOT NULL,
                                  created_at  TIMESTAMPTZ  NOT NULL DEFAULT now(),
                                  expires_at  TIMESTAMPTZ,

                                  CONSTRAINT ck_credentials_type CHECK (type IN ('PASSWORD', 'FIDO2', 'TOTP'))
);

CREATE TABLE auth.sessions (
                               id          UUID         PRIMARY KEY DEFAULT gen_random_uuid(),
                               user_id     UUID         NOT NULL REFERENCES auth.users(id),
                               token_hash  VARCHAR(255) NOT NULL,
                               ip_address  INET,
                               user_agent  TEXT,
                               created_at  TIMESTAMPTZ  NOT NULL DEFAULT now(),
                               expires_at  TIMESTAMPTZ  NOT NULL,
                               revoked_at  TIMESTAMPTZ
);

CREATE INDEX idx_credentials_user_id ON auth.credentials(user_id);
CREATE INDEX idx_sessions_user_id    ON auth.sessions(user_id);
CREATE INDEX idx_sessions_token_hash ON auth.sessions(token_hash);