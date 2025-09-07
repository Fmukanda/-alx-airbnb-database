-- Sample Data Population Script

-- Insert sample users
INSERT INTO "user" (user_id, first_name, last_name, email, password_hash, phone_number, role, created_at) VALUES
-- Hosts
('a1b2c3d4-e5f6-7890-abcd-ef1234567890', 'Sarah', 'Johnson', 'sarah.johnson@email.com', '$2b$10$examplehash1234567890abcd', '+1-555-0101', 'host', '2023-01-15 09:30:00'),
('b2c3d4e5-f6g7-8901-bcde-f23456789012', 'Michael', 'Chen', 'michael.chen@email.com', '$2b$10$examplehash234567890abcd', '+1-555-0102', 'host', '2023-02-10 14:20:00'),
('c3d4e5f6-g7h8-9012-cdef-345678901234', 'Emily', 'Rodriguez', 'emily.rodriguez@email.com', '$2b$10$examplehash34567890abcd', '+1-555-0103', 'host', '2023-03-05 11:45:00'),

-- Guests
('d4e5f6g7-h8i9-0123-defg-456789012345', 'David', 'Kim', 'david.kim@email.com', '$2b$10$examplehash4567890abcd', '+1-555-0104', 'guest', '2023-01-20 16:15:00'),
('e5f6g7h8-i9j0-1234-efgh-567890123456', 'Jessica', 'Wang', 'jessica.wang@email.com', '$2b$10$examplehash567890abcd', '+1-555-0105', 'guest', '2023-02-15 10:30:00'),
('f6g7h8i9-j0k1-2345-fghi-678901234567', 'James', 'Taylor', 'james.taylor@email.com', '$2b$10$examplehash67890abcd', '+1-555-0106', 'guest', '2023-03-10 13:45:00'),

-- Admin
('g7h8i9j0-k1l2-3456-ghij-789012345678', 'Admin', 'User', 'admin@vacationrental.com', '$2b$10$adminhash1234567890abcd', '+1-555-0000', 'admin', '2023-01-01 08:00:00');

-- Insert sample properties
INSERT INTO property (property_id, host_id, name, description, location, pricepernight, created_at, updated_at) VALUES
-- Sarah's properties
('p1a2b3c4-d5e6-7890-abcd-ef1234567890', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', 'Beachfront Paradise', 'Stunning beachfront villa with private pool and ocean views. Perfect for romantic getaways or family vacations.', 'Miami Beach, FL', 350.00, '2023-01-20 10:00:00', '2023-01-20 10:00:00'),
('p2b3c4d5-e6f7-8901-bcde-f23456789012', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', 'Downtown Luxury Loft', 'Modern loft in the heart of downtown with panoramic city views and premium amenities.', 'New York, NY', 275.00, '2023-02-05 14:30:00', '2023-02-05 14:30:00'),

-- Michael's properties
('p3c4d5e6-f7g8-9012-cdef-345678901234', 'b2c3d4e5-f6g7-8901-bcde-f23456789012', 'Mountain Retreat Cabin', 'Cozy log cabin nestled in the mountains with fireplace and hiking trails access.', 'Aspen, CO', 195.00, '2023-02-12 09:15:00', '2023-02-12 09:15:00'),
('p4d5e6f7-g8h9-0123-defg-456789012345', 'b2c3d4e5-f6g7-8901-bcde-f23456789012', 'City Center Apartment', 'Convenient apartment near public transportation and major attractions. Perfect for urban explorers.', 'Chicago, IL', 125.00, '2023-03-01 16:45:00', '2023-03-01 16:45:00'),

-- Emily's properties
('p5e6f7g8-h9i0-1234-efgh-567890123456', 'c3d4e5f6-g7h8-9012-cdef-345678901234', 'Lakeside Cottage', 'Charming cottage on a peaceful lake with fishing dock and canoe included.', 'Lake Tahoe, CA', 220.00, '2023-03-08 11:20:00', '2023-03-08 11:20:00'),
('p6f7g8h9-i0j1-2345-fghi-678901234567', 'c3d4e5f6-g7h8-9012-cdef-345678901234', 'Desert Oasis Villa', 'Luxurious villa with private pool in the desert, featuring stunning sunset views.', 'Palm Springs, CA', 310.00, '2023-03-20 13:10:00', '2023-03-20 13:10:00');

-- Insert sample bookings
INSERT INTO booking (booking_id, property_id, user_id, start_date, end_date, total_price, status, created_at) VALUES
-- David's bookings
('b1a2b3c4-d5e6-7890-abcd-ef1234567890', 'p1a2b3c4-d5e6-7890-abcd-ef1234567890', 'd4e5f6g7-h8i9-0123-defg-456789012345', '2023-06-15', '2023-06-22', 2450.00, 'completed', '2023-05-10 08:30:00'),
('b2c3d4e5-f6g7-8901-bcde-f23456789012', 'p3c4d5e6-f7g8-9012-cdef-345678901234', 'd4e5f6g7-h8i9-0123-defg-456789012345', '2023-08-10', '2023-08-15', 975.00, 'confirmed', '2023-07-01 14:20:00'),

-- Jessica's bookings
('b3d4e5f6-g7h8-9012-cdef-345678901234', 'p2b3c4d5-e6f7-8901-bcde-f23456789012', 'e5f6g7h8-i9j0-1234-efgh-567890123456', '2023-07-01', '2023-07-05', 1100.00, 'completed', '2023-06-15 10:45:00'),
('b4e5f6g7-h8i9-0123-defg-456789012345', 'p5e6f7g8-h9i0-1234-efgh-567890123456', 'e5f6g7h8-i9j0-1234-efgh-567890123456', '2023-09-20', '2023-09-25', 1100.00, 'pending', '2023-08-28 16:30:00'),

-- James's bookings
('b5f6g7h8-i9j0-1234-efgh-567890123456', 'p6f7g8h9-i0j1-2345-fghi-678901234567', 'f6g7h8i9-j0k1-2345-fghi-678901234567', '2023-07-20', '2023-07-27', 2170.00, 'completed', '2023-06-25 09:15:00'),
('b6g7h8i9-j0k1-2345-fghi-678901234567', 'p4d5e6f7-g8h9-0123-defg-456789012345', 'f6g7h8i9-j0k1-2345-fghi-678901234567', '2023-10-05', '2023-10-08', 375.00, 'confirmed', '2023-09-10 11:40:00');

-- Insert sample payments
INSERT INTO payment (payment_id, booking_id, amount, payment_date, payment_method) VALUES
('pay1a2b3c4-d5e6-7890-abcd-ef1234567890', 'b1a2b3c4-d5e6-7890-abcd-ef1234567890', 2450.00, '2023-05-10 09:00:00', 'credit_card'),
('pay2c3d4e5-f6g7-8901-bcde-f23456789012', 'b2c3d4e5-f6g7-8901-bcde-f23456789012', 975.00, '2023-07-01 14:30:00', 'paypal'),
('pay3d4e5f6-g7h8-9012-cdef-345678901234', 'b3d4e5f6-g7h8-9012-cdef-345678901234', 1100.00, '2023-06-15 11:00:00', 'debit_card'),
('pay5f6g7h8-i9j0-1234-efgh-567890123456', 'b5f6g7h8-i9j0-1234-efgh-567890123456', 2170.00, '2023-06-25 09:30:00', 'credit_card'),
('pay6g7h8i9-j0k1-2345-fghi-678901234567', 'b6g7h8i9-j0k1-2345-fghi-678901234567', 375.00, '2023-09-10 12:00:00', 'bank_transfer');

-- Insert sample reviews
INSERT INTO review (review_id, property_id, user_id, rating, comment, created_at) VALUES
-- Reviews for properties
('rev1a2b3c4-d5e6-7890-abcd-ef1234567890', 'p1a2b3c4-d5e6-7890-abcd-ef1234567890', 'd4e5f6g7-h8i9-0123-defg-456789012345', 5, 'Absolutely stunning property! The ocean views were breathtaking and the amenities were top-notch. Will definitely return!', '2023-06-25 10:00:00'),
('rev2c3d4e5-f6g7-8901-bcde-f23456789012', 'p2b3c4d5-e6f7-8901-bcde-f23456789012', 'e5f6g7h8-i9j0-1234-efgh-567890123456', 4, 'Great location and very comfortable stay. The city views were amazing, and everything was within walking distance.', '2023-07-08 14:30:00'),
('rev3d4e5f6-g7h8-9012-cdef-345678901234', 'p3c4d5e6-f7g8-9012-cdef-345678901234', 'd4e5f6g7-h8i9-0123-defg-456789012345', 5, 'Perfect mountain getaway! The cabin was cozy and had everything we needed. The fireplace made evenings magical.', '2023-08-18 09:15:00'),
('rev4e5f6g7-h8i9-0123-defg-456789012345', 'p6f7g8h9-i0j1-2345-fghi-678901234567', 'f6g7h8i9-j0k1-2345-fghi-678901234567', 5, 'Incredible desert oasis! The private pool was perfect for hot days, and the sunsets were unforgettable. Highly recommend!', '2023-07-30 16:45:00');

-- Insert sample messages
INSERT INTO message (message_id, sender_id, recipient_id, message_body, sent_at) VALUES
-- Messages between guests and hosts
('msg1a2b3c4-d5e6-7890-abcd-ef1234567890', 'd4e5f6g7-h8i9-0123-defg-456789012345', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', 'Hello! I''m interested in your beachfront property for June. Is it available for the 15th-22nd?', '2023-05-05 08:30:00'),
('msg2c3d4e5-f6g7-8901-bcde-f23456789012', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', 'd4e5f6g7-h8i9-0123-defg-456789012345', 'Yes, those dates are available! The property is perfect for a summer getaway.', '2023-05-05 09:15:00'),
('msg3d4e5f6-g7h8-9012-cdef-345678901234', 'e5f6g7h8-i9j0-1234-efgh-567890123456', 'b2c3d4e5-f6g7-8901-bcde-f23456789012', 'Hi! I''d like to book your mountain cabin for a weekend in August. What''s the check-in process?', '2023-07-28 14:20:00'),
('msg4e5f6g7-h8i9-0123-defg-456789012345', 'f6g7h8i9-j0k1-2345-fghi-678901234567', 'c3d4e5f6-g7h8-9012-cdef-345678901234', 'Your desert villa looks amazing! Are pets allowed?', '2023-06-20 10:45:00'),
('msg5f6g7h8-i9j0-1234-efgh-567890123456', 'c3d4e5f6-g7h8-9012-cdef-345678901234', 'f6g7h8i9-j0k1-2345-fghi-678901234567', 'Unfortunately, we don''t allow pets due to the pool area. Sorry about that!', '2023-06-20 11:30:00');

-- Display sample data counts for verification
SELECT 
    (SELECT COUNT(*) FROM "user") as total_users,
    (SELECT COUNT(*) FROM property) as total_properties,
    (SELECT COUNT(*) FROM booking) as total_bookings,
    (SELECT COUNT(*) FROM payment) as total_payments,
    (SELECT COUNT(*) FROM review) as total_reviews,
    (SELECT COUNT(*) FROM message) as total_messages;
