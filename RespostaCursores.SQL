--Exercicio 1:

CREATE OR REPLACE FUNCTION f_formatar_nome (p_nome IN VARCHAR2, p_sobrenome IN VARCHAR2)
RETURN VARCHAR2
IS
BEGIN
  RETURN UPPER(p_nome) || ' ' || LOWER(p_sobrenome);
END;

--Exercicio 2:

CREATE OR REPLACE PROCEDURE aniversariantes_mes
IS
  CURSOR c_aniversariantes IS
    SELECT Nome, Sobrenome
    FROM Empregados
    WHERE EXTRACT(MONTH FROM Data_Nascimento) = EXTRACT(MONTH FROM SYSDATE);
	--Caso eu queira saber o mês exato é só eu colocar o mês na frente do data_nascimento e eu posso mudar para YEAR,DAY,MONTH

  v_nome Empregados.Nome%TYPE;
  v_sobrenome Empregados.Sobrenome%TYPE;
  v_qtd NUMBER := 0;
BEGIN
  OPEN c_aniversariantes;
  LOOP
    FETCH c_aniversariantes INTO v_nome, v_sobrenome;
    EXIT WHEN c_aniversariantes%NOTFOUND;
    v_qtd := v_qtd + 1;
    DBMS_OUTPUT.PUT_LINE(v_nome || ' ' || v_sobrenome);
  END LOOP;
  CLOSE c_aniversariantes;

  IF v_qtd = 0 THEN
    DBMS_OUTPUT.PUT_LINE('Nenhum aniversariante neste mês');
  ELSE
    DBMS_OUTPUT.PUT_LINE('Quantidade de aniversariantes neste mês: ' || v_qtd);
  END IF;
END;

--EXEC aniversariantes_mes;

--Exercicio 3:

CREATE OR REPLACE PROCEDURE salario_maior (p_valor in number)
IS
  CURSOR c_salario IS
    SELECT nome,data_admissao,salario
    FROM Empregados
    WHERE salario > p_valor;

  v_nome Empregados.Nome%TYPE;
  v_data_admissao Empregados.Data_Admissao%TYPE;
  v_salario Empregados.Salario%TYPE;
  v_qtd NUMBER := 0;
BEGIN
  OPEN c_salario;
  LOOP
    FETCH c_salario INTO v_nome, v_data_admissao,v_salario;
    EXIT WHEN c_salario%NOTFOUND;
    v_qtd := v_qtd + 1;
    DBMS_OUTPUT.PUT_LINE(
      v_nome || ' - ' ||
      TO_CHAR(v_data_admissao, 'DD/MM/YYYY') || ' - ' ||
      v_salario
    );
  END LOOP;
  CLOSE c_salario;

  IF v_qtd = 0 THEN
    DBMS_OUTPUT.PUT_LINE('Nenhum Empregado com o salario maior');
  ELSE
    DBMS_OUTPUT.PUT_LINE('Quantidade de empregados com o salario maior: ' || v_qtd);
  END IF;
END;

--EXEC SALARIO_MAIOR(4000);

--Exercicio 4:

CREATE OR REPLACE PROCEDURE salario_maior_dpt (p_valor in number)
IS
  CURSOR c_salariodpt IS
    SELECT e.nome,e.data_admissao,e.salario , d.descricao
    FROM Empregados e , Departamentos d
    WHERE salario > p_valor AND
    e.Depto = d.codigo;

  v_nome Empregados.Nome%TYPE;
  v_data_admissao Empregados.Data_Admissao%TYPE;
  v_salario Empregados.Salario%TYPE;
  v_descricao Departamentos.Descricao%TYPE;
  v_qtd NUMBER := 0;
BEGIN
  OPEN c_salariodpt;
  LOOP
    FETCH c_salariodpt INTO v_nome, v_data_admissao,v_salario,v_descricao;
    EXIT WHEN c_salariodpt%NOTFOUND;
    v_qtd := v_qtd + 1;
    DBMS_OUTPUT.PUT_LINE(
      v_nome || ' - ' ||
      TO_CHAR(v_data_admissao, 'DD/MM/YYYY') || ' - ' ||
      v_salario || ' - ' ||
      v_descricao
    );
  END LOOP;
  CLOSE c_salariodpt;

  IF v_qtd = 0 THEN
    DBMS_OUTPUT.PUT_LINE('Nenhum Empregado com o salario maior');
  ELSE
    DBMS_OUTPUT.PUT_LINE('Quantidade de empregados com o salario maior: ' || v_qtd);
  END IF;
END;

--EXEC salario_maior_dpt(4000);

--Exercicio 5:

CREATE OR REPLACE PROCEDURE media_salario_dpt (p_valor in number)
IS
  CURSOR c_media_salario IS
    SELECT e.salario , d.descricao
    FROM Empregados e , Departamentos d
    WHERE e.Depto = d.codigo AND
    d.Codigo = p_valor;

  v_salario Empregados.Salario%TYPE;
  v_descricao Departamentos.Descricao%TYPE;
  v_qtd NUMBER := 0;
  v_soma_salario NUMBER := 0;
  v_media NUMBER(10,2);
BEGIN
  OPEN c_media_salario;
  LOOP
    FETCH c_media_salario INTO v_salario,v_descricao;
    EXIT WHEN c_media_salario%NOTFOUND;
    v_soma_salario := v_soma_salario + v_salario;
    v_qtd := v_qtd + 1; 
    END LOOP;
        CLOSE c_media_salario;

  IF v_qtd = 0 THEN
    DBMS_OUTPUT.PUT_LINE('Departamento não encontrado ou sem empregados');
  ELSE
    v_media := v_soma_salario / v_qtd;
    DBMS_OUTPUT.PUT_LINE('A média de salario do departamento é de: ' || 'Departamento: ' || v_descricao ||
    '| Média Salarial: ' || TO_CHAR(v_media));
  END IF;
END;

--EXEC media_salario_dpt(10);

--Exercicio 6:

CREATE OR REPLACE PROCEDURE p_tempo_trabalho (p_valor in number)
IS
  CURSOR c_tempo_trabalho IS
    SELECT  e.nome, e.data_admissao,d.descricao
    FROM Empregados e , Departamentos d
    WHERE e.Depto = d.codigo AND
    e.Depto = p_valor;
    
    v_nome Empregados.Nome%TYPE;
    v_data_admissao Empregados.data_admissao%TYPE;
    v_descricao Departamentos.Descricao%TYPE;
    v_meses NUMBER;
    v_qtd NUMBER := 0;
BEGIN
    OPEN c_tempo_trabalho;
    LOOP
        FETCH c_tempo_trabalho INTO v_nome,v_data_admissao,v_descricao;
        EXIT WHEN c_tempo_trabalho%NOTFOUND;
        v_qtd := v_qtd + 1;  
        v_meses := TRUNC(MONTHS_BETWEEN(SYSDATE, v_data_admissao));
        DBMS_OUTPUT.PUT_LINE('Nome: ' || v_nome || '| Departamento: ' || v_descricao ||
    '| Tempo trabalhado: ' || v_meses);
    END LOOP;
    CLOSE c_tempo_trabalho;

    IF v_qtd = 0 THEN
    DBMS_OUTPUT.PUT_LINE('Funcionario não encontrado');
    END IF;
END;

--EXEC p_tempo_trabalho(10);

--Exercicio 7

CREATE OR REPLACE PROCEDURE p_demitidos_tempo
IS
  CURSOR c_demitidos IS
    SELECT Nome, Data_Admissao, Data_Rescisao
    FROM Empregados
    WHERE Data_Rescisao IS NOT NULL; 
    
  v_nome          Empregados.Nome%TYPE;
  v_data_admissao Empregados.Data_Admissao%TYPE;
  v_data_rescisao Empregados.Data_Rescisao%TYPE;
  v_meses         NUMBER;
  v_qtd           NUMBER := 0;

BEGIN
  OPEN c_demitidos;
  LOOP
    FETCH c_demitidos INTO v_nome, v_data_admissao, v_data_rescisao;
    EXIT WHEN c_demitidos%NOTFOUND;
    
    v_qtd := v_qtd + 1;
    
    v_meses := TRUNC(MONTHS_BETWEEN(v_data_rescisao, v_data_admissao));
    
    DBMS_OUTPUT.PUT_LINE('Nome: ' || v_nome || 
                         ' | Meses trabalhados: ' || v_meses);
  END LOOP;
  CLOSE c_demitidos;

  IF v_qtd = 0 THEN
    DBMS_OUTPUT.PUT_LINE('Nenhum funcionário demitido encontrado.');
  END IF;
END;

--Exercicio 8:

CREATE OR REPLACE PROCEDURE p_projecao_salarial (p_porcentagem IN NUMBER)
IS
  CURSOR c_ativos IS
    SELECT Nome, Salario
    FROM Empregados
    WHERE Data_Rescisao IS NULL; 

  v_nome          Empregados.Nome%TYPE;
  v_salario_atual Empregados.Salario%TYPE;
  v_novo_salario  NUMBER(9,2); -- Variável para guardar o resultado da conta
  v_qtd           NUMBER := 0;

BEGIN
  OPEN c_ativos;
  LOOP
    FETCH c_ativos INTO v_nome, v_salario_atual;
    EXIT WHEN c_ativos%NOTFOUND;
    
    v_qtd := v_qtd + 1;
    
    v_novo_salario := v_salario_atual + (v_salario_atual * (p_porcentagem / 100));
    
    DBMS_OUTPUT.PUT_LINE('Funcionário: ' || v_nome);
    DBMS_OUTPUT.PUT_LINE('Salário Atual: R$ ' || v_salario_atual);
    DBMS_OUTPUT.PUT_LINE('Salário Projetado (' || p_porcentagem || '%): R$ ' || v_novo_salario);
    DBMS_OUTPUT.PUT_LINE('-----------------------------'); 
  END LOOP;
  CLOSE c_ativos;

  IF v_qtd = 0 THEN
    DBMS_OUTPUT.PUT_LINE('Nenhum funcionário ativo encontrado.');
  END IF;
END;

--exec p_projecao_salarial(10);

--Exercicio 9:

CREATE OR REPLACE PROCEDURE p_calcula_ir
IS
  CURSOR c_func IS
    SELECT Nome, Sobrenome, Salario FROM Empregados;

  v_nome_completo VARCHAR2(100);
  v_imposto       NUMBER(9,2);
  
  v_nome      Empregados.Nome%TYPE;
  v_sobrenome Empregados.Sobrenome%TYPE;
  v_salario   Empregados.Salario%TYPE;

BEGIN
  OPEN c_func;
  LOOP
    FETCH c_func INTO v_nome, v_sobrenome, v_salario;
    EXIT WHEN c_func%NOTFOUND;

    v_nome_completo := f_formatar_nome(v_nome, v_sobrenome);

    IF v_salario <= 1164.00 THEN
       v_imposto := 0;
       
    ELSIF v_salario <= 2326.00 THEN
       v_imposto := (v_salario * 0.15 ); 
       
    ELSE
       v_imposto := ( v_salario * 0.275 );
    END IF;

    DBMS_OUTPUT.PUT_LINE('Func: ' || v_nome_completo || ' | Salário: ' || v_salario || ' | IR: ' || v_imposto);
    
  END LOOP;
  CLOSE c_func;
END;

--Exercicio 10:

CREATE OR REPLACE PROCEDURE p_movimentacao_mes (p_mes IN NUMBER)
IS
  CURSOR c_admitidos IS
    SELECT Nome, Data_Admissao 
    FROM Empregados
    WHERE EXTRACT(MONTH FROM Data_Admissao) = p_mes ; 

  CURSOR c_demitidos IS
    SELECT Nome, Data_Rescisao 
    FROM Empregados
    WHERE EXTRACT(MONTH FROM Data_Rescisao) = p_mes ; 

  v_nome Empregados.Nome%TYPE;
  v_data DATE;

BEGIN

  DBMS_OUTPUT.PUT_LINE('--- FUNCIONÁRIOS ADMITIDOS NO MÊS ' || p_mes || ':');
  OPEN c_admitidos;
  LOOP
    FETCH c_admitidos INTO v_nome, v_data;
    EXIT WHEN c_admitidos%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE(v_nome || ' - Data: ' || v_data);
  END LOOP;
  CLOSE c_admitidos;

  DBMS_OUTPUT.PUT_LINE('--- FUNCIONÁRIOS DEMITIDOS NO MÊS ' || p_mes || ':');
  OPEN c_demitidos;
  LOOP
    FETCH c_demitidos INTO v_nome, v_data;
    EXIT WHEN c_demitidos%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE(v_nome || ' - Data: ' || v_data);
  END LOOP;
  CLOSE c_demitidos;

END;

--exec p_movimentacao_mes(5);

--Exercicio 11:

CREATE OR REPLACE PROCEDURE p_resumo_anual
IS
  v_qtd_admitidos NUMBER;
  v_qtd_demitidos NUMBER;
BEGIN
  FOR v_mes IN 1..12 LOOP
    
    SELECT COUNT(*) INTO v_qtd_admitidos
    FROM Empregados
    WHERE EXTRACT(MONTH FROM Data_Admissao) = v_mes;
    
    SELECT COUNT(*) INTO v_qtd_demitidos
    FROM Empregados
    WHERE Data_Rescisao IS NOT NULL 
      AND EXTRACT(MONTH FROM Data_Rescisao) = v_mes;
      
    DBMS_OUTPUT.PUT_LINE('Mês ' || v_mes || ': Admitidos = ' || v_qtd_admitidos || 
                         ' | Demitidos = ' || v_qtd_demitidos);
  END LOOP;
END;

--Exercicio 12:

CREATE OR REPLACE PROCEDURE p_totais_folha
IS
  CURSOR c_folha IS
    SELECT Salario FROM Empregados WHERE Data_Rescisao IS NULL;

  v_salario         Empregados.Salario%TYPE;
  v_imposto_indiv   NUMBER(9,2); 
  
  v_total_func      NUMBER := 0;
  v_total_bruto     NUMBER(15,2) := 0;
  v_total_descontos NUMBER(15,2) := 0;

BEGIN
  OPEN c_folha;
  LOOP
    FETCH c_folha INTO v_salario;
    EXIT WHEN c_folha%NOTFOUND;

    v_total_func := v_total_func + 1;

    v_total_bruto := v_total_bruto + v_salario;

    IF v_salario <= 1164.00 THEN
       v_imposto_indiv := 0;
    ELSIF v_salario <= 2326.00 THEN
       v_imposto_indiv := v_salario * 0.15;
    ELSE
       v_imposto_indiv := v_salario * 0.275;
    END IF;

    v_total_descontos := v_total_descontos + v_imposto_indiv;

  END LOOP;
  CLOSE c_folha;

  DBMS_OUTPUT.PUT_LINE('=== RESUMO DA FOLHA ===');
  DBMS_OUTPUT.PUT_LINE('Total de Funcionários Ativos: ' || v_total_func);
  DBMS_OUTPUT.PUT_LINE('Total Bruto (Salários): R$ ' || v_total_bruto);
  DBMS_OUTPUT.PUT_LINE('Total Descontos (IR):   R$ ' || v_total_descontos);
  DBMS_OUTPUT.PUT_LINE('Total Líquido a Pagar:  R$ ' || (v_total_bruto - v_total_descontos));

END;

--Exercicio 13:

CREATE OR REPLACE FUNCTION f_nome_mes (p_mes IN NUMBER)
RETURN VARCHAR2
IS
  v_nome_mes VARCHAR2(20);
BEGIN
  CASE p_mes
    WHEN 1 THEN v_nome_mes := 'Janeiro';
    WHEN 2 THEN v_nome_mes := 'Fevereiro';
    WHEN 3 THEN v_nome_mes := 'Março';
    WHEN 4 THEN v_nome_mes := 'Abril';
    WHEN 5 THEN v_nome_mes := 'Maio';
    WHEN 6 THEN v_nome_mes := 'Junho';
    WHEN 7 THEN v_nome_mes := 'Julho';
    WHEN 8 THEN v_nome_mes := 'Agosto';
    WHEN 9 THEN v_nome_mes := 'Setembro';
    WHEN 10 THEN v_nome_mes := 'Outubro';
    WHEN 11 THEN v_nome_mes := 'Novembro';
    WHEN 12 THEN v_nome_mes := 'Dezembro';
    ELSE v_nome_mes := 'Mês Inválido';
  END CASE;

  RETURN v_nome_mes;
END;

--SELECT f_nome_mes(5) FROM DUAL;

--Exercicio 14:

CREATE OR REPLACE PROCEDURE p_datas_formatadas
IS
  CURSOR c_datas IS
    SELECT Nome, Data_Admissao, Data_Rescisao FROM Empregados;

  v_nome          Empregados.Nome%TYPE;
  v_dt_adm        DATE;
  v_dt_res        DATE;
  
  v_dia           NUMBER;
  v_mes_num       NUMBER;
  v_ano           NUMBER;
  v_texto_adm     VARCHAR2(100);
  v_texto_res     VARCHAR2(100);

BEGIN
  OPEN c_datas;
  LOOP
    FETCH c_datas INTO v_nome, v_dt_adm, v_dt_res;
    EXIT WHEN c_datas%NOTFOUND;

    v_dia     := EXTRACT(DAY FROM v_dt_adm);
    v_mes_num := EXTRACT(MONTH FROM v_dt_adm);
    v_ano     := EXTRACT(YEAR FROM v_dt_adm);
    
    v_texto_adm := v_dia || ' de ' || f_nome_mes(v_mes_num) || ' de ' || v_ano;

    IF v_dt_res IS NOT NULL THEN
       v_dia     := EXTRACT(DAY FROM v_dt_res);
       v_mes_num := EXTRACT(MONTH FROM v_dt_res);
       v_ano     := EXTRACT(YEAR FROM v_dt_res);
       
       v_texto_res := v_dia || ' de ' || f_nome_mes(v_mes_num) || ' de ' || v_ano;
    ELSE
       v_texto_res := 'Atualmente na empresa';
    END IF;

    DBMS_OUTPUT.PUT_LINE('Func: ' || v_nome);
    DBMS_OUTPUT.PUT_LINE('   Admissão: ' || v_texto_adm);
    DBMS_OUTPUT.PUT_LINE('   Demissão: ' || v_texto_res);
    DBMS_OUTPUT.PUT_LINE('-----------------------------');

  END LOOP;
  CLOSE c_datas;
END;


