
create table USUARIOS
(ID_USUARIO      NUMBER       not null,
 USUARIO   VARCHAR2(20) not null,
 SENHA VARCHAR2(20) not null);
comment on column USUARIOS.ID_USUARIO      is 'Identificador do usuario.';
comment on column USUARIOS.USUARIO   is 'Nome do Usuario.';
comment on column USUARIOS.SENHA is 'Senha do Usuario.';
alter table USUARIOS add constraint PKUSUARIO  primary key (ID_USUARIO)      using index;
alter table USUARIOS add constraint UNUSUARIO1 unique      (USUARIO)   using index;


--
create sequence susuario             minvalue 1 maxvalue 99999999999 start with 1 increment by 1 nocache;
--
create or replace trigger tusuario_b_iud_r
  before insert
      or update
      or delete
      on usuarios
  for each row
begin
  if   inserting
  and  :new.id_usuario is null
  then :new.id_usuario := pECommerce.fRetornaSequence('SUSUARIO','N');
  end if;
end tusuario_b_iud_r;
/

insert into usuarios (usuario, senha) values ('admin', 123)