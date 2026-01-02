-- Create boxes table
CREATE TABLE IF NOT EXISTS boxes (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    balance DECIMAL(19, 4) DEFAULT 0,
    currency VARCHAR(10) DEFAULT 'XAF',
    goal_amount DECIMAL(19, 4),
    goal_date DATE,
    interest_rate DECIMAL(5, 2) DEFAULT 0,
    box_type VARCHAR(20) DEFAULT 'standard',
    stellar_wallet_address VARCHAR(56),
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create indexes for boxes
CREATE INDEX idx_boxes_user ON boxes(user_id);
CREATE INDEX idx_boxes_active ON boxes(is_active);
CREATE INDEX idx_boxes_type ON boxes(box_type);

-- Create box_transactions table
CREATE TABLE IF NOT EXISTS box_transactions (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    box_id UUID NOT NULL REFERENCES boxes(id) ON DELETE CASCADE,
    amount DECIMAL(19, 4) NOT NULL,
    transaction_type VARCHAR(20) NOT NULL,
    status VARCHAR(20) DEFAULT 'pending',
    reference VARCHAR(100) UNIQUE,
    transaction_hash VARCHAR(64),
    fee DECIMAL(19, 4) DEFAULT 0,
    description TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create indexes for box_transactions
CREATE INDEX idx_box_transactions_box ON box_transactions(box_id);
CREATE INDEX idx_box_transactions_type ON box_transactions(transaction_type);
CREATE INDEX idx_box_transactions_status ON box_transactions(status);
CREATE INDEX idx_box_transactions_created ON box_transactions(created_at DESC);

-- Create triggers
CREATE TRIGGER update_boxes_updated_at
    BEFORE UPDATE ON boxes
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_box_transactions_updated_at
    BEFORE UPDATE ON box_transactions
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();
