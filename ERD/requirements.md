## Entities and Relationships in ER Diagram
![image alt](https://github.com/Fmukanda/-alx-airbnb-database/blob/a1eccdd17a62e0dceb1b0612311a946ea218847a/ERD/ERD%20Diagram.drawio.png)
## Database Schema 
```
  CREATE TABLE "user" (
      user_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
      first_name VARCHAR(255) NOT NULL,
      last_name VARCHAR(255) NOT NULL,
      email VARCHAR(255) UNIQUE NOT NULL,
      password_hash VARCHAR(255) NOT NULL,
      phone_number VARCHAR(20) NULL,
      role user_role NOT NULL,
      created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
  );

  CREATE TABLE property (
      property_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
      host_id UUID NOT NULL,
      name VARCHAR(255) NOT NULL,
      description TEXT NOT NULL,
      location VARCHAR(255) NOT NULL,
      pricepernight DECIMAL(10, 2) NOT NULL CHECK (pricepernight >= 0),
      created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
      updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
      FOREIGN KEY (host_id) REFERENCES "user"(user_id) ON DELETE CASCADE
  );

  CREATE TABLE booking (
      booking_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
      property_id UUID NOT NULL,
      user_id UUID NOT NULL,
      start_date DATE NOT NULL,
      end_date DATE NOT NULL,
      total_price DECIMAL(10, 2) NOT NULL CHECK (total_price >= 0),
      status booking_status NOT NULL,
      created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
      FOREIGN KEY (property_id) REFERENCES property(property_id) ON DELETE CASCADE,
      FOREIGN KEY (user_id) REFERENCES "user"(user_id) ON DELETE CASCADE,
      CHECK (start_date < end_date)
  );

  CREATE TABLE payment (
      payment_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
      booking_id UUID NOT NULL UNIQUE,
      amount DECIMAL(10, 2) NOT NULL CHECK (amount >= 0),
      payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
      payment_method payment_method_type NOT NULL,
      FOREIGN KEY (booking_id) REFERENCES booking(booking_id) ON DELETE CASCADE
  );

  CREATE TABLE review (
      review_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
      property_id UUID NOT NULL,
      user_id UUID NOT NULL,
      rating INTEGER NOT NULL CHECK (rating >= 1 AND rating <= 5),
      comment TEXT NOT NULL,
      created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
      FOREIGN KEY (property_id) REFERENCES property(property_id) ON DELETE CASCADE,
      FOREIGN KEY (user_id) REFERENCES "user"(user_id) ON DELETE CASCADE
  );

  CREATE TABLE message (
      message_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
      sender_id UUID NOT NULL,
      recipient_id UUID NOT NULL,
      message_body TEXT NOT NULL,
      sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
      FOREIGN KEY (sender_id) REFERENCES "user"(user_id) ON DELETE CASCADE,
      FOREIGN KEY (recipient_id) REFERENCES "user"(user_id) ON DELETE CASCADE
  );
```
## Database with Sample Data
```
    -- Insert Users
    INSERT INTO "user" (user_id, first_name, last_name, email, password_hash, phone_number, role) VALUES
    (john_id, 'John', 'Kimathi', 'john.kimathi@email.com', '$2b$10$examplehash123', '+254-555-0101', 'host'),
    (sarah_id, 'Sarah', 'Wafula', 'sarah.w@email.com', '$2b$10$examplehash456', '+254-555-0102', 'host'),
    (mike_id, 'Mike', 'Nyakundi', 'mike.nyak@email.com', '$2b$10$examplehash789', '+254-555-0103', 'guest'),
    (lisa_id, 'Lisa', 'Kendi', 'lisa.k@email.com', '$2b$10$examplehashabc', '+254-555-0104', 'guest'),
    (david_id, 'David', 'Kimani', 'david.kim@email.com', '$2b$10$examplehashdef', NULL, 'guest');

    -- Insert Properties
    INSERT INTO property (property_id, host_id, name, description, location, pricepernight) VALUES
    (cabin_id, john_id, 'Cozy Mountain Cabin', 'Beautiful cabin with mountain views', 'Aspen, Colorado', 150.00),
    (loft_id, john_id, 'Downtown Loft', 'Modern loft in the heart of the city', 'Denver, Colorado', 120.00),
    (villa_id, sarah_id, 'Beachfront Villa', 'Stunning beachfront property', 'Miami, Florida', 250.00);

    -- Insert Bookings
    INSERT INTO booking (booking_id, property_id, user_id, start_date, end_date, status) VALUES
    (booking1_id, cabin_id, mike_id, '2024-03-15', '2024-03-20', 'completed'),
    (booking2_id, villa_id, lisa_id, '2024-04-01', '2024-04-07', 'confirmed'),
    (booking3_id, loft_id, david_id, '2024-05-10', '2024-05-12', 'pending');

    -- Insert Payments
    INSERT INTO payment (payment_id, booking_id, amount, payment_method) VALUES
    (payment1_id, booking1_id, 750.00, 'credit_card'),
    (payment2_id, booking2_id, 1500.00, 'mpesa');

    -- Insert Reviews
    INSERT INTO review (review_id, property_id, user_id, rating, comment) VALUES
    (review1_id, cabin_id, mike_id, 5, 'Absolutely amazing cabin!'),
    (review2_id, cabin_id, lisa_id, 4, 'Lovely cabin with great amenities.');

    -- Insert Messages
    INSERT INTO message (message_id, sender_id, recipient_id, message_body) VALUES
    (message1_id, mike_id, john_id, 'Hi John, I''m interested in your mountain cabin.'),
    (message2_id, john_id, mike_id, 'Hi Mike! Yes, those dates are available.'),
    (message3_id, lisa_id, sarah_id, 'Hello Sarah, I have a question about the beach villa.');
```
