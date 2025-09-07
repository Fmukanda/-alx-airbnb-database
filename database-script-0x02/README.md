
# Sample Data Population for Property Booking Platform

-- ==================================================
-- Users
-- ==================================================
INSERT INTO "user" (user_id, first_name, last_name, email, password_hash, phone_number, role)
VALUES
    (uuid_generate_v4(), 'Alice', 'Johnson', 'alice@example.com', 'hashed_password1', '+254700111222', 'host'),
    (uuid_generate_v4(), 'Bob', 'Smith', 'bob@example.com', 'hashed_password2', '+254700333444', 'guest'),
    (uuid_generate_v4(), 'Carol', 'Davis', 'carol@example.com', 'hashed_password3', '+254700555666', 'guest'),
    (uuid_generate_v4(), 'David', 'Miller', 'david@example.com', 'hashed_password4', '+254700777888', 'host');

-- ==================================================
-- Properties
-- (Assuming Alice and David are hosts)
-- ==================================================
INSERT INTO property (property_id, host_id, name, description, location, pricepernight)
VALUES
    (uuid_generate_v4(), (SELECT user_id FROM "user" WHERE email='alice@example.com'),
        'Seaside Villa', 'A beautiful villa by the ocean.', 'Mombasa, Kenya', 120.00),
    (uuid_generate_v4(), (SELECT user_id FROM "user" WHERE email='david@example.com'),
        'City Apartment', 'Modern apartment in the city center.', 'Nairobi, Kenya', 80.00);

-- ==================================================
-- Bookings
-- (Bob and Carol booking Alice’s and David’s properties)
-- ==================================================
INSERT INTO booking (booking_id, property_id, user_id, start_date, end_date, total_price, status)
VALUES
    (uuid_generate_v4(),
        (SELECT property_id FROM property WHERE name='Seaside Villa'),
        (SELECT user_id FROM "user" WHERE email='bob@example.com'),
        '2025-09-15', '2025-09-20', 600.00, 'confirmed'),
    (uuid_generate_v4(),
        (SELECT property_id FROM property WHERE name='City Apartment'),
        (SELECT user_id FROM "user" WHERE email='carol@example.com'),
        '2025-10-01', '2025-10-05', 320.00, 'pending');

-- ==================================================
-- Payments
-- (Bob completed payment, Carol has not yet paid)
-- ==================================================
INSERT INTO payment (payment_id, booking_id, amount, payment_method)
VALUES
    (uuid_generate_v4(),
        (SELECT booking_id FROM booking WHERE total_price=600.00),
        600.00, 'credit_card');

-- ==================================================
-- Reviews
-- ==================================================
INSERT INTO review (review_id, property_id, user_id, rating, comment)
VALUES
    (uuid_generate_v4(),
        (SELECT property_id FROM property WHERE name='Seaside Villa'),
        (SELECT user_id FROM "user" WHERE email='bob@example.com'),
        5, 'Amazing stay! The villa was clean and right by the ocean.'),
    (uuid_generate_v4(),
        (SELECT property_id FROM property WHERE name='City Apartment'),
        (SELECT user_id FROM "user" WHERE email='carol@example.com'),
        4, 'Great location and very comfortable apartment.');

-- ==================================================
-- Messages
-- (Guests messaging hosts)
-- ==================================================
INSERT INTO message (message_id, sender_id, recipient_id, message_body)
VALUES
    (uuid_generate_v4(),
        (SELECT user_id FROM "user" WHERE email='bob@example.com'),
        (SELECT user_id FROM "user" WHERE email='alice@example.com'),
        'Hi Alice, is the villa available for early check-in?'),
    (uuid_generate_v4(),
        (SELECT user_id FROM "user" WHERE email='carol@example.com'),
        (SELECT user_id FROM "user" WHERE email='david@example.com'),
        'Hello David, is parking available at the apartment?');

