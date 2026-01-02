-- Create faq_items table
CREATE TABLE IF NOT EXISTS faq_items (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    category VARCHAR(50) NOT NULL,
    question_fr TEXT NOT NULL,
    question_en TEXT NOT NULL,
    question_fon TEXT NOT NULL,
    answer_fr TEXT NOT NULL,
    answer_en TEXT NOT NULL,
    answer_fon TEXT NOT NULL,
    display_order INTEGER DEFAULT 0,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create indexes for faq_items
CREATE INDEX idx_faq_category ON faq_items(category);
CREATE INDEX idx_faq_order ON faq_items(display_order);
CREATE INDEX idx_faq_active ON faq_items(is_active);

-- Create advertisements table
CREATE TABLE IF NOT EXISTS advertisements (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    title VARCHAR(255) NOT NULL,
    content TEXT,
    image_url VARCHAR(500),
    target_tier VARCHAR(20) DEFAULT 'free',
    click_url VARCHAR(500),
    is_active BOOLEAN DEFAULT TRUE,
    impressions INTEGER DEFAULT 0,
    clicks INTEGER DEFAULT 0,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create indexes for advertisements
CREATE INDEX idx_ads_tier ON advertisements(target_tier);
CREATE INDEX idx_ads_active ON advertisements(is_active);

-- Create notifications table
CREATE TABLE IF NOT EXISTS notifications (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    notification_type VARCHAR(50) NOT NULL,
    title VARCHAR(255) NOT NULL,
    message TEXT NOT NULL,
    is_read BOOLEAN DEFAULT FALSE,
    metadata JSONB,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create indexes for notifications
CREATE INDEX idx_notifications_user ON notifications(user_id);
CREATE INDEX idx_notifications_read ON notifications(is_read);
CREATE INDEX idx_notifications_type ON notifications(notification_type);
CREATE INDEX idx_notifications_created ON notifications(created_at DESC);

-- Create triggers
CREATE TRIGGER update_faq_items_updated_at
    BEFORE UPDATE ON faq_items
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_advertisements_updated_at
    BEFORE UPDATE ON advertisements
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();
