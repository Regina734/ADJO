-- Create tontines table
CREATE TABLE IF NOT EXISTS tontines (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(255) NOT NULL,
    description TEXT,
    amount DECIMAL(19, 4) NOT NULL,
    currency VARCHAR(10) DEFAULT 'XAF',
    frequency VARCHAR(20) NOT NULL,
    tontine_type VARCHAR(20) DEFAULT 'classic',
    total_rounds INTEGER NOT NULL,
    current_round INTEGER DEFAULT 0,
    max_members INTEGER NOT NULL,
    current_members INTEGER DEFAULT 0,
    status VARCHAR(20) DEFAULT 'pending',
    smart_contract_address VARCHAR(56),
    created_by UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    community_id UUID REFERENCES communities(id) ON DELETE SET NULL,
    start_date DATE NOT NULL,
    end_date DATE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create indexes for tontines
CREATE INDEX idx_tontines_creator ON tontines(created_by);
CREATE INDEX idx_tontines_status ON tontines(status);
CREATE INDEX idx_tontines_community ON tontines(community_id);
CREATE INDEX idx_tontines_type ON tontines(tontine_type);

-- Create tontine_members table
CREATE TABLE IF NOT EXISTS tontine_members (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    tontine_id UUID NOT NULL REFERENCES tontines(id) ON DELETE CASCADE,
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    turn_order INTEGER,
    role VARCHAR(20) DEFAULT 'member',
    has_received BOOLEAN DEFAULT FALSE,
    received_at TIMESTAMPTZ,
    joined_at TIMESTAMPTZ DEFAULT NOW(),
    UNIQUE(tontine_id, user_id)
);

-- Create indexes for tontine_members
CREATE INDEX idx_tontine_members_tontine ON tontine_members(tontine_id);
CREATE INDEX idx_tontine_members_user ON tontine_members(user_id);
CREATE INDEX idx_tontine_members_turn ON tontine_members(turn_order);

-- Create tontine_contributions table
CREATE TABLE IF NOT EXISTS tontine_contributions (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    tontine_id UUID NOT NULL REFERENCES tontines(id) ON DELETE CASCADE,
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    amount DECIMAL(19, 4) NOT NULL,
    round_number INTEGER NOT NULL,
    contribution_date DATE DEFAULT CURRENT_DATE,
    status VARCHAR(20) DEFAULT 'pending',
    transaction_hash VARCHAR(64),
    payment_method VARCHAR(20) DEFAULT 'wallet',
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create indexes for tontine_contributions
CREATE INDEX idx_contributions_tontine ON tontine_contributions(tontine_id);
CREATE INDEX idx_contributions_user ON tontine_contributions(user_id);
CREATE INDEX idx_contributions_status ON tontine_contributions(status);
CREATE INDEX idx_contributions_round ON tontine_contributions(round_number);

-- Create community_tontines junction table
CREATE TABLE IF NOT EXISTS community_tontines (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    community_id UUID NOT NULL REFERENCES communities(id) ON DELETE CASCADE,
    tontine_id UUID NOT NULL REFERENCES tontines(id) ON DELETE CASCADE,
    added_at TIMESTAMPTZ DEFAULT NOW(),
    UNIQUE(community_id, tontine_id)
);

-- Create indexes
CREATE INDEX idx_community_tontines_community ON community_tontines(community_id);
CREATE INDEX idx_community_tontines_tontine ON community_tontines(tontine_id);

-- Create triggers
CREATE TRIGGER update_tontines_updated_at
    BEFORE UPDATE ON tontines
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_tontine_contributions_updated_at
    BEFORE UPDATE ON tontine_contributions
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();
