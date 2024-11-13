/*==============================================================*/
/* Nom de SGBD :  Sybase SQL Anywhere 11                        */
/* Date de cr�ation :  13/11/2024 20:23:50                      */
/*==============================================================*/


if exists(select 1 from sys.sysforeignkey where role='FK_APPARTIE_APPARTIEN_SPECIALI') then
    alter table APPARTIENT
       delete foreign key FK_APPARTIE_APPARTIEN_SPECIALI
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_APPARTIE_APPARTIEN_FORMATIO') then
    alter table APPARTIENT
       delete foreign key FK_APPARTIE_APPARTIEN_FORMATIO
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_CONCERNE_CONCERNE_FORMATIO') then
    alter table CONCERNE
       delete foreign key FK_CONCERNE_CONCERNE_FORMATIO
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_CONCERNE_CONCERNE2_SESSION') then
    alter table CONCERNE
       delete foreign key FK_CONCERNE_CONCERNE2_SESSION
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_EST_INSC_EST_INSCR_ETUDIANT') then
    alter table EST_INSCRIT
       delete foreign key FK_EST_INSC_EST_INSCR_ETUDIANT
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_EST_INSC_EST_INSCR_SESSION') then
    alter table EST_INSCRIT
       delete foreign key FK_EST_INSC_EST_INSCR_SESSION
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_HABITE_HABITE_VILLE') then
    alter table HABITE
       delete foreign key FK_HABITE_HABITE_VILLE
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_HABITE_HABITE2_ETUDIANT') then
    alter table HABITE
       delete foreign key FK_HABITE_HABITE2_ETUDIANT
end if;

if exists(
   select 1 from sys.systable 
   where table_name='APPARTIENT'
     and table_type in ('BASE', 'GBL TEMP')
) then
    drop table APPARTIENT
end if;

if exists(
   select 1 from sys.systable 
   where table_name='CONCERNE'
     and table_type in ('BASE', 'GBL TEMP')
) then
    drop table CONCERNE
end if;

if exists(
   select 1 from sys.systable 
   where table_name='EST_INSCRIT'
     and table_type in ('BASE', 'GBL TEMP')
) then
    drop table EST_INSCRIT
end if;

if exists(
   select 1 from sys.systable 
   where table_name='ETUDIANT'
     and table_type in ('BASE', 'GBL TEMP')
) then
    drop table ETUDIANT
end if;

if exists(
   select 1 from sys.systable 
   where table_name='FORMATION'
     and table_type in ('BASE', 'GBL TEMP')
) then
    drop table FORMATION
end if;

if exists(
   select 1 from sys.systable 
   where table_name='HABITE'
     and table_type in ('BASE', 'GBL TEMP')
) then
    drop table HABITE
end if;

if exists(
   select 1 from sys.systable 
   where table_name='SESSION'
     and table_type in ('BASE', 'GBL TEMP')
) then
    drop table "SESSION"
end if;

if exists(
   select 1 from sys.systable 
   where table_name='SPECIALITE'
     and table_type in ('BASE', 'GBL TEMP')
) then
    drop table SPECIALITE
end if;

if exists(
   select 1 from sys.systable 
   where table_name='VILLE'
     and table_type in ('BASE', 'GBL TEMP')
) then
    drop table VILLE
end if;

/*==============================================================*/
/* Table : APPARTIENT                                           */
/*==============================================================*/
create table APPARTIENT 
(
   CODEFORM             char(10)                       not null,
   CODESPEC             char(10)                       not null,
   constraint PK_APPARTIENT primary key (CODEFORM, CODESPEC)
);

/*==============================================================*/
/* Table : CONCERNE                                             */
/*==============================================================*/
create table CONCERNE 
(
   CODESESS             char(10)                       not null,
   CODEFORM             char(10)                       not null,
   constraint PK_CONCERNE primary key (CODESESS, CODEFORM)
);

/*==============================================================*/
/* Table : EST_INSCRIT                                          */
/*==============================================================*/
create table EST_INSCRIT 
(
   CODESESS             char(10)                       not null,
   NUMETU               char(10)                       not null,
   constraint PK_EST_INSCRIT primary key (CODESESS, NUMETU)
);

/*==============================================================*/
/* Table : ETUDIANT                                             */
/*==============================================================*/
create table ETUDIANT 
(
   NUMETU               char(10)                       not null,
   NOMETU               char(10)                       null,
   PRENOMETU            char(10)                       null,
   DATENAISSANCE        char(10)                       null,
   NIVEAUETU            char(10)                       null,
   constraint PK_ETUDIANT primary key (NUMETU)
);

/*==============================================================*/
/* Table : FORMATION                                            */
/*==============================================================*/
create table FORMATION 
(
   CODEFORM             char(10)                       not null,
   TITREFORM            char(10)                       null,
   DATEDEBUT            char(10)                       null,
   DATEFIN              char(10)                       null,
   PRIXFORM             char(10)                       null,
   constraint PK_FORMATION primary key (CODEFORM)
);

/*==============================================================*/
/* Table : HABITE                                               */
/*==============================================================*/
create table HABITE 
(
   NUMETU               char(10)                       not null,
   IDVILLE              char(10)                       not null,
   TYPECOURS            char(10)                       null,
   constraint PK_HABITE primary key (NUMETU, IDVILLE)
);

/*==============================================================*/
/* Table : "SESSION"                                            */
/*==============================================================*/
create table "SESSION" 
(
   CODESESS             char(10)                       not null,
   NOMSESS              char(10)                       null,
   DUREESES             char(10)                       null,
   constraint PK_SESSION primary key (CODESESS)
);

/*==============================================================*/
/* Table : SPECIALITE                                           */
/*==============================================================*/
create table SPECIALITE 
(
   CODESPEC             char(10)                       not null,
   NOMSPEC              char(10)                       null,
   DESCSPEC             char(10)                       null,
   constraint PK_SPECIALITE primary key (CODESPEC)
);

/*==============================================================*/
/* Table : VILLE                                                */
/*==============================================================*/
create table VILLE 
(
   IDVILLE              char(10)                       not null,
   NOMVILLE             char(10)                       null,
   QUARTIER             char(10)                       null,
   constraint PK_VILLE primary key (IDVILLE)
);

alter table APPARTIENT
   add constraint FK_APPARTIE_APPARTIEN_SPECIALI foreign key (CODESPEC)
      references SPECIALITE (CODESPEC)
      on update restrict
      on delete restrict;

alter table APPARTIENT
   add constraint FK_APPARTIE_APPARTIEN_FORMATIO foreign key (CODEFORM)
      references FORMATION (CODEFORM)
      on update restrict
      on delete restrict;

alter table CONCERNE
   add constraint FK_CONCERNE_CONCERNE_FORMATIO foreign key (CODEFORM)
      references FORMATION (CODEFORM)
      on update restrict
      on delete restrict;

alter table CONCERNE
   add constraint FK_CONCERNE_CONCERNE2_SESSION foreign key (CODESESS)
      references "SESSION" (CODESESS)
      on update restrict
      on delete restrict;

alter table EST_INSCRIT
   add constraint FK_EST_INSC_EST_INSCR_ETUDIANT foreign key (NUMETU)
      references ETUDIANT (NUMETU)
      on update restrict
      on delete restrict;

alter table EST_INSCRIT
   add constraint FK_EST_INSC_EST_INSCR_SESSION foreign key (CODESESS)
      references "SESSION" (CODESESS)
      on update restrict
      on delete restrict;

alter table HABITE
   add constraint FK_HABITE_HABITE_VILLE foreign key (IDVILLE)
      references VILLE (IDVILLE)
      on update restrict
      on delete restrict;

alter table HABITE
   add constraint FK_HABITE_HABITE2_ETUDIANT foreign key (NUMETU)
      references ETUDIANT (NUMETU)
      on update restrict
      on delete restrict;

