-- Index optimization for better query performance

-- User Table Indexes
CREATE INDEX idx_user_email ON "user"(email);
CREATE INDEX idx_user_role ON "user"(role);
CREATE INDEX idx_user_created_at ON "user"(created_at);

-- Booking Table Indexes
CREATE INDEX idx_booking_user_id ON booking(user_id);
CREATE INDEX idx_booking_property_id ON booking(property_id);
CREATE INDEX idx_booking_status ON booking(status);
CREATE INDEX idx_booking_dates ON booking(start_date, end_date);
CREATE INDEX idx_booking_created_at ON booking(created_at);
CREATE INDEX idx_booking_user_property ON booking(user_id, property_id);

-- Property Table Indexes
CREATE INDEX idx_property_host_id ON property(host_id);
CREATE INDEX idx_property_location ON property(location);
CREATE INDEX idx_property_price ON property(pricepernight);
CREATE INDEX idx_property_created_at ON property(created_at);
CREATE INDEX idx_property_location_price ON property(location, pricepernight);

-- Composite indexes for common query patterns
CREATE INDEX idx_booking_user_status ON booking(user_id, status);
CREATE INDEX idx_booking_property_dates ON booking(property_id, start_date, end_date);
CREATE INDEX idx_user_role_created ON "user"(role, created_at);
