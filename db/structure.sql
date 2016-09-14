CREATE TABLE "schema_migrations" ("version" varchar NOT NULL);
CREATE UNIQUE INDEX "unique_schema_migrations" ON "schema_migrations" ("version");
CREATE TABLE "users" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "email" varchar DEFAULT '' NOT NULL, "encrypted_password" varchar DEFAULT '' NOT NULL, "reset_password_token" varchar, "reset_password_sent_at" datetime, "remember_created_at" datetime, "sign_in_count" integer DEFAULT 0 NOT NULL, "current_sign_in_at" datetime, "last_sign_in_at" datetime, "current_sign_in_ip" varchar, "last_sign_in_ip" varchar, "confirmation_token" varchar, "confirmed_at" datetime, "confirmation_sent_at" datetime, "unconfirmed_email" varchar, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL, "login" varchar, "first_name" varchar, "last_name" varchar, "is_superuser" boolean);
CREATE UNIQUE INDEX "index_users_on_email" ON "users" ("email");
CREATE UNIQUE INDEX "index_users_on_reset_password_token" ON "users" ("reset_password_token");
CREATE TABLE "projects" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "title" varchar, "description" text, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL, "manager_id" integer);
CREATE TABLE "teams" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "project_id" integer, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE INDEX "index_teams_on_project_id" ON "teams" ("project_id");
CREATE TABLE "team_members" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "user_id" integer, "team_id" integer, "is_admin" boolean, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE INDEX "index_team_members_on_user_id" ON "team_members" ("user_id");
CREATE INDEX "index_team_members_on_team_id" ON "team_members" ("team_id");
CREATE TABLE "bugs" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "title" varchar, "description" text, "state" integer, "project_id" integer, "creator_id" integer, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL, "severity" integer, "screenshot" varchar);
CREATE INDEX "index_bugs_on_project_id" ON "bugs" ("project_id");
CREATE TABLE "tasks" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "title" varchar, "description" text, "state" integer DEFAULT 0, "progress" integer DEFAULT 0, "developer_id" integer, "project_id" integer, "deadline" date, "finished_at" datetime, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE INDEX "index_tasks_on_project_id" ON "tasks" ("project_id");
CREATE TABLE "bugs_tasks" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "bug_id" integer, "task_id" integer);
CREATE INDEX "index_bugs_tasks_on_bug_id" ON "bugs_tasks" ("bug_id");
CREATE INDEX "index_bugs_tasks_on_task_id" ON "bugs_tasks" ("task_id");
INSERT INTO schema_migrations (version) VALUES ('20160822105035');

INSERT INTO schema_migrations (version) VALUES ('20160822113436');

INSERT INTO schema_migrations (version) VALUES ('20160822114740');

INSERT INTO schema_migrations (version) VALUES ('20160822124302');

INSERT INTO schema_migrations (version) VALUES ('20160822124303');

INSERT INTO schema_migrations (version) VALUES ('20160822124548');

INSERT INTO schema_migrations (version) VALUES ('20160822124953');

INSERT INTO schema_migrations (version) VALUES ('20160822125553');

INSERT INTO schema_migrations (version) VALUES ('20160822130042');

INSERT INTO schema_migrations (version) VALUES ('20160822134951');

INSERT INTO schema_migrations (version) VALUES ('20160822180148');

