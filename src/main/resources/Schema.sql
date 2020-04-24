CREATE TABLE attendees
(
    attendee_id  SERIAL PRIMARY KEY,
    first_name   VARCHAR(30) NOT NULL,
    last_name    VARCHAR(30) NOT NULL,
    title        VARCHAR(40) NULL,
    company      VARCHAR(50) NULL,
    email        VARCHAR(80) NOT NULL,
    phone_number VARCHAR(20) NULL
);

CREATE TABLE ticket_types
(
    ticket_type_code  VARCHAR(1) PRIMARY KEY,
    ticket_type_name  VARCHAR(30)  NOT NULL,
    description       VARCHAR(100) NOT NULL,
    includes_workshop BOOLEAN      NOT NULL
);

CREATE TABLE pricing_categories
(
    pricing_category_code VARCHAR(1) PRIMARY KEY,
    pricing_category_name VARCHAR(20) NOT NULL,
    pricing_start_date    DATE        NOT NULL,
    pricing_end_date      DATE        NOT NULL
);

CREATE TABLE ticket_prices
(
    ticket_price_id       SERIAL PRIMARY KEY,
    ticket_type_code      VARCHAR(1)    NOT NULL REFERENCES ticket_types (ticket_type_code),
    pricing_category_code VARCHAR(1)    NOT NULL REFERENCES pricing_categories (pricing_category_code),
    base_price            NUMERIC(8, 2) NOT NULL
);

CREATE TABLE discount_codes
(
    discount_code_id SERIAL PRIMARY KEY,
    discount_code    VARCHAR(20)   NOT NULL,
    discount_name    VARCHAR(30)   NOT NULL,
    discount_type    VARCHAR(1)    NOT NULL,
    discount_amount  numeric(8, 2) NOT NULL
);

CREATE TABLE attendee_tickets
(
    attendee_ticket_id SERIAL PRIMARY KEY,
    attendee_id        INT       NOT NULL REFERENCES attendees (attendee_id),
    ticket_price_id    INT       NOT NULL REFERENCES ticket_prices (ticket_price_id),
    discount_code_id   INT       NULL REFERENCES discount_codes (discount_code_id),
    net_price          numeric(8, 2) NOT NULL
);

CREATE TABLE time_slots
(
    time_slot_id         SERIAL PRIMARY KEY,
    time_slot_date       DATE                   NOT NULL,
    start_time           TIME  					NOT NULL,
    end_time             TIME  					NOT NULL,
    is_keynote_time_slot boolean default false  NOT NULL
);

CREATE TABLE sessions
(
    session_id          SERIAL PRIMARY KEY,
    session_name        VARCHAR(80)   NOT NULL,
    session_description VARCHAR(1024) NOT NULL,
    session_length      INT       NOT NULL
);

CREATE TABLE session_schedule
(
    schedule_id  SERIAL PRIMARY KEY,
    time_slot_id INT     NOT NULL REFERENCES time_slots (time_slot_id),
    session_id   INT     NOT NULL REFERENCES sessions (session_id),
    room         VARCHAR(30) NOT NULL
);

CREATE TABLE tags
(
    tag_id      SERIAL PRIMARY KEY,
    description VARCHAR(30) NOT NULL
);

CREATE TABLE session_tags
(
    session_id INT NOT NULL REFERENCES sessions (session_id),
    tag_id     INT NOT NULL REFERENCES tags (tag_id)
);

CREATE TABLE speakers
(
    speaker_id    SERIAL PRIMARY KEY,
    first_name    VARCHAR(30)   NOT NULL,
    last_name     VARCHAR(30)   NOT NULL,
    title         VARCHAR(40)   NOT NULL,
    company       VARCHAR(50)   NOT NULL,
    speaker_bio   VARCHAR(2000) NOT NULL,
    speaker_photo BLOB   		NULL
);

CREATE TABLE session_speakers
(
    session_id INT NOT NULL REFERENCES sessions (session_id),
    speaker_id INT NOT NULL REFERENCES speakers (speaker_id)
);

CREATE TABLE workshops
(
    workshop_id   SERIAL PRIMARY KEY,
    workshop_name VARCHAR(60)   NOT NULL,
    description   VARCHAR(1024) NOT NULL,
    requirements  VARCHAR(1024) NOT NULL,
    room          VARCHAR(30)   NOT NULL,
    capacity      INT       NOT NULL
);

CREATE TABLE workshop_speakers
(
    workshop_id INT NOT NULL REFERENCES workshops (workshop_id),
    speaker_id  INT NOT NULL REFERENCES speakers (speaker_id)
);

CREATE TABLE workshop_registrations
(
    workshop_id        INT NOT NULL REFERENCES workshops (workshop_id),
    attendee_ticket_id INT NOT NULL REFERENCES attendee_tickets (attendee_ticket_id)
);