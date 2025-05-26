-- Active: 1748216084284@@127.0.0.1@5432@postgres


-- DO $$
-- BEGIN
--     CALL sp_total_pedidos_cliente(1);
-- END;
-- $$;

-- DO $$
-- DECLARE
--     v_total INT;
-- BEGIN
--     CALL sp_total_pedidos_cliente_out(1, v_total);
--     RAISE NOTICE 'Total OUT: %', v_total;
-- END;
-- $$;

-- DO $$
-- DECLARE
--     v_cod_cliente INT := 1;
-- BEGIN
--     CALL sp_total_pedidos_cliente_inout(v_cod_cliente);
--     RAISE NOTICE 'Total INOUT: %', v_cod_cliente;
-- END;
-- $$;

-- DO $$
-- DECLARE
--     v_msg TEXT;
-- BEGIN
--     CALL sp_cadastrar_clientes('Pedro', 'Ana', 'João', v_msg);
--     RAISE NOTICE '%', v_msg;
-- END;
-- $$;




-- CREATE OR REPLACE PROCEDURE sp_cadastrar_clientes(
--     OUT mensagem TEXT,
--     VARIADIC p_nomes TEXT[]
-- )
-- LANGUAGE plpgsql
-- AS $$
-- DECLARE
--     nome TEXT;
-- BEGIN
--     FOREACH nome IN ARRAY p_nomes LOOP
--         INSERT INTO tb_cliente (nome) VALUES (nome);
--     END LOOP;

--     mensagem := 'Os clientes: ' || array_to_string(p_nomes, ', ') || ' foram cadastrados';
--     CALL sp_inserir_log('sp_cadastrar_clientes');
-- END;
-- $$;

-- CREATE OR REPLACE PROCEDURE sp_total_pedidos_cliente_inout(INOUT p_cod_cliente INT)
-- LANGUAGE plpgsql
-- AS $$
-- BEGIN
--     SELECT COUNT(*) INTO p_cod_cliente
--     FROM tb_pedido
--     WHERE cod_cliente = p_cod_cliente;

--     CALL sp_inserir_log('sp_total_pedidos_cliente_inout');
-- END;
-- $$;


-- CREATE OR REPLACE PROCEDURE sp_total_pedidos_cliente_out(
--     IN p_cod_cliente INT,
--     OUT p_total INT
-- )
-- LANGUAGE plpgsql
-- AS $$
-- BEGIN
--     SELECT COUNT(*) INTO p_total
--     FROM tb_pedido
--     WHERE cod_cliente = p_cod_cliente;

--     CALL sp_inserir_log('sp_total_pedidos_cliente_out');
-- END;
-- $$;

-- CREATE OR REPLACE PROCEDURE sp_total_pedidos_cliente(IN p_cod_cliente INT)
-- LANGUAGE plpgsql
-- AS $$
-- DECLARE
--     v_total INT;
-- BEGIN
--     SELECT COUNT(*) INTO v_total
--     FROM tb_pedido
--     WHERE cod_cliente = p_cod_cliente;

--     RAISE NOTICE 'O cliente % possui % pedidos', p_cod_cliente, v_total;
--     CALL sp_inserir_log('sp_total_pedidos_cliente');
-- END;
-- $$;


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
