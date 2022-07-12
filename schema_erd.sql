/* Database schema to keep the structure of entire database. */

CREATE DATABASE schema_based_on_diagram;

/* Add patients table to clinic database. */

CREATE TABLE IF NOT EXISTS patients(
 id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
 name VARCHAR(255),
 date_of_birth DATE

);

/* Add medical_histories table to clinic database. */
CREATE TABLE IF NOT EXISTS medical_histories(
 id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
 admitted_at timestamp,
 patient_id int REFERENCES patients(id),
 status varchar(255)

);
/* Add treatments table to clinic database. */

CREATE TABLE IF NOT EXISTS treatments(
 id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
 type varchar(255),
 name VARCHAR(255)

);

/* Add  invoices table to clinic database. */

CREATE TABLE IF NOT EXISTS invoices (
id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    total_amount decimal,
    generated_at decimal,
    payed_at timestamp,
    medical_history__id int REFERENCES medical_histories(id),
);

/* Add  invoice_items table to clinic database. */

CREATE TABLE IF NOT EXISTS invoice_items (
id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    unique_price decimal,
    quantity int,
    total_price decimal,
    invoice_id int REFERENCES invoices(id),
    treatment_id int REFERENCES treatments(id)
);
