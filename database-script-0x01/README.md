# Database Schema for Property Booking Platform

```sql
-- Drop existing tables if they exist (for clean setup)
DROP TABLE IF EXISTS message;
DROP TABLE IF EXISTS review;
DROP TABLE IF EXISTS payment;
DROP TABLE IF EXISTS booking;
DROP TABLE IF EXISTS property;
DROP TABLE IF EXISTS "user";

-- Create custom enum types
CREATE TYPE user_role AS ENUM ('guest', 'host', 'admin');
CREATE TYPE booking_status AS ENUM ('pending', 'confirmed', 'cancelled', 'completed');
CREATE TYPE payment_method_type AS ENUM ('credit_card', 'debit_card', 'paypal', 'bank_transfer');

-- Create user table
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

-- Create property table
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

-- Create booking table
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

-- Create payment table
CREATE TABLE payment (
    payment_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    booking_id UUID NOT NULL UNIQUE,
    amount DECIMAL(10, 2) NOT NULL CHECK (amount >= 0),
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    payment_method payment_method_type NOT NULL,
    FOREIGN KEY (booking_id) REFERENCES booking(booking_id) ON DELETE CASCADE
);

-- Create review table
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

-- Create message table
CREATE TABLE message (
    message_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    sender_id UUID NOT NULL,
    recipient_id UUID NOT NULL,
    message_body TEXT NOT NULL,
    sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (sender_id) REFERENCES "user"(user_id) ON DELETE CASCADE,
    FOREIGN KEY (recipient_id) REFERENCES "user"(user_id) ON DELETE CASCADE
);

-- Create indexes for optimal performance

-- User table indexes
CREATE INDEX idx_user_email ON "user"(email);
CREATE INDEX idx_user_role ON "user"(role);
CREATE INDEX idx_user_created_at ON "user"(created_at);

-- Property table indexes
CREATE INDEX idx_property_host_id ON property(host_id);
CREATE INDEX idx_property_location ON property(location);
CREATE INDEX idx_property_price ON property(pricepernight);
CREATE INDEX idx_property_created_at ON property(created_at);

-- Booking table indexes
CREATE INDEX idx_booking_property_id ON booking(property_id);
CREATE INDEX idx_booking_user_id ON booking(user_id);
CREATE INDEX idx_booking_status ON booking(status);
CREATE INDEX idx_booking_dates ON booking(start_date, end_date);
CREATE INDEX idx_booking_created_at ON booking(created_at);

-- Payment table indexes
CREATE INDEX idx_payment_booking_id ON payment(booking_id);
CREATE INDEX idx_payment_date ON payment(payment_date);
CREATE INDEX idx_payment_method ON payment(payment_method);

-- Review table indexes
CREATE INDEX idx_review_property_id ON review(property_id);
CREATE INDEX idx_review_user_id ON review(user_id);
CREATE INDEX idx_review_rating ON review(rating);
CREATE INDEX idx_review_created_at ON review(created_at);

-- Message table indexes
CREATE INDEX idx_message_sender_id ON message(sender_id);
CREATE INDEX idx_message_recipient_id ON message(recipient_id);
CREATE INDEX idx_message_sent_at ON message(sent_at);
CREATE INDEX idx_message_conversation ON message(sender_id, recipient_id, sent_at);

-- Add comments to tables and columns for documentation
COMMENT ON TABLE "user" IS 'Stores user information including hosts and guests';
COMMENT ON TABLE property IS 'Stores property listings with host information';
COMMENT ON TABLE booking IS 'Stores booking information for properties';
COMMENT ON TABLE payment IS 'Stores payment information for bookings';
COMMENT ON TABLE review IS 'Stores user reviews for properties';
COMMENT ON TABLE message IS 'Stores messages between users';

-- Add trigger to update updated_at timestamp for property table
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ language 'plpgsql';

CREATE TRIGGER update_property_updated_at 
    BEFORE UPDATE ON property 
    FOR EACH ROW 
    EXECUTE FUNCTION update_updated_at_column();
'''
