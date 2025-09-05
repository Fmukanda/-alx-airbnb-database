-- Implement partitioning on Booking table based on start_date

-- 1. Create the partitioned table structure
CREATE TABLE booking_partitioned (
    booking_id UUID DEFAULT uuid_generate_v4(),
    property_id UUID NOT NULL,
    user_id UUID NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL(10, 2) NOT NULL CHECK (total_price >= 0),
    status booking_status NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (booking_id, start_date),
    FOREIGN KEY (property_id) REFERENCES property(property_id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES "user"(user_id) ON DELETE CASCADE,
    CHECK (start_date < end_date)
) PARTITION BY RANGE (start_date);

-- 2. Create partitions for different time periods
-- Historical data (past bookings)
CREATE TABLE booking_historical PARTITION OF booking_partitioned
    FOR VALUES FROM ('2000-01-01') TO ('2023-12-31');

-- Current year bookings
CREATE TABLE booking_2024 PARTITION OF booking_partitioned
    FOR VALUES FROM ('2024-01-01') TO ('2024-12-31');

-- Next year bookings
CREATE TABLE booking_2025 PARTITION OF booking_partitioned
    FOR VALUES FROM ('2025-01-01') TO ('2025-12-31');

-- Future bookings (beyond 2025)
CREATE TABLE booking_future PARTITION OF booking_partitioned
    FOR VALUES FROM ('2026-01-01') TO ('2100-12-31');

-- 3. Create indexes on partitioned table
CREATE INDEX idx_booking_partitioned_start_date ON booking_partitioned(start_date);
CREATE INDEX idx_booking_partitioned_user_id ON booking_partitioned(user_id);
CREATE INDEX idx_booking_partitioned_property_id ON booking_partitioned(property_id);
CREATE INDEX idx_booking_partitioned_status ON booking_partitioned(status);
CREATE INDEX idx_booking_partitioned_dates ON booking_partitioned(start_date, end_date);

-- 4. Copy data from original table to partitioned table
INSERT INTO booking_partitioned 
SELECT * FROM booking;

-- 5. Verify data distribution
SELECT 
    'Historical' as partition, 
    COUNT(*) as booking_count 
FROM booking_historical
UNION ALL
SELECT 
    '2024' as partition, 
    COUNT(*) 
FROM booking_2024
UNION ALL
SELECT 
    '2025' as partition, 
    COUNT(*) 
FROM booking_2025
UNION ALL
SELECT 
    'Future' as partition, 
    COUNT(*) 
FROM booking_future;

-- 6. Create automatic partition creation function
CREATE OR REPLACE FUNCTION create_booking_partition()
RETURNS trigger AS $$
BEGIN
    -- Automatically create partitions for new years
    EXECUTE format(
        'CREATE TABLE IF NOT EXISTS booking_%s PARTITION OF booking_partitioned ' ||
        'FOR VALUES FROM (%L) TO (%L)',
        EXTRACT(YEAR FROM NEW.start_date),
        DATE(EXTRACT(YEAR FROM NEW.start_date) || '-01-01'),
        DATE(EXTRACT(YEAR FROM NEW.start_date) || '-12-31')
    );
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- 7. Create trigger for automatic partition management
CREATE TRIGGER trigger_create_booking_partition
    BEFORE INSERT ON booking_partitioned
    FOR EACH ROW
    EXECUTE FUNCTION create_booking_partition();


