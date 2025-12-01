--Exercicio 1:

SELECT UPPER(Nome), LOWER(Sobrenome) FROM Empregados;

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
