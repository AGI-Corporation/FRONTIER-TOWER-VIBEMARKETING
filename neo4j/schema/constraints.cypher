// ============================================================
// FRONTIER TOWER VIBEMARKETING — Neo4j Constraints
// File: neo4j/schema/constraints.cypher
// Description: Uniqueness and existence constraints ensuring
//              data integrity across the vibemarketing graph.
// Run order: Execute BEFORE indexes.cypher and seed_data.cypher
// Neo4j version: 5.x (Enterprise or AuraDB)
// ============================================================

// ------------------------------------------------------------
// PERSON constraints
// ------------------------------------------------------------
CREATE CONSTRAINT person_id_unique IF NOT EXISTS
FOR (p:Person)
REQUIRE p.id IS UNIQUE;

CREATE CONSTRAINT person_email_unique IF NOT EXISTS
FOR (p:Person)
REQUIRE p.email IS UNIQUE;

CREATE CONSTRAINT person_id_exists IF NOT EXISTS
FOR (p:Person)
REQUIRE p.id IS NOT NULL;

CREATE CONSTRAINT person_name_exists IF NOT EXISTS
FOR (p:Person)
REQUIRE p.name IS NOT NULL;

// ------------------------------------------------------------
// FLOOR constraints
// ------------------------------------------------------------
CREATE CONSTRAINT floor_id_unique IF NOT EXISTS
FOR (f:Floor)
REQUIRE f.id IS UNIQUE;

CREATE CONSTRAINT floor_name_unique IF NOT EXISTS
FOR (f:Floor)
REQUIRE f.name IS UNIQUE;

CREATE CONSTRAINT floor_id_exists IF NOT EXISTS
FOR (f:Floor)
REQUIRE f.id IS NOT NULL;

// ------------------------------------------------------------
// EVENT constraints
// ------------------------------------------------------------
CREATE CONSTRAINT event_id_unique IF NOT EXISTS
FOR (e:Event)
REQUIRE e.id IS UNIQUE;

CREATE CONSTRAINT event_luma_id_unique IF NOT EXISTS
FOR (e:Event)
REQUIRE e.luma_event_id IS UNIQUE;

CREATE CONSTRAINT event_id_exists IF NOT EXISTS
FOR (e:Event)
REQUIRE e.id IS NOT NULL;

CREATE CONSTRAINT event_name_exists IF NOT EXISTS
FOR (e:Event)
REQUIRE e.name IS NOT NULL;

// ------------------------------------------------------------
// PROGRAM constraints
// ------------------------------------------------------------
CREATE CONSTRAINT program_id_unique IF NOT EXISTS
FOR (prog:Program)
REQUIRE prog.id IS UNIQUE;

CREATE CONSTRAINT program_id_exists IF NOT EXISTS
FOR (prog:Program)
REQUIRE prog.id IS NOT NULL;

CREATE CONSTRAINT program_name_exists IF NOT EXISTS
FOR (prog:Program)
REQUIRE prog.name IS NOT NULL;

// ------------------------------------------------------------
// CAMPAIGN constraints
// ------------------------------------------------------------
CREATE CONSTRAINT campaign_id_unique IF NOT EXISTS
FOR (c:Campaign)
REQUIRE c.id IS UNIQUE;

CREATE CONSTRAINT campaign_id_exists IF NOT EXISTS
FOR (c:Campaign)
REQUIRE c.id IS NOT NULL;

CREATE CONSTRAINT campaign_name_exists IF NOT EXISTS
FOR (c:Campaign)
REQUIRE c.name IS NOT NULL;

// ------------------------------------------------------------
// CONTENT PIECE constraints
// ------------------------------------------------------------
CREATE CONSTRAINT contentpiece_id_unique IF NOT EXISTS
FOR (cp:ContentPiece)
REQUIRE cp.id IS UNIQUE;

CREATE CONSTRAINT contentpiece_id_exists IF NOT EXISTS
FOR (cp:ContentPiece)
REQUIRE cp.id IS NOT NULL;

CREATE CONSTRAINT contentpiece_body_exists IF NOT EXISTS
FOR (cp:ContentPiece)
REQUIRE cp.body IS NOT NULL;

// ------------------------------------------------------------
// TAG constraints
// ------------------------------------------------------------
CREATE CONSTRAINT tag_id_unique IF NOT EXISTS
FOR (t:Tag)
REQUIRE t.id IS UNIQUE;

CREATE CONSTRAINT tag_name_unique IF NOT EXISTS
FOR (t:Tag)
REQUIRE t.name IS UNIQUE;

CREATE CONSTRAINT tag_id_exists IF NOT EXISTS
FOR (t:Tag)
REQUIRE t.id IS NOT NULL;

// ------------------------------------------------------------
// ORGANIZATION constraints
// ------------------------------------------------------------
CREATE CONSTRAINT org_id_unique IF NOT EXISTS
FOR (o:Organization)
REQUIRE o.id IS UNIQUE;

CREATE CONSTRAINT org_id_exists IF NOT EXISTS
FOR (o:Organization)
REQUIRE o.id IS NOT NULL;

CREATE CONSTRAINT org_name_exists IF NOT EXISTS
FOR (o:Organization)
REQUIRE o.name IS NOT NULL;

// ------------------------------------------------------------
// METRIC constraints
// ------------------------------------------------------------
CREATE CONSTRAINT metric_id_unique IF NOT EXISTS
FOR (m:Metric)
REQUIRE m.id IS UNIQUE;

CREATE CONSTRAINT metric_id_exists IF NOT EXISTS
FOR (m:Metric)
REQUIRE m.id IS NOT NULL;

// ------------------------------------------------------------
// Verify all constraints
// Run after setup: SHOW CONSTRAINTS;
// ------------------------------------------------------------
