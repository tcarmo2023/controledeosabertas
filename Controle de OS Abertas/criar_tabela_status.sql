-- Script para criar a tabela de status customizados no Supabase
-- Execute este script no SQL Editor do seu projeto Supabase

CREATE TABLE IF NOT EXISTS status_customizados (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    cor_hex VARCHAR(7) NOT NULL DEFAULT '#007bff',
    ordem_exibicao INTEGER DEFAULT 0,
    ativo BOOLEAN DEFAULT true,
    bloqueia_progresso BOOLEAN DEFAULT false,
    finaliza_processo BOOLEAN DEFAULT false,
    categoria VARCHAR(100) DEFAULT '',
    descricao TEXT DEFAULT '',
    criado_por VARCHAR(255) DEFAULT 'sistema',
    data_atualizacao TIMESTAMP WITH TIME ZONE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Adicionar comentários às colunas
COMMENT ON TABLE status_customizados IS 'Tabela para armazenar status customizados criados pelos usuários';
COMMENT ON COLUMN status_customizados.nome IS 'Nome do status customizado';
COMMENT ON COLUMN status_customizados.cor_hex IS 'Cor do status em formato hexadecimal';
COMMENT ON COLUMN status_customizados.created_at IS 'Data e hora de criação do registro';
COMMENT ON COLUMN status_customizados.updated_at IS 'Data e hora da última atualização do registro';

-- Criar índice para melhor performance nas buscas por nome
CREATE INDEX IF NOT EXISTS idx_status_customizados_nome ON status_customizados(nome);

-- Criar trigger para atualizar automaticamente o updated_at
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER trigger_update_status_customizados_updated_at
    BEFORE UPDATE ON status_customizados
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();