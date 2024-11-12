BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "user_roles" (
	"id"	integer,
	"created_at"	datetime,
	"updated_at"	datetime,
	"deleted_at"	datetime,
	"role_name"	text,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "genders" (
	"id"	integer,
	"created_at"	datetime,
	"updated_at"	datetime,
	"deleted_at"	datetime,
	"gender"	text,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "users" (
	"id"	integer,
	"created_at"	datetime,
	"updated_at"	datetime,
	"deleted_at"	datetime,
	"username"	text,
	"password"	text,
	"email"	text,
	"first_name"	text,
	"last_name"	text,
	"birthday"	datetime,
	"profile"	text,
	"user_role_id"	integer,
	"gender_id"	integer,
	PRIMARY KEY("id" AUTOINCREMENT),
	CONSTRAINT "fk_user_roles_users" FOREIGN KEY("user_role_id") REFERENCES "user_roles"("id"),
	CONSTRAINT "fk_genders_users" FOREIGN KEY("gender_id") REFERENCES "genders"("id")
);
CREATE TABLE IF NOT EXISTS "bookings" (
	"id"	integer,
	"created_at"	datetime,
	"updated_at"	datetime,
	"deleted_at"	datetime,
	"booking_date"	datetime,
	"all_price"	real,
	"user_id"	integer,
	PRIMARY KEY("id" AUTOINCREMENT),
	CONSTRAINT "fk_users_booking" FOREIGN KEY("user_id") REFERENCES "users"("id")
);
CREATE TABLE IF NOT EXISTS "employees" (
	"id"	integer,
	"created_at"	datetime,
	"updated_at"	datetime,
	"deleted_at"	datetime,
	"bio"	text,
	"experience"	text,
	"education"	text,
	"salary"	real,
	"full_time"	numeric,
	"user_id"	integer,
	PRIMARY KEY("id" AUTOINCREMENT),
	CONSTRAINT "fk_users_employee" FOREIGN KEY("user_id") REFERENCES "users"("id")
);
CREATE TABLE IF NOT EXISTS "ticket_generations" (
	"id"	integer,
	"created_at"	datetime,
	"updated_at"	datetime,
	"deleted_at"	datetime,
	"generation"	text,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "ticket_types" (
	"id"	integer,
	"created_at"	datetime,
	"updated_at"	datetime,
	"deleted_at"	datetime,
	"ticket_type"	text,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "tickets" (
	"id"	integer,
	"created_at"	datetime,
	"updated_at"	datetime,
	"deleted_at"	datetime,
	"description"	text,
	"price"	real,
	"ticket_generation_id"	integer,
	"ticket_type_id"	integer,
	PRIMARY KEY("id" AUTOINCREMENT),
	CONSTRAINT "fk_tickets_ticket_type" FOREIGN KEY("ticket_type_id") REFERENCES "ticket_types"("id"),
	CONSTRAINT "fk_ticket_generations_tickets" FOREIGN KEY("ticket_generation_id") REFERENCES "ticket_generations"("id")
);
CREATE TABLE IF NOT EXISTS "ticket_bookings" (
	"id"	integer,
	"created_at"	datetime,
	"updated_at"	datetime,
	"deleted_at"	datetime,
	"visit_date"	datetime,
	"quantity_customer"	integer,
	"total_price"	real,
	"checking"	numeric,
	"ticket_id"	integer,
	"booking_id"	integer,
	CONSTRAINT "fk_bookings_ticket_bookings" FOREIGN KEY("booking_id") REFERENCES "bookings"("id"),
	PRIMARY KEY("id" AUTOINCREMENT),
	CONSTRAINT "fk_tickets_ticket_bookings" FOREIGN KEY("ticket_id") REFERENCES "tickets"("id")
);
CREATE TABLE IF NOT EXISTS "vehicle_types" (
	"id"	integer,
	"created_at"	datetime,
	"updated_at"	datetime,
	"deleted_at"	datetime,
	"vehicle_type"	text,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "vehicles" (
	"id"	integer,
	"created_at"	datetime,
	"updated_at"	datetime,
	"deleted_at"	datetime,
	"received_date"	datetime,
	"avaliability_status"	text,
	"price"	real,
	"picture"	text,
	"vehicle_type_id"	integer,
	"employee_id"	integer,
	CONSTRAINT "fk_employees_vehicles" FOREIGN KEY("employee_id") REFERENCES "employees"("id"),
	CONSTRAINT "fk_vehicle_types_vehicles" FOREIGN KEY("vehicle_type_id") REFERENCES "vehicle_types"("id"),
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "rents" (
	"id"	integer,
	"created_at"	datetime,
	"updated_at"	datetime,
	"deleted_at"	datetime,
	"quantity"	text,
	"rent_date"	datetime,
	"start_date"	datetime,
	"end_date"	datetime,
	"total_price"	real,
	"vehicle_id"	integer,
	"ticket_booking_id"	integer,
	CONSTRAINT "fk_vehicles_rents" FOREIGN KEY("vehicle_id") REFERENCES "vehicles"("id"),
	CONSTRAINT "fk_ticket_bookings_rents" FOREIGN KEY("ticket_booking_id") REFERENCES "ticket_bookings"("id"),
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "zones" (
	"id"	integer,
	"created_at"	datetime,
	"updated_at"	datetime,
	"deleted_at"	datetime,
	"zone"	text,
	"description"	text,
	"picture"	text,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "zone_ticket_types" (
	"zone_id"	integer,
	"ticket_type_id"	integer,
	CONSTRAINT "fk_zone_ticket_types_zone" FOREIGN KEY("zone_id") REFERENCES "zones"("id"),
	CONSTRAINT "fk_zone_ticket_types_ticket_type" FOREIGN KEY("ticket_type_id") REFERENCES "ticket_types"("id"),
	PRIMARY KEY("zone_id","ticket_type_id")
);
CREATE INDEX IF NOT EXISTS "idx_user_roles_deleted_at" ON "user_roles" (
	"deleted_at"
);
CREATE INDEX IF NOT EXISTS "idx_genders_deleted_at" ON "genders" (
	"deleted_at"
);
CREATE INDEX IF NOT EXISTS "idx_users_deleted_at" ON "users" (
	"deleted_at"
);
CREATE INDEX IF NOT EXISTS "idx_bookings_deleted_at" ON "bookings" (
	"deleted_at"
);
CREATE INDEX IF NOT EXISTS "idx_employees_deleted_at" ON "employees" (
	"deleted_at"
);
CREATE INDEX IF NOT EXISTS "idx_ticket_generations_deleted_at" ON "ticket_generations" (
	"deleted_at"
);
CREATE INDEX IF NOT EXISTS "idx_ticket_types_deleted_at" ON "ticket_types" (
	"deleted_at"
);
CREATE INDEX IF NOT EXISTS "idx_tickets_deleted_at" ON "tickets" (
	"deleted_at"
);
CREATE INDEX IF NOT EXISTS "idx_ticket_bookings_deleted_at" ON "ticket_bookings" (
	"deleted_at"
);
CREATE INDEX IF NOT EXISTS "idx_vehicle_types_deleted_at" ON "vehicle_types" (
	"deleted_at"
);
CREATE INDEX IF NOT EXISTS "idx_vehicles_deleted_at" ON "vehicles" (
	"deleted_at"
);
CREATE INDEX IF NOT EXISTS "idx_rents_deleted_at" ON "rents" (
	"deleted_at"
);
CREATE INDEX IF NOT EXISTS "idx_zones_deleted_at" ON "zones" (
	"deleted_at"
);
COMMIT;
