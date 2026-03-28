// ============================================================
// FRONTIER TOWER VIBEMARKETING — Neo4j Relationship Definitions
// File: neo4j/schema/relationships.cypher
// Description: All relationship types with direction, cardinality,
//              properties, and example Cypher
// ============================================================

// ============================================================
// SECTION 1: PERSON RELATIONSHIPS
// ============================================================

// [:RESIDES_ON] — Person -> Floor
// A resident or citizen is affiliated with a floor.
// Properties: since (datetime), role (string: resident|citizen|lead|visitor)
// Cardinality: Many-to-Many (person can span floors, floor has many people)
// Example:
// MATCH (p:Person {id:'person_001'}), (f:Floor {id:'floor_ai'})
// CREATE (p)-[:RESIDES_ON {since: datetime(), role: 'resident'}]->(f)

// [:LEADS] — Person -> Floor
// A person is the designated lead / curator for a floor.
// Properties: since (datetime)
// Cardinality: One-to-One per floor (one active lead)
// Example:
// MATCH (p:Person {id:'person_042'}), (f:Floor {id:'floor_ethereum'})
// CREATE (p)-[:LEADS {since: datetime('2025-06-01T00:00:00')}]->(f)

// [:HOSTS] — Person -> Event
// A person is the primary or co-host of an event.
// Properties: role (string: host|co-host|organizer|speaker)
// Cardinality: Many-to-Many
// Example:
// MATCH (p:Person {id:'person_001'}), (e:Event {id:'event_001'})
// CREATE (p)-[:HOSTS {role: 'host'}]->(e)

// [:ATTENDED] — Person -> Event
// A person RSVPed and/or attended an event.
// Properties: rsvp_at (datetime), checked_in (boolean), check_in_at (datetime)
// Cardinality: Many-to-Many
// Example:
// MATCH (p:Person {id:'person_003'}), (e:Event {id:'event_001'})
// CREATE (p)-[:ATTENDED {rsvp_at: datetime(), checked_in: true, check_in_at: datetime()}]->(e)

// [:ENROLLED_IN] — Person -> Program
// A person is enrolled in or has applied to a program.
// Properties: status (string: applied|accepted|active|alumni|rejected),
//             applied_at (datetime), accepted_at (datetime)
// Cardinality: Many-to-Many
// Example:
// MATCH (p:Person {id:'person_005'}), (prog:Program {id:'program_residency'})
// CREATE (p)-[:ENROLLED_IN {status:'accepted', applied_at: datetime(), accepted_at: datetime()}]->(prog)

// [:AFFILIATED_WITH] — Person -> Organization
// A person works at, founded, or is associated with an organization.
// Properties: role (string: founder|employee|advisor|member), since (datetime)
// Cardinality: Many-to-Many
// Example:
// MATCH (p:Person {id:'person_001'}), (o:Organization {id:'org_001'})
// CREATE (p)-[:AFFILIATED_WITH {role:'founder', since: datetime('2025-03-01T00:00:00')}]->(o)

// [:CREATED] — Person -> Campaign
// A person (operator or AI agent acting on behalf of) created a campaign.
// Properties: created_at (datetime), ai_assisted (boolean)
// Cardinality: Many-to-Many
// Example:
// MATCH (p:Person {id:'person_001'}), (c:Campaign {id:'campaign_001'})
// CREATE (p)-[:CREATED {created_at: datetime(), ai_assisted: true}]->(c)

// [:APPROVED] — Person -> ContentPiece
// A person reviewed and approved a content piece for publishing.
// Properties: approved_at (datetime)
// Cardinality: One-to-Many (one approver per piece)
// Example:
// MATCH (p:Person {id:'person_001'}), (cp:ContentPiece {id:'content_001'})
// CREATE (p)-[:APPROVED {approved_at: datetime()}]->(cp)

// [:INTERESTED_IN] — Person -> Tag
// Represents a person's interests for vibe graph recommendations.
// Properties: weight (float 0.0-1.0, derived from attendance/engagement)
// Cardinality: Many-to-Many
// Example:
// MATCH (p:Person {id:'person_001'}), (t:Tag {id:'tag_ai'})
// CREATE (p)-[:INTERESTED_IN {weight: 0.9}]->(t)

// ============================================================
// SECTION 2: FLOOR RELATIONSHIPS
// ============================================================

// [:HOSTED_ON] — Event -> Floor
// An event is physically or thematically hosted on a floor.
// Properties: is_primary (boolean)
// Cardinality: Many-to-One (event on one primary floor, possibly cross-floor)
// Example:
// MATCH (e:Event {id:'event_001'}), (f:Floor {id:'floor_ai'})
// CREATE (e)-[:HOSTED_ON {is_primary: true}]->(f)

// [:BELONGS_TO] — Program -> Floor
// A program is scoped to or associated with a floor.
// null floor_id = tower-wide program.
// Properties: scope (string: floor|tower|city)
// Cardinality: Many-to-One
// Example:
// MATCH (prog:Program {id:'program_eth_house'}), (f:Floor {id:'floor_ethereum'})
// CREATE (prog)-[:BELONGS_TO {scope: 'floor'}]->(f)

// [:SPONSORED_BY] — Event -> Organization
// An organization sponsored or co-produced an event.
// Properties: sponsorship_tier (string: title|gold|silver|community), amount (float, optional)
// Cardinality: Many-to-Many
// Example:
// MATCH (e:Event {id:'event_001'}), (o:Organization {id:'org_001'})
// CREATE (e)-[:SPONSORED_BY {sponsorship_tier: 'title'}]->(e)

// [:ORGANIZED_BY] — Event -> Organization
// An organization (not a person) organized or co-organized an event.
// Cardinality: Many-to-Many
// Example:
// MATCH (e:Event {id:'event_hackathon_01'}), (o:Organization {id:'org_agicorp'})
// CREATE (e)-[:ORGANIZED_BY]->(o)

// [:PART_OF] — Event -> Program
// An event is an installment or session within a program/series.
// Properties: session_number (int), is_capstone (boolean)
// Cardinality: Many-to-One
// Example:
// MATCH (e:Event {id:'event_vibe_12'}), (prog:Program {id:'program_vibe_coding'})
// CREATE (e)-[:PART_OF {session_number: 12, is_capstone: false}]->(prog)

// ============================================================
// SECTION 3: CAMPAIGN RELATIONSHIPS
// ============================================================

// [:PROMOTES] — Campaign -> Event
// A campaign promotes a specific event.
// Properties: campaign_phase (string: pre|live|post)
// Cardinality: Many-to-One (one event per campaign, but event can have many campaigns)
// Example:
// MATCH (c:Campaign {id:'campaign_001'}), (e:Event {id:'event_001'})
// CREATE (c)-[:PROMOTES {campaign_phase: 'pre'}]->(e)

// [:PROMOTES_PROGRAM] — Campaign -> Program
// A campaign promotes a program (e.g., residency application push).
// Properties: campaign_phase (string)
// Cardinality: Many-to-One
// Example:
// MATCH (c:Campaign {id:'campaign_residency_q2'}), (prog:Program {id:'program_residency'})
// CREATE (c)-[:PROMOTES_PROGRAM {campaign_phase: 'launch'}]->(prog)

// [:TARGETS_FLOOR] — Campaign -> Floor
// A campaign is targeted at or associated with a specific floor's audience.
// Cardinality: Many-to-Many (cross-floor campaigns possible)
// Example:
// MATCH (c:Campaign {id:'campaign_001'}), (f:Floor {id:'floor_ai'})
// CREATE (c)-[:TARGETS_FLOOR]->(f)

// [:HAS_CONTENT] — Campaign -> ContentPiece
// A campaign contains one or more content pieces.
// Properties: sequence_order (int: order in multi-post sequences)
// Cardinality: One-to-Many
// Example:
// MATCH (c:Campaign {id:'campaign_001'}), (cp:ContentPiece {id:'content_001'})
// CREATE (c)-[:HAS_CONTENT {sequence_order: 1}]->(cp)

// [:TAGGED_WITH] — Campaign|Event|Program|ContentPiece|Floor -> Tag
// Any entity can be tagged with semantic labels.
// Properties: relevance_score (float 0.0-1.0, optional)
// Cardinality: Many-to-Many
// Example:
// MATCH (e:Event {id:'event_001'}), (t:Tag {id:'tag_ai'})
// CREATE (e)-[:TAGGED_WITH {relevance_score: 0.95}]->(t)

// [:HAS_METRIC] — Campaign|ContentPiece|Event -> Metric
// Links an entity to a performance snapshot.
// Properties: (none; all data is on the Metric node)
// Cardinality: One-to-Many (multiple snapshots over time)
// Example:
// MATCH (cp:ContentPiece {id:'content_001'}), (m:Metric {id:'metric_001'})
// CREATE (cp)-[:HAS_METRIC]->(m)

// ============================================================
// SECTION 4: VIBE GRAPH RELATIONSHIPS
// (Cross-promotion intelligence layer)
// ============================================================

// [:CROSS_PROMOTES] — Campaign -> Campaign
// A campaign explicitly cross-promotes another campaign.
// Properties: reason (string), created_by_ai (boolean)
// Cardinality: Many-to-Many
// Example:
// MATCH (c1:Campaign {id:'campaign_001'}), (c2:Campaign {id:'campaign_longevity_week'})
// CREATE (c1)-[:CROSS_PROMOTES {reason:'overlapping AI + health audience', created_by_ai: true}]->(c2)

// [:SIMILAR_TO] — Event -> Event
// Two events share enough tags/audience overlap to warrant cross-promotion.
// Properties: similarity_score (float), shared_tags (list)
// Cardinality: Many-to-Many (undirected semantics, but directed in Neo4j)
// Example:
// MATCH (e1:Event {id:'event_001'}), (e2:Event {id:'event_paper_club_5'})
// CREATE (e1)-[:SIMILAR_TO {similarity_score: 0.82, shared_tags: ['AI','research']}]->(e2)

// [:REFERRED] — Person -> Person
// One person referred another into the tower ecosystem.
// Properties: referred_at (datetime), program_context (string)
// Cardinality: Many-to-Many
// Example:
// MATCH (p1:Person {id:'person_001'}), (p2:Person {id:'person_099'})
// CREATE (p1)-[:REFERRED {referred_at: datetime(), program_context: 'residency'}]->(p2)

// [:FOLLOWS] — Person -> Floor|Person|Organization
// A person follows a floor, person, or org for updates/notifications.
// Properties: followed_at (datetime), channel (string: x|email|in-app)
// Cardinality: Many-to-Many
// Example:
// MATCH (p:Person {id:'person_001'}), (f:Floor {id:'floor_longevity'})
// CREATE (p)-[:FOLLOWS {followed_at: datetime(), channel: 'email'}]->(f)

// [:CONVERTED_FROM] — Person -> ContentPiece
// Attribution: a person's application or RSVP was driven by a specific content piece.
// Properties: conversion_type (string: rsvp|application|citizenship|visit),
//             converted_at (datetime)
// Cardinality: Many-to-Many
// Example:
// MATCH (p:Person {id:'person_099'}), (cp:ContentPiece {id:'content_001'})
// CREATE (p)-[:CONVERTED_FROM {conversion_type:'application', converted_at: datetime()}]->(cp)
