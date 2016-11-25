DROP TABLE IF EXISTS "public"."attendance";
CREATE TABLE "public"."attendance" (
	"id" int8 NOT NULL,
	"student_id" int8 NOT NULL,
	"class_id" int8 NOT NULL,
	"mark" int8,
	"presence" int2 NOT NULL,
	"reason" varchar(255) COLLATE "default",
	"created_at" timestamp(6) NULL,
	"updated_at" timestamp(6) NULL,
	"deleted_at" timestamp(6) NULL
)
WITH (OIDS=FALSE);
ALTER TABLE "public"."attendance" OWNER TO "justnero";
DROP TABLE IF EXISTS "public"."cathedra";
CREATE TABLE "public"."cathedra" (
	"id" int8 NOT NULL,
	"name" varchar(255) NOT NULL COLLATE "default",
	"institute_id" int8 NOT NULL,
	"site" varchar(255) COLLATE "default",
	"email" varchar(255) COLLATE "default",
	"phone" varchar(255) COLLATE "default",
	"created_at" timestamp(6) NULL,
	"updated_at" timestamp(6) NULL,
	"deleted_at" timestamp(6) NULL
)
WITH (OIDS=FALSE);
ALTER TABLE "public"."cathedra" OWNER TO "justnero";
DROP TABLE IF EXISTS "public"."cathedra_teacher";
CREATE TABLE "public"."cathedra_teacher" (
	"cathedra_id" int8 NOT NULL,
	"teacher_id" int8 NOT NULL
)
WITH (OIDS=FALSE);
ALTER TABLE "public"."cathedra_teacher" OWNER TO "justnero";
DROP TABLE IF EXISTS "public"."certificate";
CREATE TABLE "public"."certificate" (
	"id" int8 NOT NULL,
	"student_id" int8 NOT NULL,
	"date_from" date NOT NULL,
	"date_to" date NOT NULL,
	"created_at" timestamp(6) NULL,
	"updated_at" timestamp(6) NULL,
	"deleted_at" timestamp(6) NULL
)
WITH (OIDS=FALSE);
ALTER TABLE "public"."certificate" OWNER TO "justnero";
DROP TABLE IF EXISTS "public"."class";
CREATE TABLE "public"."class" (
	"id" int8 NOT NULL,
	"discipline_id" int8 NOT NULL,
	"teacher_id" int8,
	"group_id" int8 NOT NULL,
	"location" varchar(255) COLLATE "default",
	"date" timestamp(6) NULL,
	"duration" time(6) NOT NULL,
	"type" varchar(255) NOT NULL COLLATE "default",
	"created_at" timestamp(6) NULL,
	"updated_at" timestamp(6) NULL,
	"deleted_at" timestamp(6) NULL
)
WITH (OIDS=FALSE);
ALTER TABLE "public"."class" OWNER TO "justnero";
DROP TABLE IF EXISTS "public"."discipline";
CREATE TABLE "public"."discipline" (
	"id" int8 NOT NULL,
	"name" varchar(64) COLLATE "default",
	"created_at" timestamp(6) NULL,
	"updated_at" timestamp(6) NULL,
	"deleted_at" timestamp(6) NULL
)
WITH (OIDS=FALSE);
ALTER TABLE "public"."discipline" OWNER TO "justnero";
DROP TABLE IF EXISTS "public"."discipline_teacher";
CREATE TABLE "public"."discipline_teacher" (
	"discipline_id" int8 NOT NULL,
	"teacher_id" int8 NOT NULL
)
WITH (OIDS=FALSE);
ALTER TABLE "public"."discipline_teacher" OWNER TO "justnero";
DROP TABLE IF EXISTS "public"."group";
CREATE TABLE "public"."group" (
	"id" int8 NOT NULL,
	"name" varchar(64) NOT NULL COLLATE "default",
	"course" int4,
	"cathedra_id" int8,
	"steward_id" int8,
	"super_id" int8,
	"created_at" timestamp(6) NULL,
	"updated_at" timestamp(6) NULL,
	"deleted_at" timestamp(6) NULL
)
WITH (OIDS=FALSE);
ALTER TABLE "public"."group" OWNER TO "justnero";
DROP TABLE IF EXISTS "public"."group_student";
CREATE TABLE "public"."group_student" (
	"group_id" int8 NOT NULL,
	"student_id" int8 NOT NULL
)
WITH (OIDS=FALSE);
ALTER TABLE "public"."group_student" OWNER TO "justnero";
DROP TABLE IF EXISTS "public"."institute";
CREATE TABLE "public"."institute" (
	"id" int8 NOT NULL,
	"name" varchar(255) NOT NULL COLLATE "default",
	"university_id" int8 NOT NULL,
	"site" varchar(255) COLLATE "default",
	"email" varchar(255) COLLATE "default",
	"phone" varchar(255) COLLATE "default",
	"created_at" timestamp(6) NULL,
	"updated_at" timestamp(6) NULL,
	"deleted_at" timestamp(6) NULL
)
WITH (OIDS=FALSE);
ALTER TABLE "public"."institute" OWNER TO "justnero";
DROP TABLE IF EXISTS "public"."student";
CREATE TABLE "public"."student" (
	"id" int8 NOT NULL,
	"name" varchar(255) NOT NULL COLLATE "default",
	"address" varchar(255) COLLATE "default",
	"email" varchar(255) COLLATE "default",
	"phone" varchar(255) COLLATE "default",
	"created_at" timestamp(6) NULL,
	"updated_at" timestamp(6) NULL,
	"deleted_at" timestamp(6) NULL,
	"coordinates" "public"."geometry"
)
WITH (OIDS=FALSE);
ALTER TABLE "public"."student" OWNER TO "justnero";
DROP TABLE IF EXISTS "public"."teacher";
CREATE TABLE "public"."teacher" (
	"id" int8 NOT NULL,
	"name" varchar(255) NOT NULL COLLATE "default",
	"email" varchar(255) COLLATE "default",
	"phone" varchar(255) COLLATE "default",
	"address" varchar(255) COLLATE "default",
	"created_at" timestamp(6) NULL,
	"updated_at" timestamp(6) NULL,
	"deleted_at" timestamp(6) NULL
)
WITH (OIDS=FALSE);
ALTER TABLE "public"."teacher" OWNER TO "justnero";
DROP TABLE IF EXISTS "public"."university";
CREATE TABLE "public"."university" (
	"id" int8 NOT NULL,
	"name" varchar(255) NOT NULL COLLATE "default",
	"address" varchar(255) COLLATE "default",
	"site" varchar(255) COLLATE "default",
	"email" varchar(255) COLLATE "default",
	"phone" varchar(255) COLLATE "default",
	"created_at" timestamp(6) NULL,
	"updated_at" timestamp(6) NULL,
	"deleted_at" timestamp(6) NULL
)
WITH (OIDS=FALSE);
ALTER TABLE "public"."university" OWNER TO "justnero";
ALTER TABLE "public"."attendance" ADD PRIMARY KEY ("id") NOT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX  "attendance_class_id_fk" ON "public"."attendance" USING btree(class_id "pg_catalog"."int8_ops" ASC NULLS LAST);
CREATE INDEX  "attendance_student_id_fk" ON "public"."attendance" USING btree(student_id "pg_catalog"."int8_ops" ASC NULLS LAST);
ALTER TABLE "public"."cathedra" ADD PRIMARY KEY ("id") NOT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX  "cathedra_institute_id_fk" ON "public"."cathedra" USING btree(institute_id "pg_catalog"."int8_ops" ASC NULLS LAST);
ALTER TABLE "public"."cathedra_teacher" ADD PRIMARY KEY ("cathedra_id", "teacher_id") NOT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX  "cathedra_teacher_teacher_id_fk" ON "public"."cathedra_teacher" USING btree(teacher_id "pg_catalog"."int8_ops" ASC NULLS LAST);
ALTER TABLE "public"."certificate" ADD PRIMARY KEY ("id") NOT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX  "certificate_student_id_fk" ON "public"."certificate" USING btree(student_id "pg_catalog"."int8_ops" ASC NULLS LAST);
ALTER TABLE "public"."class" ADD PRIMARY KEY ("id") NOT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX  "class_discipline_id_fk" ON "public"."class" USING btree(discipline_id "pg_catalog"."int8_ops" ASC NULLS LAST);
CREATE INDEX  "class_group_id_fk" ON "public"."class" USING btree(group_id "pg_catalog"."int8_ops" ASC NULLS LAST);
CREATE INDEX  "class_teacher_id_fk" ON "public"."class" USING btree(teacher_id "pg_catalog"."int8_ops" ASC NULLS LAST);
ALTER TABLE "public"."discipline" ADD PRIMARY KEY ("id") NOT DEFERRABLE INITIALLY IMMEDIATE;
ALTER TABLE "public"."discipline_teacher" ADD PRIMARY KEY ("discipline_id", "teacher_id") NOT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX  "discipline_teacher_teacher_id_fk" ON "public"."discipline_teacher" USING btree(teacher_id "pg_catalog"."int8_ops" ASC NULLS LAST);
ALTER TABLE "public"."group" ADD PRIMARY KEY ("id") NOT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX  "group_cathedra_id_fk" ON "public"."group" USING btree(cathedra_id "pg_catalog"."int8_ops" ASC NULLS LAST);
CREATE INDEX  "group_group_id_fk" ON "public"."group" USING btree(super_id "pg_catalog"."int8_ops" ASC NULLS LAST);
CREATE INDEX  "group_student_id_fk" ON "public"."group" USING btree(steward_id "pg_catalog"."int8_ops" ASC NULLS LAST);
ALTER TABLE "public"."group_student" ADD PRIMARY KEY ("group_id", "student_id") NOT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX  "group_student_student_id_fk" ON "public"."group_student" USING btree(student_id "pg_catalog"."int8_ops" ASC NULLS LAST);
ALTER TABLE "public"."institute" ADD PRIMARY KEY ("id") NOT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX  "institute_university_id_fk" ON "public"."institute" USING btree(university_id "pg_catalog"."int8_ops" ASC NULLS LAST);
ALTER TABLE "public"."student" ADD PRIMARY KEY ("id") NOT DEFERRABLE INITIALLY IMMEDIATE;
ALTER TABLE "public"."teacher" ADD PRIMARY KEY ("id") NOT DEFERRABLE INITIALLY IMMEDIATE;
ALTER TABLE "public"."university" ADD PRIMARY KEY ("id") NOT DEFERRABLE INITIALLY IMMEDIATE;
CREATE UNIQUE INDEX  "university_name_uindex" ON "public"."university" USING btree("name" COLLATE "default" "pg_catalog"."text_ops" ASC NULLS LAST);
ALTER TABLE "public"."attendance" ADD CONSTRAINT "attendance_class_id_fk" FOREIGN KEY ("class_id") REFERENCES "public"."class" ("id") ON UPDATE CASCADE ON DELETE CASCADE NOT DEFERRABLE INITIALLY IMMEDIATE;
ALTER TABLE "public"."attendance" ADD CONSTRAINT "attendance_student_id_fk" FOREIGN KEY ("student_id") REFERENCES "public"."student" ("id") ON UPDATE CASCADE ON DELETE CASCADE NOT DEFERRABLE INITIALLY IMMEDIATE;
ALTER TABLE "public"."cathedra" ADD CONSTRAINT "cathedra_institute_id_fk" FOREIGN KEY ("institute_id") REFERENCES "public"."institute" ("id") ON UPDATE NO ACTION ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;
ALTER TABLE "public"."cathedra_teacher" ADD CONSTRAINT "cathedra_teacher_cathedra_id_fk" FOREIGN KEY ("cathedra_id") REFERENCES "public"."cathedra" ("id") ON UPDATE CASCADE ON DELETE CASCADE NOT DEFERRABLE INITIALLY IMMEDIATE;
ALTER TABLE "public"."cathedra_teacher" ADD CONSTRAINT "cathedra_teacher_teacher_id_fk" FOREIGN KEY ("teacher_id") REFERENCES "public"."teacher" ("id") ON UPDATE CASCADE ON DELETE CASCADE NOT DEFERRABLE INITIALLY IMMEDIATE;
ALTER TABLE "public"."certificate" ADD CONSTRAINT "certificate_student_id_fk" FOREIGN KEY ("student_id") REFERENCES "public"."student" ("id") ON UPDATE CASCADE ON DELETE CASCADE NOT DEFERRABLE INITIALLY IMMEDIATE;
ALTER TABLE "public"."class" ADD CONSTRAINT "class_discipline_id_fk" FOREIGN KEY ("discipline_id") REFERENCES "public"."discipline" ("id") ON UPDATE CASCADE ON DELETE CASCADE NOT DEFERRABLE INITIALLY IMMEDIATE;
ALTER TABLE "public"."class" ADD CONSTRAINT "class_group_id_fk" FOREIGN KEY ("group_id") REFERENCES "public"."group" ("id") ON UPDATE CASCADE ON DELETE CASCADE NOT DEFERRABLE INITIALLY IMMEDIATE;
ALTER TABLE "public"."class" ADD CONSTRAINT "class_teacher_id_fk" FOREIGN KEY ("teacher_id") REFERENCES "public"."teacher" ("id") ON UPDATE CASCADE ON DELETE SET NULL NOT DEFERRABLE INITIALLY IMMEDIATE;
ALTER TABLE "public"."discipline_teacher" ADD CONSTRAINT "discipline_teacher_discipline_id_fk" FOREIGN KEY ("discipline_id") REFERENCES "public"."discipline" ("id") ON UPDATE CASCADE ON DELETE CASCADE NOT DEFERRABLE INITIALLY IMMEDIATE;
ALTER TABLE "public"."discipline_teacher" ADD CONSTRAINT "discipline_teacher_teacher_id_fk" FOREIGN KEY ("teacher_id") REFERENCES "public"."teacher" ("id") ON UPDATE CASCADE ON DELETE CASCADE NOT DEFERRABLE INITIALLY IMMEDIATE;
ALTER TABLE "public"."group" ADD CONSTRAINT "group_cathedra_id_fk" FOREIGN KEY ("cathedra_id") REFERENCES "public"."cathedra" ("id") ON UPDATE CASCADE ON DELETE SET NULL NOT DEFERRABLE INITIALLY IMMEDIATE;
ALTER TABLE "public"."group" ADD CONSTRAINT "group_group_id_fk" FOREIGN KEY ("super_id") REFERENCES "public"."group" ("id") ON UPDATE CASCADE ON DELETE CASCADE NOT DEFERRABLE INITIALLY IMMEDIATE;
ALTER TABLE "public"."group" ADD CONSTRAINT "group_student_id_fk" FOREIGN KEY ("steward_id") REFERENCES "public"."student" ("id") ON UPDATE CASCADE ON DELETE SET NULL NOT DEFERRABLE INITIALLY IMMEDIATE;
ALTER TABLE "public"."group_student" ADD CONSTRAINT "group_student_group_id_fk" FOREIGN KEY ("group_id") REFERENCES "public"."group" ("id") ON UPDATE CASCADE ON DELETE CASCADE NOT DEFERRABLE INITIALLY IMMEDIATE;
ALTER TABLE "public"."group_student" ADD CONSTRAINT "group_student_student_id_fk" FOREIGN KEY ("student_id") REFERENCES "public"."student" ("id") ON UPDATE CASCADE ON DELETE CASCADE NOT DEFERRABLE INITIALLY IMMEDIATE;
ALTER TABLE "public"."institute" ADD CONSTRAINT "institute_university_id_fk" FOREIGN KEY ("university_id") REFERENCES "public"."university" ("id") ON UPDATE CASCADE ON DELETE CASCADE NOT DEFERRABLE INITIALLY IMMEDIATE;