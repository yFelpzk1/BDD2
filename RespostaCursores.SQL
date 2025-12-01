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