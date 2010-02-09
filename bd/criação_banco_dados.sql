drop package body pECommerce;
drop package pECommerce;
--
drop sequence scor;
drop sequence smarca;
drop sequence smodelo;
drop sequence sdepartamento;
drop sequence ssubdepartamento;
drop sequence sproduto;
drop sequence susuario;
--
drop table cor              cascade constraints;
drop table marca            cascade constraints;
drop table departamento     cascade constraints;
drop table sub_departamento cascade constraints;
drop table modelo           cascade constraints;
drop table produto          cascade constraints;
drop table usuario          cascade constraints;
--
create table USUARIO
(ID_USUARIO  NUMBER       not null,
 USUARIO     VARCHAR2(20) not null,
 SENHA       VARCHAR2(20) not null);
comment on column USUARIO.ID_USUARIO is 'Identificador do usuario.';
comment on column USUARIO.USUARIO    is 'Nome do Usuario.';
comment on column USUARIO.SENHA      is 'Senha do Usuario.';
alter table USUARIO add constraint PKUSUARIO primary key (ID_USUARIO) using index;
alter table USUARIO add constraint UNUSUARIO unique      (USUARIO)    using index;
--
create table COR
(ID_COR      NUMBER       not null,
 DESCRICAO   VARCHAR2(20) not null,
 CODIGO_HTML VARCHAR2(6));
comment on column COR.ID_COR      is 'Identificador da cor.';
comment on column COR.DESCRICAO   is 'Descrição da cor.';
comment on column COR.CODIGO_HTML is 'Codigo da cor em html.';
alter table COR add constraint PKCOR  primary key (ID_COR)      using index;
alter table COR add constraint UNCOR1 unique      (DESCRICAO)   using index;
alter table COR add constraint UNCOR2 unique      (CODIGO_HTML) using index;
--
create table MARCA
(ID_MARCA  NUMBER       not null,
 DESCRICAO VARCHAR2(40) not null);
comment on column MARCA.ID_MARCA  is 'Identificador da marca.';
comment on column MARCA.DESCRICAO is 'Descrição da marca.';
alter table MARCA add constraint PKMARCA primary key (ID_MARCA)  using index;
alter table MARCA add constraint UNMARCA unique      (DESCRICAO) using index;
--
create table DEPARTAMENTO
(ID_DEPARTAMENTO NUMBER       not null,
 DESCRICAO       VARCHAR2(40) not null);
comment on column DEPARTAMENTO.ID_DEPARTAMENTO is 'Identificador do departamento.';
comment on column DEPARTAMENTO.DESCRICAO       is 'Descrição do departamento.';
alter table DEPARTAMENTO add constraint PKDEPARTAMENTO primary key (ID_DEPARTAMENTO) using index;
alter table DEPARTAMENTO add constraint UNDEPARTAMENTO unique      (DESCRICAO)       using index;
--
create table SUB_DEPARTAMENTO
(ID_SUB_DEPARTAMENTO NUMBER       not null,
 DESCRICAO           VARCHAR2(40) not null);
comment on column SUB_DEPARTAMENTO.ID_SUB_DEPARTAMENTO is 'Identificador do sub-departamento.';
comment on column SUB_DEPARTAMENTO.DESCRICAO           is 'Descrição do sub-departamento.';
alter table SUB_DEPARTAMENTO add constraint PKSUB_DEPARTAMENTO primary key (ID_SUB_DEPARTAMENTO) using index;
alter table SUB_DEPARTAMENTO add constraint UNSUB_DEPARTAMENTO unique      (DESCRICAO)           using index;
--
create table MODELO
(ID_MODELO NUMBER not null,
 MARCA     NUMBER not null,
 DESCRICAO VARCHAR2(60) not null);
comment on column MODELO.ID_MODELO is 'Identificador do modelo.';
comment on column MODELO.MARCA     is 'Identificador da marca.';
comment on column MODELO.DESCRICAO is 'Descrição do modelo.';
alter table MODELO add constraint PKMODELO       primary key (ID_MODELO)        using index;
alter table MODELO add constraint UNMODELO       unique      (MARCA, DESCRICAO) using index;
alter table MODELO add constraint FKMODELO_MARCA foreign key (MARCA)            references MARCA (ID_MARCA);
--
create table PRODUTO
(ID_PRODUTO       NUMBER        not null,
 DESCRICAO        VARCHAR2(200) not null,
 DEPARTAMENTO     NUMBER        not null,
 SUB_DEPARTAMENTO NUMBER        not null,
 MODELO           NUMBER        not null,
 QUANTIDADE       NUMBER(12,2)  not null,
 UNIDADE          VARCHAR2(3)   not null,
 PRECO_UNIT       NUMBER(12,2)  not null,
 COR              NUMBER,
 IMAGEM           VARCHAR2(200));
comment on column PRODUTO.ID_PRODUTO       is 'Identificador do produto.';
comment on column PRODUTO.DESCRICAO        is 'Descrição do produto.';
comment on column PRODUTO.DEPARTAMENTO     is 'Identificador do departamento.';
comment on column PRODUTO.SUB_DEPARTAMENTO is 'Identificador do sub-departamento.';
comment on column PRODUTO.MODELO           is 'Identificador do modelo.';
comment on column PRODUTO.QUANTIDADE       is 'Quantidade.';
comment on column PRODUTO.UNIDADE          is 'Unidade de medida.';
comment on column PRODUTO.PRECO_UNIT       is 'Preço unitário do produto.';
comment on column PRODUTO.COR              is 'Identificador da cor.';
comment on column PRODUTO.IMAGEM           is 'Endereço da imagem do produto.';
alter table PRODUTO add constraint PKPRODUTO                  primary key (ID_PRODUTO)        using index;
alter table PRODUTO add constraint FKPRODUTO_COR              foreign key (COR)               references COR              (ID_COR);
alter table PRODUTO add constraint FKPRODUTO_DEPARTAMENTO     foreign key (DEPARTAMENTO)      references DEPARTAMENTO     (ID_DEPARTAMENTO);
alter table PRODUTO add constraint FKPRODUTO_SUB_DEPARTAMENTO foreign key (SUB_DEPARTAMENTO)  references SUB_DEPARTAMENTO (ID_SUB_DEPARTAMENTO);
alter table PRODUTO add constraint FKPRODUTO_MODELO           foreign key (MODELO)            references MODELO           (ID_MODELO);
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
  --
  -- Função que retorna a tabela de cores HTML.
  -- ==========================================
  function fRetornaTabelaCorHtml return clob;
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
  --
  -- Função que retorna a tabela de cores HTML.
  -- ==========================================
  function fRetornaTabelaCorHtml return clob is
    --
    cursor cCor is
      select *
        from cor a
       order by a.descricao;
    --
    vResposta clob := null;
  begin
    vResposta :=            '    <style type="text/css">'
              || chr(13) || '        td{font-family:verdana,arial,courier-new;'
              || chr(13) || '           font-size:12px;'
              || chr(13) || '           color:black;}'
              || chr(13) || '        body{font-family:verdana,arial,courier-new;'
              || chr(13) || '             font-size:14px;'
              || chr(13) || '             color:black;}'
              || chr(13) || '    </style>'
              || chr(13) || '<body bgcolor="white">'
              || chr(13) || '    <h2>Cores</h2>'
              || chr(13) || '    <table border="1px" width="30%" bgcolor="white">'
              || chr(13) || '        <tr>'
              || chr(13) || '            <td><b>Nome</b></td>'
              || chr(13) || '            <td><b>Cor</b></td>'
              || chr(13) || '        </tr>';
    --
    for i in cCor
    loop
      vResposta := vResposta
                || chr(13) || '        <tr>'
                || chr(13) || '            <td>'  || i.descricao || '</td>'
                || chr(13) || '            <td bgcolor=#' || i.codigo_html || '>'
                || chr(13) || '                <font color="' || i.codigo_html || '">_</font>'
                || chr(13) || '            </td>'
                || chr(13) || '        </tr>';
    end loop;
    --
    vResposta := vResposta
              || chr(13) || '    </table>'
              || chr(13) || '</body>';
    --
    return vResposta;
  end fRetornaTabelaCorHtml;
end pECommerce;
/
--
begin
  insert into usuario (id_usuario, usuario, senha)
  values (1, 'admin', 123);
  commit;
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
  insert into SUB_DEPARTAMENTO (ID_SUB_DEPARTAMENTO, DESCRICAO)
  values (1, 'GUITARRAS');
  insert into SUB_DEPARTAMENTO (ID_SUB_DEPARTAMENTO, DESCRICAO)
  values (2, 'BAIXOS');
  insert into SUB_DEPARTAMENTO (ID_SUB_DEPARTAMENTO, DESCRICAO)
  values (3, 'BATERIAS');
  insert into SUB_DEPARTAMENTO (ID_SUB_DEPARTAMENTO, DESCRICAO)
  values (4, 'TECLADOS');
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
  insert into PRODUTO (ID_PRODUTO, DESCRICAO, DEPARTAMENTO, SUB_DEPARTAMENTO, MODELO, QUANTIDADE, UNIDADE, PRECO_UNIT, IMAGEM, COR)
  values (1, 'GUITARRA', 1, 1, 2, 5, 'UN', 2500, 'fender_strato.jpg', 1);
  insert into PRODUTO (ID_PRODUTO, DESCRICAO, DEPARTAMENTO, SUB_DEPARTAMENTO, MODELO, QUANTIDADE, UNIDADE, PRECO_UNIT, IMAGEM, COR)
  values (2, 'BAIXO', 1, 2, 1, 3, 'UN', 2700, 'fender_jazz_bass.jpg', 1);
  insert into PRODUTO (ID_PRODUTO, DESCRICAO, DEPARTAMENTO, SUB_DEPARTAMENTO, MODELO, QUANTIDADE, UNIDADE, PRECO_UNIT, IMAGEM, COR)
  values (3, 'BAIXO', 1, 2, 1, 3, 'UN', 2700, 'fender_jazz_bass.jpg', 2);
  insert into PRODUTO (ID_PRODUTO, DESCRICAO, DEPARTAMENTO, SUB_DEPARTAMENTO, MODELO, QUANTIDADE, UNIDADE, PRECO_UNIT, IMAGEM, COR)
  values (4, 'BAIXO', 1, 2, 1, 3, 'UN', 2700, 'fender_jazz_bass.jpg', 3);
  insert into PRODUTO (ID_PRODUTO, DESCRICAO, DEPARTAMENTO, SUB_DEPARTAMENTO, MODELO, QUANTIDADE, UNIDADE, PRECO_UNIT, IMAGEM, COR)
  values (5, 'GUITARRA', 1, 1, 3, 5, 'UN', 2500, 'gibson_les_paul.jpg', 1);
  commit;
end;
/
--
create sequence scor             minvalue 1 maxvalue 99999999999 start with 5 increment by 1 nocache;
create sequence smarca           minvalue 1 maxvalue 99999999999 start with 4 increment by 1 nocache;
create sequence smodelo          minvalue 1 maxvalue 99999999999 start with 3 increment by 1 nocache;
create sequence sdepartamento    minvalue 1 maxvalue 99999999999 start with 4 increment by 1 nocache;
create sequence ssubdepartamento minvalue 1 maxvalue 99999999999 start with 4 increment by 1 nocache;
create sequence sproduto         minvalue 1 maxvalue 99999999999 start with 8 increment by 1 nocache;
create sequence susuario         minvalue 1 maxvalue 99999999999 start with 2 increment by 1 nocache;
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
create or replace trigger tsub_departamento_b_iud_r
  before insert
      or update
      or delete
      on departamento
  for each row
begin
  if inserting
  and  :new.id_departamento is null
  then :new.id_departamento := pECommerce.fRetornaSequence('SSUBDEPARTAMENTO','N');
  end if;
end tsub_departamento_b_iud_r;
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
create or replace trigger tusuario_b_iud_r
  before insert
      or update
      or delete
      on usuario
  for each row
begin
  if   inserting
  and  :new.id_usuario is null
  then :new.id_usuario := pECommerce.fRetornaSequence('SUSUARIO','N');
  end if;
end tusuario_b_iud_r;
/