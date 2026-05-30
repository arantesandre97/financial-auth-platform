-- infra/postgres/init/01-schemas.sql
-- Executado automaticamente pelo PostgreSQL na primeira inicialização do volume.
-- Cria os schemas correspondentes aos bounded contexts DDD do projeto.

-- Bounded context: autenticação e identidade
CREATE SCHEMA IF NOT EXISTS auth;

-- Bounded context: pagamentos e transações
CREATE SCHEMA IF NOT EXISTS payments;

-- Bounded context: auditoria de eventos
CREATE SCHEMA IF NOT EXISTS audit;

-- Garantir permissões ao usuário da aplicação
GRANT ALL PRIVILEGES ON SCHEMA auth     TO fap;
GRANT ALL PRIVILEGES ON SCHEMA payments TO fap;
GRANT ALL PRIVILEGES ON SCHEMA audit    TO fap;

-- Confirmar criação (aparece no log do container na inicialização)
DO $$
BEGIN
  RAISE NOTICE 'Schemas criados: auth, payments, audit';
END
$$;