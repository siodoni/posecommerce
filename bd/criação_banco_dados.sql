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
drop sequence sestoque;
drop sequence spedido;
drop sequence spedidoitem;
--
drop table cor              cascade constraints;
drop table marca            cascade constraints;
drop table departamento     cascade constraints;
drop table sub_departamento cascade constraints;
drop table modelo           cascade constraints;
drop table produto          cascade constraints;
drop table usuario          cascade constraints;
drop table estoque          cascade constraints;
drop table pedido           cascade constraints;
drop table pedido_item      cascade constraints;
--
create table USUARIO
(ID_USUARIO  NUMBER       not null,
 NOME        VARCHAR2(60) not null,
 USUARIO     VARCHAR2(20) not null,
 SENHA       VARCHAR2(20) not null,
 PERMISSAO   VARCHAR2(20) default 'user' not null);
comment on column USUARIO.ID_USUARIO is 'Identificador do usuario.';
comment on column USUARIO.NOME       is 'Nome do usu�rio';
comment on column USUARIO.USUARIO    is 'Nome do Usuario.';
comment on column USUARIO.SENHA      is 'Senha do Usuario.';
comment on column USUARIO.PERMISSAO  is 'Permiss�o do Usuario.';
alter table USUARIO add constraint PKUSUARIO           primary key (ID_USUARIO) using index;
alter table USUARIO add constraint UNUSUARIO           unique      (USUARIO)    using index;
alter table USUARIO add constraint CKUSUARIO_PERMISSAO check       (PERMISSAO IN ('admin','user'));
--
create table COR
(ID_COR      NUMBER       not null,
 DESCRICAO   VARCHAR2(20) not null,
 CODIGO_HTML VARCHAR2(6));
comment on column COR.ID_COR      is 'Identificador da cor.';
comment on column COR.DESCRICAO   is 'Descri��o da cor.';
comment on column COR.CODIGO_HTML is 'Codigo da cor em html.';
alter table COR add constraint PKCOR  primary key (ID_COR)      using index;
alter table COR add constraint UNCOR1 unique      (DESCRICAO)   using index;
alter table COR add constraint UNCOR2 unique      (CODIGO_HTML) using index;
--
create table MARCA
(ID_MARCA  NUMBER       not null,
 DESCRICAO VARCHAR2(40) not null);
comment on column MARCA.ID_MARCA  is 'Identificador da marca.';
comment on column MARCA.DESCRICAO is 'Descri��o da marca.';
alter table MARCA add constraint PKMARCA primary key (ID_MARCA)  using index;
alter table MARCA add constraint UNMARCA unique      (DESCRICAO) using index;
--
create table DEPARTAMENTO
(ID_DEPARTAMENTO NUMBER       not null,
 DESCRICAO       VARCHAR2(40) not null);
comment on column DEPARTAMENTO.ID_DEPARTAMENTO is 'Identificador do departamento.';
comment on column DEPARTAMENTO.DESCRICAO       is 'Descri��o do departamento.';
alter table DEPARTAMENTO add constraint PKDEPARTAMENTO primary key (ID_DEPARTAMENTO) using index;
alter table DEPARTAMENTO add constraint UNDEPARTAMENTO unique      (DESCRICAO)       using index;
--
create table SUB_DEPARTAMENTO
(ID_SUB_DEPARTAMENTO NUMBER       not null,
 DESCRICAO           VARCHAR2(40) not null);
comment on column SUB_DEPARTAMENTO.ID_SUB_DEPARTAMENTO is 'Identificador do sub-departamento.';
comment on column SUB_DEPARTAMENTO.DESCRICAO           is 'Descri��o do sub-departamento.';
alter table SUB_DEPARTAMENTO add constraint PKSUB_DEPARTAMENTO primary key (ID_SUB_DEPARTAMENTO) using index;
alter table SUB_DEPARTAMENTO add constraint UNSUB_DEPARTAMENTO unique      (DESCRICAO)           using index;
--
create table MODELO
(ID_MODELO NUMBER       not null,
 MARCA     NUMBER       not null,
 DESCRICAO VARCHAR2(60) not null);
comment on column MODELO.ID_MODELO is 'Identificador do modelo.';
comment on column MODELO.MARCA     is 'Identificador da marca.';
comment on column MODELO.DESCRICAO is 'Descri��o do modelo.';
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
 COR              NUMBER,
 IMAGEM           VARCHAR2(200));
comment on column PRODUTO.ID_PRODUTO       is 'Identificador do produto.';
comment on column PRODUTO.DESCRICAO        is 'Descri��o do produto.';
comment on column PRODUTO.DEPARTAMENTO     is 'Identificador do departamento.';
comment on column PRODUTO.SUB_DEPARTAMENTO is 'Identificador do sub-departamento.';
comment on column PRODUTO.MODELO           is 'Identificador do modelo.';
comment on column PRODUTO.COR              is 'Identificador da cor.';
comment on column PRODUTO.IMAGEM           is 'Endere�o da imagem do produto.';
alter table PRODUTO add constraint PKPRODUTO                  primary key (ID_PRODUTO)        using index;
alter table PRODUTO add constraint FKPRODUTO_COR              foreign key (COR)               references COR              (ID_COR);
alter table PRODUTO add constraint FKPRODUTO_DEPARTAMENTO     foreign key (DEPARTAMENTO)      references DEPARTAMENTO     (ID_DEPARTAMENTO);
alter table PRODUTO add constraint FKPRODUTO_SUB_DEPARTAMENTO foreign key (SUB_DEPARTAMENTO)  references SUB_DEPARTAMENTO (ID_SUB_DEPARTAMENTO);
alter table PRODUTO add constraint FKPRODUTO_MODELO           foreign key (MODELO)            references MODELO           (ID_MODELO);
--
create table ESTOQUE
(ID_ESTOQUE NUMBER       not null,
 PRODUTO    NUMBER       not null,
 DT_AQUIS   DATE         not null,
 VLR_AQUIS  NUMBER(12,2) not null,
 QTDE_AQUIS NUMBER(12,2) not null,
 QTDE_DISP  NUMBER(12,2) not null,
 VLR_VENDA  NUMBER(12,2) not null);
comment on column ESTOQUE.ID_ESTOQUE is 'Identificador do movimento de estoque.';
comment on column ESTOQUE.PRODUTO    is 'Identificador do produto.';
comment on column ESTOQUE.DT_AQUIS   is 'Data de aquisi��o do produto.';
comment on column ESTOQUE.VLR_AQUIS  is 'Valor de aquisi��o do produto.';
comment on column ESTOQUE.QTDE_AQUIS is 'Quantidade de aquisi��o do produto.';
comment on column ESTOQUE.QTDE_DISP  is 'Identifica a quantidade disponivel em estoque.';
comment on column ESTOQUE.VLR_VENDA  is 'Valor de venda do produto (valor que ser� mostrado ao cliente).';
alter table ESTOQUE add constraint PKESTOQUE            primary key (ID_ESTOQUE) using index;
alter table ESTOQUE add constraint FKESTOQUE_PRODUTO    foreign key (PRODUTO)    references PRODUTO (ID_PRODUTO);
alter table ESTOQUE add constraint CKESTOQUE_QTDE_AQUIS check       (QTDE_AQUIS >= 0);
alter table ESTOQUE add constraint CKESTOQUE_QTDE_DISP  check       (QTDE_DISP >= 0);
alter table ESTOQUE add constraint CKESTOQUE_VLR_AQUIS  check       (VLR_AQUIS >= 0);
alter table ESTOQUE add constraint CKESTOQUE_VLR_VENDA  check       (VLR_VENDA >= 0);
--
create table PEDIDO
(ID_PEDIDO NUMBER not null,
 DATA      DATE   default sysdate not null,
 USUARIO   NUMBER not null);
comment on column PEDIDO.ID_PEDIDO is 'Identificador do pedido';
comment on column PEDIDO.DATA      is 'Data de gera��o do pedido.';
comment on column PEDIDO.USUARIO   is 'Cliente do pedido.';
alter table PEDIDO add constraint PKPEDIDO         primary key (ID_PEDIDO) using index;
alter table PEDIDO add constraint FKPEDIDO_USUARIO foreign key (USUARIO)   references USUARIO (ID_USUARIO);
--
create table PEDIDO_ITEM
(ID_PEDIDO_ITEM NUMBER not null,
 PEDIDO         NUMBER not null,
 PRODUTO        NUMBER not null,
 QUANTIDADE     NUMBER not null,
 VLR_VENDA      NUMBER(12,2) not null);
comment on column PEDIDO_ITEM.ID_PEDIDO_ITEM is 'Identificador do item do pedido.';
comment on column PEDIDO_ITEM.PEDIDO         is 'Identificador do pedido.';
comment on column PEDIDO_ITEM.PRODUTO        is 'Produto do item do pedido.';
comment on column PEDIDO_ITEM.QUANTIDADE     is 'Quantidade do item do pedido.';
comment on column PEDIDO_ITEM.VLR_VENDA      is 'Valor de venda do item do pedido.';
alter table PEDIDO_ITEM add constraint PKPEDIDO_ITEM            primary key (ID_PEDIDO_ITEM) using index;
alter table PEDIDO_ITEM add constraint FKPEDIDO_ITEM_PEDITO     foreign key (PEDIDO)         references PEDIDO (ID_PEDIDO);
alter table PEDIDO_ITEM add constraint FKPEDIDO_ITEM_PRODUTO    foreign key (PRODUTO)        references PRODUTO (ID_PRODUTO);
alter table PEDIDO_ITEM add constraint CKPEDIDO_ITEM_QUANTIDADE check (quantidade > 0);
--
create or replace package pECommerce is
--
-- Criado por : Fl�vio
-- Em         : 17/01/2010 12:19:40
-- Coment�rio : Checagens do projeto e-commerce.
-- =============================================
  --
  -- Retorna o valor de uma sequence.
  -- pValor: [N]extval ou [C]urrval.
  -- ================================
  function fRetornaSequence(pNomeSequence varchar2,
                            pValor        varchar2 := 'N') return number;
  --
  -- Fun��o que retorna o valor de venda.
  -- pMaxMin - deve receber MAX para o maior valor ou MIN para o menor valor.
  -- ========================================================================
  function fRetornaVlrVenda(pProduto number,
                            pMaxMin  varchar2) return number;
  --
  -- Fun��o que retorna o total disponivel de um produto em estoque.
  -- ===============================================================
  function fRetornaQtdDisp(pProduto number) return number;
  --
  -- Fun��o que retorna a tabela de cores HTML.
  -- ==========================================
  function fRetornaTabelaCorHtml return clob;
  --
  -- Procedimento que baixa uma venda no estoque.
  -- ============================================
  procedure BaixaEstoque(pProduto    number,
                         pQuantidade number,
                         pValorVenda number);
end pECommerce;
/
create or replace package body pECommerce is
--
-- Criado por : Fl�vio
-- Em         : 17/01/2010 12:19:40
-- Coment�rio : Checagens do projeto e-commerce.
-- =============================================
  --
  -- Retorna o valor de uma sequence.
  -- pValor: [N]extval ou [C]urrval.
  -- ================================
  function fRetornaSequence(pNomeSequence varchar2,
                            pValor        varchar2 := 'N') return number is
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
  -- Fun��o que retorna o valor de venda.
  -- pMaxMin - deve receber MAX para o maior valor ou MIN para o menor valor.
  -- ========================================================================
  function fRetornaVlrVenda(pProduto number,
                            pMaxMin  varchar2) return number is
    --
    cursor cEstoque is
      select max(a.vlr_venda) maximo,
             min(a.vlr_venda) minimo
        from estoque a
       where a.produto = pProduto;
    --
    vEstoque   cEstoque%rowtype;
    vResposta  number;
  begin
    open cEstoque;
    fetch cEstoque into vEstoque;
    close cEstoque;
    --
    if pMaxMin = 'MAX'
    then vResposta := vEstoque.maximo;
    else vResposta := vEstoque.minimo;
    end if;
    --
    return vResposta;
  end fRetornaVlrVenda;
  --
  -- Fun��o que retorna o total disponivel de um produto em estoque.
  -- ===============================================================
  function fRetornaQtdDisp(pProduto number) return number is
    --
    cursor cEstoque is
      select sum(a.qtde_disp) qtde_disp
        from estoque a
       where a.produto = pProduto;
    --
    vResposta  number;
  begin
    open cEstoque;
    fetch cEstoque into vResposta;
    close cEstoque;
    --
    return vResposta;
  end fRetornaQtdDisp;
  --
  -- Fun��o que retorna a tabela de cores HTML.
  -- ==========================================
  function fRetornaTabelaCorHtml return clob is
    --
    cursor cCor is
      select a.id_cor,
             a.descricao,
             a.codigo_html
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
  --
  -- Procedimento que baixa uma venda no estoque.
  -- ============================================
  procedure BaixaEstoque(pProduto    number,
                         pQuantidade number,
                         pValorVenda number) is
    --
    cursor cEstoque is
      select min(a.id_estoque) estoque
        from estoque a
       where a.produto   = pProduto
         and a.vlr_venda = pValorVenda;
    --
    vIdEstoque number;
  begin
    open cEstoque;
    fetch cEstoque into vIdEstoque;
    if cEstoque%notfound
    then
      raise_application_error
      (-20000,'Estoque n�o encontrado para o produto ' || pProduto);
    end if;
    close cEstoque;
    --
    begin
      update estoque a
         set a.qtde_disp  = (a.qtde_disp - pQuantidade)
       where a.id_estoque = vIdEstoque;
    exception
      when others
        then
          raise_application_error
          (-20000,'Erro na atualiza��o do estoque do produto ' || pProduto
               || ' valor ' || pValorVenda || '. Erro: ' || substr(sqlerrm,1,255));
    end;
  end BaixaEstoque;
end pECommerce;
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
  values (3, 'PERCUSS�O');
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
  insert into PRODUTO (ID_PRODUTO, DESCRICAO,  DEPARTAMENTO, SUB_DEPARTAMENTO, MODELO, IMAGEM, COR)
  values (1, 'GUITARRA', 1, 1, 2, 'fender_strato.jpg', 1);
  insert into PRODUTO (ID_PRODUTO, DESCRICAO,  DEPARTAMENTO, SUB_DEPARTAMENTO, MODELO, IMAGEM, COR)
  values (2, 'BAIXO', 1, 2, 1, 'fender_jazz_bass.jpg', 1);
  insert into PRODUTO (ID_PRODUTO, DESCRICAO,  DEPARTAMENTO, SUB_DEPARTAMENTO, MODELO, IMAGEM, COR)
  values (3, 'BAIXO', 1, 2, 1, 'fender_jazz_bass.jpg', 2);
  insert into PRODUTO (ID_PRODUTO, DESCRICAO,  DEPARTAMENTO, SUB_DEPARTAMENTO, MODELO, IMAGEM, COR)
  values (4, 'BAIXO', 1, 2, 1, 'fender_jazz_bass.jpg', 3);
  insert into PRODUTO (ID_PRODUTO, DESCRICAO,  DEPARTAMENTO, SUB_DEPARTAMENTO, MODELO, IMAGEM, COR)
  values (5,'GUITARRA', 1, 1, 3, 'gibson_les_paul.jpg', 1);
  commit;
end;
/
--
create sequence scor             minvalue 1 maxvalue 99999999999 start with 6 increment by 1 nocache;
create sequence smarca           minvalue 1 maxvalue 99999999999 start with 5 increment by 1 nocache;
create sequence smodelo          minvalue 1 maxvalue 99999999999 start with 4 increment by 1 nocache;
create sequence sdepartamento    minvalue 1 maxvalue 99999999999 start with 5 increment by 1 nocache;
create sequence ssubdepartamento minvalue 1 maxvalue 99999999999 start with 5 increment by 1 nocache;
create sequence sproduto         minvalue 1 maxvalue 99999999999 start with 6 increment by 1 nocache;
create sequence susuario         minvalue 1 maxvalue 99999999999 start with 1 increment by 1 nocache;
create sequence sestoque         minvalue 1 maxvalue 99999999999 start with 1 increment by 1 nocache;
create sequence spedido          minvalue 1 maxvalue 99999999999 start with 2 increment by 1 nocache;
create sequence spedidoitem      minvalue 1 maxvalue 99999999999 start with 1 increment by 1 nocache;
--
create or replace trigger tmarca_b_iud_r
  before insert
      or update
      or delete
      on marca
  for each row
begin
  if inserting
  and :new.id_marca is null
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
  if inserting
  and :new.id_modelo is null  
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
  and :new.id_departamento is null
  then :new.id_departamento := pECommerce.fRetornaSequence('SDEPARTAMENTO','N');
  end if;
end tdepartamento_b_iud_r;
/
--
create or replace trigger tsub_departamento_b_iud_r
  before insert
      or update
      or delete
      on sub_departamento
  for each row
begin
  if inserting
  and :new.id_sub_departamento is null
  then :new.id_sub_departamento := pECommerce.fRetornaSequence('SSUBDEPARTAMENTO','N');
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
  and :new.id_produto is null
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
  and :new.id_cor is null
  then :new.id_cor := pECommerce.fRetornaSequence('SCOR','N');
  end if;
end tcor_b_iud_r;
/
--
create or replace trigger tusuario_b_iud_r
  before insert
      or update
      or delete
      on usuario
  for each row
begin
  if inserting
  and :new.id_usuario is null
  then :new.id_usuario := pECommerce.fRetornaSequence('SUSUARIO','N');
  end if;
  --
  if inserting
  or updating
  then :new.permissao := lower(:new.permissao);
  end if;
  --
  if deleting
  then
    if lower(:old.usuario) = 'admin'
    then
      raise_application_error
      (-20000,'N�o � poss�vel excluir o usu�rio administrador do sistema.');
    end if;
  end if;
end tusuario_b_iud_r;
/
--
create or replace trigger testoque_b_iud_r
  before insert
      or update
      or delete
      on estoque
  for each row
begin
  if inserting
  and :new.id_estoque is null
  then :new.id_estoque := pECommerce.fRetornaSequence('SESTOQUE','N');
  end if;
end testoque_b_iud_r;
/
--
create or replace trigger tpedido_b_iud_r
  before insert
      or update
      or delete
      on pedido
  for each row
begin
  if inserting
  and :new.id_pedido is null
  then :new.id_pedido := pECommerce.fRetornaSequence('SPEDIDO','N');
  end if;
end tpedido_b_iud_r;
/
--
create or replace trigger tpedido_item_b_iud_r
  before insert
      or update
      or delete
      on pedido_item
  for each row
begin
  if inserting
  then
    if :new.id_pedido_item is null
    then :new.id_pedido_item := pECommerce.fRetornaSequence('SPEDIDOITEM','N');
    end if;
    --
    pECommerce.BaixaEstoque(pProduto    => :new.produto,
                            pQuantidade => :new.quantidade,
                            pValorVenda => :new.vlr_venda);
  end if;
  --
  if deleting
  then
    pECommerce.BaixaEstoque(pProduto    => :old.produto,
                            pQuantidade => :old.quantidade * -1,
                            pValorVenda => :old.vlr_venda);
  end if;
end tpedido_item_b_iud_r;
/
--
begin
  insert into usuario (usuario, nome, senha, permissao)
  values ('admin', 'Administrador do Sistema', 'admin', 'admin');
  --
  insert into usuario (usuario, nome, senha, permissao)
  values ('ely', 'Ely', 'ely', 'user');
  --
  insert into usuario (usuario, nome, senha, permissao)
  values ('flavio', 'Fl�vio', 'flavio', 'user');
  --
  commit;
  --
  insert into estoque(produto, dt_aquis, vlr_aquis, qtde_aquis, qtde_disp, vlr_venda)
  values (1, to_date('01/02/2010','dd/mm/rrrr'), 1850.75, 5, 4, 2499.90);
  --  
  insert into estoque(produto, dt_aquis, vlr_aquis, qtde_aquis, qtde_disp, vlr_venda)
  values (2, to_date('01/02/2010','dd/mm/rrrr'), 1953.15, 3, 1, 2599.90);
  --
  insert into estoque(produto, dt_aquis, vlr_aquis, qtde_aquis, qtde_disp, vlr_venda)
  values (3, to_date('01/02/2010','dd/mm/rrrr'), 2115.17, 3, 2, 2699.90);
  --
  insert into estoque(produto, dt_aquis, vlr_aquis, qtde_aquis, qtde_disp, vlr_venda)
  values (4, to_date('01/02/2010','dd/mm/rrrr'), 1615.50, 3, 1, 1899.90);
  --
  insert into estoque(produto, dt_aquis, vlr_aquis, qtde_aquis, qtde_disp, vlr_venda)
  values (5, to_date('01/02/2010','dd/mm/rrrr'), 1980.20, 3, 2, 2749.90);
  --
  insert into pedido(id_pedido, usuario)
  values(1,1);
  --
  insert into pedido_item(pedido, produto, quantidade, vlr_venda)
  values(1, 4, 1, 1899.90);
  --
  commit;
end;
/