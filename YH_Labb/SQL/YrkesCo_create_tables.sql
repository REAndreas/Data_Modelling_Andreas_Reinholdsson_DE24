CREATE SCHEMA IF NOT EXISTS YrkesCo;

set search_path TO YrkesCo;


CREATE TABLE IF NOT EXISTS "stad" (
  "stad_id" SERIAL PRIMARY KEY,
  "stad" VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS "adress" (
  "adress_id" SERIAL PRIMARY KEY,
  "stad_id" INTEGER NOT null REFERENCES "stad",
  "gatuadress" VARCHAR(100) NOT NULL,
  "postnummer" VARCHAR(6) NOT NULL
);

CREATE TABLE IF NOT EXISTS "skola" (
  "skol_id" SERIAL PRIMARY KEY,
  "adress_id" INTEGER NOT null REFERENCES "adress",
  "skolnamn" VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS "personuppgift" (
  "pu_id" SERIAL PRIMARY KEY,
  "adress_id" INTEGER NOT null REFERENCES "adress",
  "personnummer" CHAR(12) NOT NULL
);

CREATE TABLE IF NOT EXISTS "program" (
  "program_id" VARCHAR(10) PRIMARY KEY,
  "programnamn" VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS "skolprogram" (
  "skol_id" INTEGER NOT NULL REFERENCES "skola",
  "program_id" VARCHAR(10) NOT NULL REFERENCES "program",
  PRIMARY KEY ("skol_id", "program_id")
);

CREATE TABLE IF NOT EXISTS "beviljad_omgång" (
  "bo_id" SERIAL PRIMARY KEY,
  "program_id" VARCHAR(10) NOT NULL REFERENCES "program",
  "år" VARCHAR(2) NOT NULL
);

CREATE TABLE IF NOT EXISTS "kurs" (
  "kurskod" VARCHAR(10) PRIMARY KEY,
  "kursnamn" VARCHAR(50) NOT NULL,
  "poäng" INTEGER NOT NULL,
  "beskrivning" VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS "kursprogram" (
  "kurskod" VARCHAR NOT NULL REFERENCES "kurs",
  "program_id" VARCHAR(10) NOT NULL REFERENCES "program",
  PRIMARY KEY ("kurskod", "program_id")
);

CREATE TABLE IF NOT EXISTS "yrkesroll" (
  "yrkes_id" SERIAL PRIMARY KEY,
  "titel" VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS "personal" (
  "personal_id" SERIAL PRIMARY KEY,
  "yrkes_id" INTEGER NOT NULL REFERENCES "yrkesroll",
  "förnamn" VARCHAR(50) NOT NULL,
  "efternamn" VARCHAR(100) NOT NULL,
  "epost" VARCHAR(255) NOT NULL,
  "telefon" VARCHAR(15) NOT NULL
);

CREATE TABLE IF NOT EXISTS "konsultbolag" (
  "org_nummer" VARCHAR(11) PRIMARY KEY,
  "adress_id" INTEGER NOT NULL REFERENCES "adress",
  "bolagsnamn" VARCHAR(100) NOT NULL,
  "f_skatt" BOOL NOT NULL
);

CREATE TABLE IF NOT EXISTS "konsult" (
  "org_nummer" VARCHAR(11) NOT NULL REFERENCES "konsultbolag",
  "personal_id" INTEGER NOT NULL REFERENCES "personal",
  "timpris" FLOAT NOT NULL,
  PRIMARY KEY ("org_nummer", "personal_id")
);

CREATE TABLE IF NOT EXISTS "fastanställda" (
  "pu_id" INTEGER NOT NULL REFERENCES "personuppgift",
  "personal_id" INTEGER NOT NULL REFERENCES "personal",
  PRIMARY KEY ("pu_id", "personal_id")
);

CREATE TABLE IF NOT EXISTS "skolpersonal" (
  "skol_id" INTEGER NOT NULL REFERENCES "skola",
  "personal_id" INTEGER NOT NULL REFERENCES "personal",
  PRIMARY KEY ("skol_id", "personal_id")
);

CREATE TABLE IF NOT EXISTS "kurstillfälle" (
  "kurskod" VARCHAR NOT NULL REFERENCES "kurs",
  "personal_id" INTEGER NOT NULL REFERENCES "personal",
  PRIMARY KEY ("kurskod", "personal_id")
);

CREATE TABLE IF NOT EXISTS "fristående_kurs" (
  "fk_id" SERIAL PRIMARY KEY,
  "skol_id" INTEGER REFERENCES "skola",
  "kurskod" VARCHAR REFERENCES "kurs",
  "personal_id" INTEGER REFERENCES "personal"
);

CREATE TABLE IF NOT EXISTS "student" (
  "student_id" SERIAL PRIMARY KEY,
  "pu_id" INTEGER NOT NULL REFERENCES "personuppgift",
  "skol_id" INTEGER NOT NULL REFERENCES "skola",
  "förnamn" VARCHAR(50) NOT NULL,
  "efternamn" VARCHAR(100) NOT NULL,
  "epost" VARCHAR(255) NOT NULL,
  "telefon" VARCHAR(15) NOT NULL
);

CREATE TABLE IF NOT EXISTS "fristående_student" (
  "fk_id" INTEGER NOT NULL REFERENCES "fristående_kurs",
  "student_id" INTEGER NOT NULL REFERENCES "student",
  PRIMARY KEY ("fk_id", "student_id")
);

CREATE TABLE IF NOT EXISTS "klass" (
  "klass_id" SERIAL PRIMARY key,
  "bo_id" INTEGER NOT NULL REFERENCES "beviljad_omgång",
  "skol_id" INTEGER NOT NULL REFERENCES "skola",
  "personal_id" INTEGER NOT NULL REFERENCES "personal"
);


CREATE TABLE IF NOT EXISTS "antagen_student" (
  "klass_id" INTEGER NOT NULL REFERENCES "klass",
  "student_id" INTEGER NOT NULL REFERENCES "student",
  PRIMARY KEY ("klass_id", "student_id")
);

CREATE TABLE IF NOT EXISTS "kursbetyg" (
  "kurskod" VARCHAR NOT NULL REFERENCES "kurs",
  "student_id" INTEGER NOT NULL REFERENCES "student",
  "betyg" VARCHAR(3) NOT NULL,
  PRIMARY KEY ("kurskod", "student_id")
);

CREATE TABLE IF NOT EXISTS "ledningsgrupp" (
  "ledningsgrupp_id" SERIAL PRIMARY KEY,
  "program_id" VARCHAR(10) NOT NULL REFERENCES "program",
  "skol_id" INTEGER NOT NULL REFERENCES "skola"
);

CREATE TABLE IF NOT EXISTS "ledningspersonal" (
  "ledningsgrupp_id" INTEGER NOT NULL REFERENCES "ledningsgrupp",
  "personal_id" INTEGER NOT NULL REFERENCES "personal",
  PRIMARY KEY ("ledningsgrupp_id", "personal_id")
);

CREATE TABLE IF NOT EXISTS "ledningstudent" (
  "ledningsgrupp_id" INTEGER NOT NULL REFERENCES "ledningsgrupp",
  "student_id" INTEGER NOT NULL REFERENCES "student",
  PRIMARY KEY ("ledningsgrupp_id", "student_id")
);

CREATE TABLE IF NOT EXISTS "företag" (
  "företag_org_nummer" VARCHAR(11) PRIMARY KEY,
  "företag_namn" VARCHAR(100) NOT NULL,
  "representant" VARCHAR(100) NOT NULL,
  "epost" VARCHAR(255) NOT NULL,
  "telefon" VARCHAR(15) NOT NULL
);

CREATE TABLE IF NOT EXISTS "ledningsföretag" (
  "ledningsgrupp_id" INTEGER NOT NULL REFERENCES "ledningsgrupp",
  "företag_org_nummer" VARCHAR(11) NOT NULL REFERENCES "företag",
  PRIMARY KEY ("ledningsgrupp_id", "företag_org_nummer")
);

CREATE TABLE IF NOT EXISTS "protokoll" (
  "protokoll_id" SERIAL PRIMARY KEY,
  "ledningsgrupp_id" INTEGER NOT NULL REFERENCES "ledningsgrupp",
  "protokoll" VARCHAR(100000) NOT NULL,
  "datum" DATE NOT NULL
);




/*

ALTER TABLE "skola" ADD FOREIGN KEY ("adress_id") REFERENCES "adress" ("adress_id");

ALTER TABLE "adress" ADD FOREIGN KEY ("stad_id") REFERENCES "stad" ("stad_id");

ALTER TABLE "student" ADD FOREIGN KEY ("pu_id") REFERENCES "personuppgifter" ("pu_id");

ALTER TABLE "student" ADD FOREIGN KEY ("skol_id") REFERENCES "skola" ("skol_id");

ALTER TABLE "fristående_kurs" ADD FOREIGN KEY ("skol_id") REFERENCES "skola" ("skol_id");

ALTER TABLE "fristående_kurs" ADD FOREIGN KEY ("kurs_id") REFERENCES "kurs" ("kurs_id");

ALTER TABLE "fristående_kurs" ADD FOREIGN KEY ("personal_id") REFERENCES "personal" ("personal_id");

ALTER TABLE "fristående_student" ADD FOREIGN KEY ("fk_id") REFERENCES "fristående_kurs" ("fk_id");

ALTER TABLE "fristående_student" ADD FOREIGN KEY ("student_id") REFERENCES "student" ("student_id");

ALTER TABLE "klass" ADD FOREIGN KEY ("bo_id") REFERENCES "beviljad_omgång" ("bo_id");

ALTER TABLE "klass" ADD FOREIGN KEY ("personal_id") REFERENCES "personal" ("personal_id");

ALTER TABLE "klass" ADD FOREIGN KEY ("skol_id") REFERENCES "skola" ("skol_id");

ALTER TABLE "klass" ADD FOREIGN KEY ("student_id") REFERENCES "student" ("student_id");

ALTER TABLE "personuppgifter" ADD FOREIGN KEY ("adress_id") REFERENCES "adress" ("adress_id");

ALTER TABLE "beviljad_omgång" ADD FOREIGN KEY ("program_id") REFERENCES "program" ("program_id");

ALTER TABLE "skolprogram" ADD FOREIGN KEY ("skol_id") REFERENCES "skola" ("skol_id");

ALTER TABLE "skolprogram" ADD FOREIGN KEY ("program_id") REFERENCES "program" ("program_id");

ALTER TABLE "kursprogram" ADD FOREIGN KEY ("kurs_id") REFERENCES "kurs" ("kurs_id");

ALTER TABLE "kursprogram" ADD FOREIGN KEY ("program_id") REFERENCES "program" ("program_id");

ALTER TABLE "kursbetyg" ADD FOREIGN KEY ("student_id") REFERENCES "student" ("student_id");

ALTER TABLE "kursbetyg" ADD FOREIGN KEY ("kurs_id") REFERENCES "kurs" ("kurs_id");

ALTER TABLE "ledningsgrupp" ADD FOREIGN KEY ("program_id") REFERENCES "program" ("program_id");

ALTER TABLE "ledningsgrupp" ADD FOREIGN KEY ("skol_id") REFERENCES "skola" ("skol_id");

ALTER TABLE "ledningsföretag" ADD FOREIGN KEY ("ledningsgrupp_id") REFERENCES "ledningsgrupp" ("ledningsgrupp_id");

ALTER TABLE "ledningsföretag" ADD FOREIGN KEY ("företag_org_nummer") REFERENCES "företag" ("företag_org_nummer");

ALTER TABLE "ledningstudent" ADD FOREIGN KEY ("ledningsgrupp_id") REFERENCES "ledningsgrupp" ("ledningsgrupp_id");

ALTER TABLE "ledningstudent" ADD FOREIGN KEY ("student_id") REFERENCES "student" ("student_id");

ALTER TABLE "protokoll" ADD FOREIGN KEY ("ledningsgrupp_id") REFERENCES "ledningsgrupp" ("ledningsgrupp_id");

ALTER TABLE "ledningspersonal" ADD FOREIGN KEY ("ledningsgrupp_id") REFERENCES "ledningsgrupp" ("ledningsgrupp_id");

ALTER TABLE "ledningspersonal" ADD FOREIGN KEY ("personal_id") REFERENCES "personal" ("personal_id");

ALTER TABLE "personal" ADD FOREIGN KEY ("yrkes_id") REFERENCES "yrkesroll" ("yrkes_id");

ALTER TABLE "kurstillfälle" ADD FOREIGN KEY ("personal_id") REFERENCES "personal" ("personal_id");

ALTER TABLE "kurstillfälle" ADD FOREIGN KEY ("kurs_id") REFERENCES "kurs" ("kurs_id");

ALTER TABLE "skolpersonal" ADD FOREIGN KEY ("personal_id") REFERENCES "personal" ("personal_id");

ALTER TABLE "skolpersonal" ADD FOREIGN KEY ("skol_id") REFERENCES "skola" ("skol_id");

ALTER TABLE "konsult" ADD FOREIGN KEY ("konsult_org_nummer") REFERENCES "konsultbolag" ("konsult_org_nummer");

ALTER TABLE "konsult" ADD FOREIGN KEY ("personal_id") REFERENCES "personal" ("personal_id");

ALTER TABLE "konsultbolag" ADD FOREIGN KEY ("adress_id") REFERENCES "adress" ("adress_id");

ALTER TABLE "fastanställning" ADD FOREIGN KEY ("pu_id") REFERENCES "person_uppgifter" ("pu_id");

ALTER TABLE "fastanställning" ADD FOREIGN KEY ("personal_id") REFERENCES "personal" ("personal_id");

*/
