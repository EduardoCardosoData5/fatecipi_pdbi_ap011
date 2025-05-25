-- Active: 1748216084284@@127.0.0.1@5432@postgres
--Exemplo: sp_calcular_troco atualizado com log


CREATE OR REPLACE PROCEDURE sp_total_pedidos_cliente(IN p_cod_cliente INT)
LANGUAGE plpgsql
AS $$
DECLARE
    v_total INT;
BEGIN
    SELECT COUNT(*) INTO v_total
    FROM tb_pedido
    WHERE cod_cliente = p_cod_cliente;

    RAISE NOTICE 'O cliente % possui % pedidos', p_cod_cliente, v_total;
    CALL sp_inserir_log('sp_total_pedidos_cliente');
END;
$$;


-- CREATE OR REPLACE PROCEDURE sp_calcular_troco(
--     OUT p_troco INT, 
--     IN p_valor_a_pagar INT,
--     IN p_valor_total INT
-- )
-- LANGUAGE plpgsql
-- AS $$
-- BEGIN
--     p_troco := p_valor_a_pagar - p_valor_total;
--     CALL sp_inserir_log('sp_calcular_troco');
-- END;
-- $$;

-- DROP PROCEDURE IF EXISTS sp_calcular_troco(INT, INT, INT);


-- CREATE OR REPLACE PROCEDURE sp_inserir_log(nome_proc TEXT)
-- LANGUAGE plpgsql
-- AS $$
-- BEGIN
--     INSERT INTO tb_log_operacoes (nome_procedimento) VALUES (nome_proc);
-- END;
-- $$;


-- CREATE TABLE tb_log_operacoes (
--     cod_log SERIAL PRIMARY KEY,
--     data_execucao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
--     nome_procedimento VARCHAR(100) NOT NULL
-- );
