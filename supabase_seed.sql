-- Supabase Seed Data for Elite Home Repairs & Decor

-- Insert sample services
INSERT INTO services (name, description, image_url, starting_price, price_text, category, is_active) VALUES
('House Decoration', 'Complete house decoration services including wall treatments, lighting design, and furniture arrangement.', '', 150000, 'From ₦150,000', 'Decoration', true),
('Interior Decoration', 'Professional interior design services to create beautiful, functional spaces.', '', 100000, 'From ₦100,000', 'Decoration', true),
('Gate Fixing', 'Expert gate repair services for all types of gates.', '', 25000, 'From ₦25,000', 'Repairs', true),
('Gate Installation', 'Professional gate installation with high-quality materials.', '', 80000, 'From ₦80,000', 'Installation', true),
('Welding Repairs', 'Skilled welding services for metal gates, railings, and furniture.', '', 15000, 'From ₦15,000', 'Repairs', true),
('Shower Installation', 'Modern shower installation with premium fixtures.', '', 45000, 'From ₦45,000', 'Installation', true),
('Bathroom Fittings', 'Complete bathroom fitting services.', '', 35000, 'From ₦35,000', 'Plumbing', true),
('Plumbing Repairs', 'Fast and reliable plumbing repairs.', '', 10000, 'From ₦10,000', 'Plumbing', true),
('Painting', 'Interior and exterior painting with premium paints.', '', 50000, 'From ₦50,000', 'Painting', true),
('Tiling', 'Expert floor and wall tiling.', '', 40000, 'From ₦40,000', 'Installation', true),
('Ceiling Repairs', 'Ceiling repair and installation services.', '', 30000, 'From ₦30,000', 'Repairs', true),
('General Maintenance', 'Comprehensive home maintenance services.', '', NULL, 'Request Quote', 'Repairs', true);

-- Insert sample projects
INSERT INTO projects (title, description, before_image_url, after_image_url, image_urls, location, service_type, date_completed, likes, comments, is_published) VALUES
('Modern Living Room Makeover', 'Complete transformation of traditional living room into modern elegant space.', '', '', ARRAY[]::text[], 'Lekki, Lagos', 'Interior Decoration', '2024-01-15', 45, 12, true),
('Security Gate Installation', 'Professional installation of modern security gate with auto-lock system.', '', '', ARRAY[]::text[], 'Ikeja, Lagos', 'Gate Installation', '2023-12-20', 38, 8, true),
('Bathroom Renovation', 'Full bathroom renovation with new tiles, shower, and fixtures.', '', '', ARRAY[]::text[], 'Victoria Island', 'Plumbing & Tiling', '2023-11-18', 52, 15, true),
('Kitchen Remodeling', 'Modern kitchen design with custom cabinets and granite countertops.', '', '', ARRAY[]::text[], 'Yaba, Lagos', 'Interior Decoration', '2023-10-25', 67, 20, true);

-- Insert sample reviews
INSERT INTO reviews (customer_name, rating, review_message, service_done, date, is_approved, is_featured) VALUES
('Chinedu Okafor', 5.0, 'Excellent service! My bathroom looks brand new. Very professional and clean work.', 'Bathroom Renovation', '2024-01-15', true, true),
('Amina Bello', 5.0, 'The gate installation was done perfectly. Strong and beautiful design. Highly recommend!', 'Gate Installation', '2023-12-28', true, true),
('Tunde Adeyemi', 4.5, 'Great painting job on my house exterior. The color matching was spot on.', 'House Painting', '2023-12-10', true, false),
('Ngozi Eze', 5.0, 'My living room transformation is absolutely stunning! The team understood my vision perfectly.', 'Interior Decoration', '2023-11-22', true, false);

-- Insert sample bookings
INSERT INTO bookings (full_name, phone_number, whatsapp_number, email, location, service_needed, preferred_date, preferred_time, problem_description, status) VALUES
('Chinedu Okafor', '+234 801 234 5678', '+234 801 234 5678', 'chinedu@email.com', 'Lekki, Lagos', 'Bathroom Renovation', '2024-01-20', '10:00 AM', 'Need complete bathroom renovation including tiling, plumbing, and shower installation.', 'pending'),
('Amina Bello', '+234 802 345 6789', '+234 802 345 6789', NULL, 'Ikeja, Lagos', 'Gate Installation', '2024-01-18', '2:00 PM', 'Install new security gate for compound entrance.', 'accepted'),
('Tunde Adeyemi', '+234 803 456 7890', NULL, 'tunde@email.com', 'Surulere, Lagos', 'House Painting', '2024-01-15', '9:00 AM', 'Exterior painting for 4-bedroom duplex.', 'in_progress'),
('Ngozi Eze', '+234 804 567 8901', '+234 804 567 8901', NULL, 'Victoria Island', 'Interior Decoration', '2024-01-10', '11:00 AM', 'Living room and master bedroom decoration.', 'completed');
