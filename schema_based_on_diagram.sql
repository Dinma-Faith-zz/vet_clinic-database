/* Database schema to keep the structure of entire database. */

CREATE DATABASE schema_based_on_diagram;

/* Add patients table to schema_based_on_diagram database. */

CREATE TABLE patients(
 id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
 name VARCHAR(255),
 date_of_birth DATE

);

/* Add medical_histories table to schema_based_on_diagram database. */
CREATE TABLE medical_histories(
 id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
 admitted_at timestamp,
 patient_id INT REFERENCES patients(id),
 status varchar(255)

);
/* Add treatments table to schema_based_on_diagram database. */

CREATE TABLE treatments(
 id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
 type varchar(255),
 name VARCHAR(255)

);

/* Add  invoices table to schema_based_on_diagram database. */

CREATE TABLE invoices (
id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    total_amount decimal,
    generated_at decimal,
    payed_at timestamp,
    medical_history__id INT REFERENCES medical_histories(id),
);

/* Add  invoice_items table to schema_based_on_diagram database. */

CREATE TABLE invoice_items (
id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    unique_price decimal,
    quantity INT,
    total_price decimal,
    invoice_id INT REFERENCES invoices(id),
    treatment_id INT REFERENCES treatments(id)
);
