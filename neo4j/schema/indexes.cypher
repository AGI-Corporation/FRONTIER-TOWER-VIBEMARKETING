// ============================================================
// FRONTIER TOWER VIBEMARKETING — Neo4j Indexes
// File: neo4j/schema/indexes.cypher
// Description: Performance indexes for high-frequency queries
//              in the vibemarketing app.
// Run order: Execute AFTER constraints.cypher
// Neo4j version: 5.x
// ============================================================

// ------------------------------------------------------------
// RANGE INDEXES (B-tree) — for equality and range lookups
// ------------------------------------------------------------

// Person: look up by role (e.g., find all Residents)
CREATE INDEX person_role_idx IF NOT EXISTS
FOR (p:Person) ON (p.role);

// Person: look up by floor_affiliation for floor dashboards
CREATE INDEX person_floor_idx IF NOT EXISTS
FOR (p:Person) ON (p.floor_affiliation);

// Person: filter by application_status in residency funnels
CREATE INDEX person_app_status_idx IF NOT EXISTS
FOR (p:Person) ON (p.application_status);

// Person: filter active vs inactive
CREATE INDEX person_active_idx IF NOT EXISTS
FOR (p:Person) ON (p.is_active);

// Floor: look up by theme for cross-floor recommendations
CREATE INDEX floor_theme_idx IF NOT EXISTS
FOR (f:Floor) ON (f.theme);

// Floor: filter by active status
CREATE INDEX floor_active_idx IF NOT EXISTS
FOR (f:Floor) ON (f.is_active);

// Event: primary query pattern — upcoming events by start time
CREATE INDEX event_start_time_idx IF NOT EXISTS
FOR (e:Event) ON (e.start_time);

// Event: filter by status (upcoming/live/completed/cancelled)
CREATE INDEX event_status_idx IF NOT EXISTS
FOR (e:Event) ON (e.status);

// Event: filter by access type (public vs members-only)
CREATE INDEX event_access_idx IF NOT EXISTS
FOR (e:Event) ON (e.access);

// Event: filter by event_type (hackathon, salon, recurring...)
CREATE INDEX event_type_idx IF NOT EXISTS
FOR (e:Event) ON (e.event_type);

// Event: look up by floor_id for floor dashboards
CREATE INDEX event_floor_idx IF NOT EXISTS
FOR (e:Event) ON (e.floor_id);

// Program: filter by type (residency, citizenship, series)
CREATE INDEX program_type_idx IF NOT EXISTS
FOR (prog:Program) ON (prog.type);

// Program: filter open programs for application pages
CREATE INDEX program_open_idx IF NOT EXISTS
FOR (prog:Program) ON (prog.is_open);

// Campaign: filter by status (draft/scheduled/live/completed)
CREATE INDEX campaign_status_idx IF NOT EXISTS
FOR (c:Campaign) ON (c.status);

// Campaign: filter by campaign_type
CREATE INDEX campaign_type_idx IF NOT EXISTS
FOR (c:Campaign) ON (c.campaign_type);

// Campaign: look up by floor for floor-level dashboards
CREATE INDEX campaign_floor_idx IF NOT EXISTS
FOR (c:Campaign) ON (c.floor_id);

// Campaign: filter by scheduled_at for upcoming queue
CREATE INDEX campaign_scheduled_idx IF NOT EXISTS
FOR (c:Campaign) ON (c.scheduled_at);

// ContentPiece: filter by channel (x, email, luma_description)
CREATE INDEX content_channel_idx IF NOT EXISTS
FOR (cp:ContentPiece) ON (cp.channel);

// ContentPiece: filter by status (draft/approved/published)
CREATE INDEX content_status_idx IF NOT EXISTS
FOR (cp:ContentPiece) ON (cp.status);

// ContentPiece: filter by content_type (pre_event/post_event/recap)
CREATE INDEX content_type_idx IF NOT EXISTS
FOR (cp:ContentPiece) ON (cp.content_type);

// ContentPiece: filter by campaign_id for campaign views
CREATE INDEX content_campaign_idx IF NOT EXISTS
FOR (cp:ContentPiece) ON (cp.campaign_id);

// Tag: filter by category
CREATE INDEX tag_category_idx IF NOT EXISTS
FOR (t:Tag) ON (t.category);

// Organization: filter by type (startup, DAO, lab, nonprofit)
CREATE INDEX org_type_idx IF NOT EXISTS
FOR (o:Organization) ON (o.type);

// Organization: filter by floor
CREATE INDEX org_floor_idx IF NOT EXISTS
FOR (o:Organization) ON (o.floor_id);

// Metric: filter by entity_type for targeted analytics queries
CREATE INDEX metric_entity_type_idx IF NOT EXISTS
FOR (m:Metric) ON (m.entity_type);

// Metric: filter by entity_id + recorded_at for time-series
CREATE INDEX metric_entity_id_idx IF NOT EXISTS
FOR (m:Metric) ON (m.entity_id);

CREATE INDEX metric_recorded_at_idx IF NOT EXISTS
FOR (m:Metric) ON (m.recorded_at);

// ------------------------------------------------------------
// COMPOSITE INDEXES — for multi-property query patterns
// ------------------------------------------------------------

// Events by floor + status (most common dashboard query)
CREATE INDEX event_floor_status_idx IF NOT EXISTS
FOR (e:Event) ON (e.floor_id, e.status);

// Events by status + start_time (upcoming events feed)
CREATE INDEX event_status_time_idx IF NOT EXISTS
FOR (e:Event) ON (e.status, e.start_time);

// Campaigns by floor + status (floor operator view)
CREATE INDEX campaign_floor_status_idx IF NOT EXISTS
FOR (c:Campaign) ON (c.floor_id, c.status);

// ContentPiece by channel + status (publishing queue)
CREATE INDEX content_channel_status_idx IF NOT EXISTS
FOR (cp:ContentPiece) ON (cp.channel, cp.status);

// Metrics by entity_id + recorded_at (time-series lookups)
CREATE INDEX metric_entity_time_idx IF NOT EXISTS
FOR (m:Metric) ON (m.entity_id, m.recorded_at);

// ------------------------------------------------------------
// FULLTEXT INDEXES — for semantic / keyword search
// ------------------------------------------------------------

// Search events by name or description
CREATE FULLTEXT INDEX event_fulltext IF NOT EXISTS
FOR (e:Event) ON EACH [e.name, e.description];

// Search people by name or bio
CREATE FULLTEXT INDEX person_fulltext IF NOT EXISTS
FOR (p:Person) ON EACH [p.name, p.bio];

// Search organizations by name or description
CREATE FULLTEXT INDEX org_fulltext IF NOT EXISTS
FOR (o:Organization) ON EACH [o.name, o.description];

// Search content pieces by body text (for content reuse / dedup)
CREATE FULLTEXT INDEX content_fulltext IF NOT EXISTS
FOR (cp:ContentPiece) ON EACH [cp.body];

// Search programs by name or description
CREATE FULLTEXT INDEX program_fulltext IF NOT EXISTS
FOR (prog:Program) ON EACH [prog.name, prog.description];

// ------------------------------------------------------------
// Verify all indexes
// Run after setup: SHOW INDEXES;
// ------------------------------------------------------------
