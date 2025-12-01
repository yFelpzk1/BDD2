CREATE TABLE Departamentos (
  Codigo      NUMBER(3)    PRIMARY KEY,
  Descricao   VARCHAR2(30) NOT NULL
);

CREATE TABLE Empregados (
  Codigo          NUMBER(5)      PRIMARY KEY,
  Nome            VARCHAR2(50)   NOT NULL,
  Sobrenome       VARCHAR2(50)   NOT NULL,
  Data_Nascimento DATE           NOT NULL,
  Data_Admissao   DATE           NOT NULL,
  Data_Rescisao   DATE,
  Salario         NUMBER(9,2)    NOT NULL,
  Profissao       VARCHAR2(40)   NOT NULL,
  Depto           NUMBER(3)      NOT NULL,
  CONSTRAINT fk_departamento FOREIGN KEY (Depto)
    REFERENCES Departamentos(Codigo)
);

--Insert de Empregados

Insert into EMPREGADOS (CODIGO,NOME,SOBRENOME,DATA_NASCIMENTO,DATA_ADMISSAO,DATA_RESCISAO,SALARIO,PROFISSAO,DEPTO)
values (1,'Ana','Silva',to_date('10-MAY-90','DD-MON-RR'),to_date('01-JAN-15','DD-MON-RR'),null,3500,'Analista RH',10);
Insert into EMPREGADOS (CODIGO,NOME,SOBRENOME,DATA_NASCIMENTO,DATA_ADMISSAO,DATA_RESCISAO,SALARIO,PROFISSAO,DEPTO) 
values (2,'Bruno','Souza',to_date('20-MAR-88','DD-MON-RR'),to_date('15-JUN-14','DD-MON-RR'),null,4200,'Contador',20);
Insert into EMPREGADOS (CODIGO,NOME,SOBRENOME,DATA_NASCIMENTO,DATA_ADMISSAO,DATA_RESCISAO,SALARIO,PROFISSAO,DEPTO) 
values (3,'Carla','Pereira',to_date('05-NOV-92','DD-MON-RR'),to_date('01-SEP-18','DD-MON-RR'),null,5000,'Desenvolvedor',30);
Insert into EMPREGADOS (CODIGO,NOME,SOBRENOME,DATA_NASCIMENTO,DATA_ADMISSAO,DATA_RESCISAO,SALARIO,PROFISSAO,DEPTO) 
values (4,'Diego','Oliveira',to_date('30-JAN-85','DD-MON-RR'),to_date('10-MAR-10','DD-MON-RR'),null,6000,'Gerente',40);
Insert into EMPREGADOS (CODIGO,NOME,SOBRENOME,DATA_NASCIMENTO,DATA_ADMISSAO,DATA_RESCISAO,SALARIO,PROFISSAO,DEPTO) 
values (5,'Elisa','Costa',to_date('22-JUL-95','DD-MON-RR'),to_date('01-FEB-20','DD-MON-RR'),null,2800,'Vendedor',50);
Insert into EMPREGADOS (CODIGO,NOME,SOBRENOME,DATA_NASCIMENTO,DATA_ADMISSAO,DATA_RESCISAO,SALARIO,PROFISSAO,DEPTO) 
values (6,'Max','Verstappen',to_date('30-SEP-97','DD-MON-RR'),to_date('01-DEC-15','DD-MON-RR'),null,8000,'Pai do Vegano',60);
Insert into EMPREGADOS (CODIGO,NOME,SOBRENOME,DATA_NASCIMENTO,DATA_ADMISSAO,DATA_RESCISAO,SALARIO,PROFISSAO,DEPTO) 
values (7,'Charles','Leclerc',to_date('21-DEC-97','DD-MON-RR'),to_date('25-JAN-16','DD-MON-RR'),null,5000,'Infiel',70);
Insert into EMPREGADOS (CODIGO,NOME,SOBRENOME,DATA_NASCIMENTO,DATA_ADMISSAO,DATA_RESCISAO,SALARIO,PROFISSAO,DEPTO) 
values (8,'Lewis','Hamilton',to_date('10-APR-00','DD-MON-RR'),to_date('25-FEB-24','DD-MON-RR'),null,5500,'Aposentado',80);

--Insert de Departamentos

Insert into DEPARTAMENTOS (CODIGO,DESCRICAO) values (10,'Recursos Humanos');
Insert into DEPARTAMENTOS (CODIGO,DESCRICAO) values (20,'Financeiro');
Insert into DEPARTAMENTOS (CODIGO,DESCRICAO) values (30,'TI');
Insert into DEPARTAMENTOS (CODIGO,DESCRICAO) values (40,'Marketing');
Insert into DEPARTAMENTOS (CODIGO,DESCRICAO) values (50,'Vendas');
Insert into DEPARTAMENTOS (CODIGO,DESCRICAO) values (60,'Especial');
Insert into DEPARTAMENTOS (CODIGO,DESCRICAO) values (70,'Red Burro');
Insert into DEPARTAMENTOS (CODIGO,DESCRICAO) values (80,'Burrari');