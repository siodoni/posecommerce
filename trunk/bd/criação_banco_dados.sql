drop sequence scor;
drop sequence smarca;
drop sequence smodelo;
drop sequence sdepartamento;
drop sequence sproduto;
--
drop table cor          cascade constraints;
drop table marca        cascade constraints;
drop table departamento cascade constraints;
drop table modelo       cascade constraints;
drop table produto      cascade constraints;
--
create table COR
(ID_COR      NUMBER not null,
 DESCRICAO   VARCHAR2(20) not null,
 CODIGO_HTML VARCHAR2(6)) tablespace USERS;
comment on column COR.ID_COR      is 'Identificador da cor.';
comment on column COR.DESCRICAO   is 'Descrição da cor.';
comment on column COR.CODIGO_HTML is 'Codigo da cor em html.';
alter table COR add constraint PKCOR  primary key (ID_COR)      using index tablespace USERS;
alter table COR add constraint UNCOR1 unique      (DESCRICAO)   using index tablespace USERS;
alter table COR add constraint UNCOR2 unique      (CODIGO_HTML) using index tablespace USERS;
--
create table MARCA
(ID_MARCA  NUMBER not null,
 DESCRICAO VARCHAR2(40) not null) tablespace USERS;
comment on column MARCA.ID_MARCA  is 'Identificador da marca.';
comment on column MARCA.DESCRICAO is 'Descrição da marca.';
alter table MARCA add constraint PKMARCA primary key (ID_MARCA)  using index;
alter table MARCA add constraint UNMARCA unique      (DESCRICAO) using index;
--
create table DEPARTAMENTO
(ID_DEPARTAMENTO NUMBER not null,
 DESCRICAO       VARCHAR2(40) not null) tablespace USERS;
comment on column DEPARTAMENTO.ID_DEPARTAMENTO is 'Identificador do departamento.';
comment on column DEPARTAMENTO.DESCRICAO       is 'Descrição do departamento.';
alter table DEPARTAMENTO add constraint PKDEPARTAMENTO primary key (ID_DEPARTAMENTO) using index tablespace USERS;
alter table DEPARTAMENTO add constraint UNDEPARTAMENTO unique      (DESCRICAO)       using index tablespace USERS;
--
create table MODELO
(ID_MODELO NUMBER not null,
 MARCA     NUMBER not null,
 DESCRICAO VARCHAR2(60) not null) tablespace USERS;
comment on column MODELO.ID_MODELO is 'Identificador do modelo.';
comment on column MODELO.MARCA     is 'Identificador da marca.';
comment on column MODELO.DESCRICAO is 'Descrição do modelo.';
alter table MODELO add constraint PKMODELO       primary key (ID_MODELO)        using index tablespace USERS;
alter table MODELO add constraint UNMODELO       unique      (MARCA, DESCRICAO) using index tablespace USERS;
alter table MODELO add constraint FKMODELO_MARCA foreign key (MARCA)            references MARCA (ID_MARCA);
--
create table PRODUTO
(ID_PRODUTO   NUMBER not null,
 DESCRICAO    VARCHAR2(200) not null,
 DEPARTAMENTO NUMBER not null,
 MODELO       NUMBER not null,
 QUANTIDADE   NUMBER(12,2) not null,
 UNIDADE      VARCHAR2(3) not null,
 PRECO_UNIT   NUMBER(12,2) not null,
 COR          NUMBER,
 IMAGEM       VARCHAR2(200)) tablespace USERS;
comment on column PRODUTO.ID_PRODUTO   is 'Identificador do produto.';
comment on column PRODUTO.DESCRICAO    is 'Descrição do produto.';
comment on column PRODUTO.DEPARTAMENTO is 'Identificador do departamento.';
comment on column PRODUTO.MODELO       is 'Identificador do modelo.';
comment on column PRODUTO.QUANTIDADE   is 'Quantidade.';
comment on column PRODUTO.UNIDADE      is 'Unidade de medida.';
comment on column PRODUTO.PRECO_UNIT   is 'Preço unitário do produto.';
comment on column PRODUTO.COR          is 'Identificador da cor.';
comment on column PRODUTO.IMAGEM       is 'Endereço da imagem do produto.';
alter table PRODUTO add constraint PKPRODUTO              primary key (ID_PRODUTO)        using index tablespace USERS;
alter table PRODUTO add constraint UNPRODUTO              unique      (DESCRICAO, MODELO) using index tablespace USERS;
alter table PRODUTO add constraint FKPRODUTO_COR          foreign key (COR)               references COR          (ID_COR);
alter table PRODUTO add constraint FKPRODUTO_DEPARTAMENTO foreign key (DEPARTAMENTO)      references DEPARTAMENTO (ID_DEPARTAMENTO);
alter table PRODUTO add constraint FKPRODUTO_MODELO       foreign key (MODELO)            references MODELO       (ID_MODELO);
--
create or replace package pECommerce is
--
-- Criado por : Flávio
-- Em         : 17/01/2010 12:19:40
-- Comentário : Checagens do projeto e-commerce.
-- =============================================
  --
  -- Retorna o valor de uma sequence.
  -- pValor: [N]extval ou [C]urrval.
  -- ================================
  function fRetornaSequence(pNomeSequence  varchar2,
                            pValor         varchar2 := 'N') return number;
end pECommerce;
/
create or replace package body pECommerce is
--
-- Criado por : Flávio
-- Em         : 17/01/2010 12:19:40
-- Comentário : Checagens do projeto e-commerce.
-- =============================================
  --
  -- Retorna o valor de uma sequence.
  -- pValor: [N]extval ou [C]urrval.
  -- ================================
  function fRetornaSequence(pNomeSequence  varchar2,
                            pValor         varchar2 := 'N') return number is
    vValor    varchar2(100);
    vResposta number;
  begin
    if upper(pValor) = 'C'
    then vValor := '.currval';
    else vValor := '.nextval';
    end if;
    execute immediate 'select ' || pNomeSequence || vValor || ' from dual' into vResposta;
    return vResposta;
  end fRetornaSequence;
end pECommerce;
/
--
create or replace trigger tmarca_b_iud_r
  before insert
      or update
      or delete
      on marca
  for each row
begin
  if   inserting
  and  :new.id_marca is null
  then :new.id_marca := pECommerce.fRetornaSequence('SMARCA','N');
  end if;
end tmarca_b_iud_r;
/
--
create or replace trigger tmodelo_b_iud_r
  before insert
      or update
      or delete
      on modelo
  for each row
begin
  if   inserting
  and  :new.id_modelo is null  
  then :new.id_modelo := pECommerce.fRetornaSequence('SMODELO','N');
  end if;
end tmodelo_b_iud_r;
/
--
create or replace trigger tdepartamento_b_iud_r
  before insert
      or update
      or delete
      on departamento
  for each row
begin
  if inserting
  and  :new.id_departamento is null
  then :new.id_departamento := pECommerce.fRetornaSequence('SDEPARTAMENTO','N');
  end if;
end tdepartamento_b_iud_r;
/
--
create or replace trigger tproduto_b_iud_r
  before insert
      or update
      or delete
      on produto
  for each row
begin
  if inserting
  and  :new.id_produto is null
  then :new.id_produto := pECommerce.fRetornaSequence('SPRODUTO','N');
  end if;
end tproduto_b_iud_r;
/
--
create or replace trigger tcor_b_iud_r
  before insert
      or update
      or delete
      on cor
  for each row
begin
  if inserting
  and  :new.id_cor is null
  then :new.id_cor := pECommerce.fRetornaSequence('SCOR','N');
  end if;
end tcor_b_iud_r;
/
--
begin
  insert into COR (ID_COR, DESCRICAO, CODIGO_HTML)
  values (1, 'PRETO', '000000');
  insert into COR (ID_COR, DESCRICAO, CODIGO_HTML)
  values (2, 'BRANCO', 'FFFFFF');
  insert into COR (ID_COR, DESCRICAO, CODIGO_HTML)
  values (3, 'AZUL', '0000FF');
  insert into COR (ID_COR, DESCRICAO, CODIGO_HTML)
  values (4, 'VERMELHO', 'FF0000');
  insert into COR (ID_COR, DESCRICAO, CODIGO_HTML)
  values (5, 'VERDE', '00FF00');
  commit;
  insert into DEPARTAMENTO (ID_DEPARTAMENTO, DESCRICAO)
  values (1, 'CORDAS');
  insert into DEPARTAMENTO (ID_DEPARTAMENTO, DESCRICAO)
  values (2, 'TECLAS');
  insert into DEPARTAMENTO (ID_DEPARTAMENTO, DESCRICAO)
  values (3, 'PERCUSSÃO');
  insert into DEPARTAMENTO (ID_DEPARTAMENTO, DESCRICAO)
  values (4, 'AUDIO');
  commit;
  insert into MARCA (ID_MARCA, DESCRICAO)
  values (1, 'FENDER');
  insert into MARCA (ID_MARCA, DESCRICAO)
  values (2, 'GIBSON');
  insert into MARCA (ID_MARCA, DESCRICAO)
  values (3, 'GIANNINI');
  insert into MARCA (ID_MARCA, DESCRICAO)
  values (4, 'MAPEX');
  commit;
  insert into MODELO (ID_MODELO, MARCA, DESCRICAO)
  values (1, 1, 'JAZZ BASS');
  insert into MODELO (ID_MODELO, MARCA, DESCRICAO)
  values (2, 1, 'STRATO');
  insert into MODELO (ID_MODELO, MARCA, DESCRICAO)
  values (3, 2, 'LES PAUL');
  commit;
  insert into PRODUTO (ID_PRODUTO, DESCRICAO, DEPARTAMENTO, MODELO, QUANTIDADE, UNIDADE, PRECO_UNIT, IMAGEM, COR)
  values (1, 'GUITARRA', 1, 2, 5, 'UN', 2500, null, 1);
  insert into PRODUTO (ID_PRODUTO, DESCRICAO, DEPARTAMENTO, MODELO, QUANTIDADE, UNIDADE, PRECO_UNIT, IMAGEM, COR)
  values (2, 'BAIXO', 1, 1, 3, 'UN', 2700, null, 1);
  commit;
end;
/
--
create sequence scor          minvalue 1 maxvalue 99999999999 start with 5 increment by 1 nocache;
create sequence smarca        minvalue 1 maxvalue 99999999999 start with 4 increment by 1 nocache;
create sequence smodelo       minvalue 1 maxvalue 99999999999 start with 3 increment by 1 nocache;
create sequence sdepartamento minvalue 1 maxvalue 99999999999 start with 4 increment by 1 nocache;
create sequence sproduto      minvalue 1 maxvalue 99999999999 start with 2 increment by 1 nocache;