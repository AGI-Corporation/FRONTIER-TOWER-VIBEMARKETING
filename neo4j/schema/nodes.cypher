// ============================================================
// FRONTIER TOWER VIBEMARKETING — Neo4j Node Definitions
// File: neo4j/schema/nodes.cypher
// Description: All node labels, properties, and inline docs
// ============================================================

// ------------------------------------------------------------
// NODE: Person
// Represents any human in the Frontier Tower ecosystem:
// residents, citizens, visitors, speakers, and partners.
// ------------------------------------------------------------
// Example CREATE:
// CREATE (p:Person {
//   id: 'person_001',
//   name: 'Alex Chen',
//   email: 'alex@example.com',
//   role: 'Resident',           // Resident | Citizen | Visitor | Speaker | Partner | Lead
//   twitter_handle: '@alexchen',
//   luma_user_id: 'luma_abc123',
//   bio: 'AI researcher and founder',
//   interests: ['AI', 'longevity', 'crypto'],
//   floor_affiliation: 'floor_ai',
//   application_status: 'accepted', // pending | accepted | rejected | alumni
//   joined_at: datetime('2025-01-15T00:00:00'),
//   last_seen_at: datetime(),
//   is_active: true
// })

// ------------------------------------------------------------
// NODE: Floor
// A themed vertical unit within Frontier Tower.
// Each floor is a community hub with its own identity, events,
// and programming cadence.
// ------------------------------------------------------------
// Example CREATE:
// CREATE (f:Floor {
//   id: 'floor_ethereum',
//   name: 'Ethereum House',
//   theme: 'Decentralized Tech & Crypto',
//   floor_number: 3,
//   lead_person_id: 'person_042',
//   capacity: 80,
//   description: 'Home of Ethereum builders, L2 researchers, and DeFi founders',
//   social_handle: '@ethereumhouse',
//   luma_calendar_id: 'cal_eth_001',
//   is_active: true,
//   created_at: datetime()
// })

// All floors in Frontier Tower:
// - Ethereum House (Decentralized Tech)
// - AI & Machine Learning Labs
// - Longevity & Health Sciences
// - Human Flourishing
// - Arts & Music
// - Deep Tech & Hardware
// - Biotech & Genomics
// - Climate & Sustainability
// - Network Society & Governance
// - Common Ground (shared / multi-theme)

// ------------------------------------------------------------
// NODE: Event
// Any event held at or associated with Frontier Tower.
// Sourced primarily from Luma; can be public or members-only.
// ------------------------------------------------------------
// Example CREATE:
// CREATE (e:Event {
//   id: 'event_001',
//   luma_event_id: 'evt-abc123',
//   name: 'Vibe Coding Night #12',
//   description: 'Monthly hacking session for tower residents',
//   event_type: 'recurring',     // one-time | recurring | series | hackathon | salon | residency
//   format: 'in-person',         // in-person | hybrid | virtual
//   access: 'members-only',      // public | members-only | invite-only
//   floor_id: 'floor_ai',
//   host_person_id: 'person_001',
//   start_time: datetime('2026-04-05T19:00:00'),
//   end_time: datetime('2026-04-05T22:00:00'),
//   capacity: 40,
//   rsvp_count: 28,
//   attendance_count: 25,
//   luma_url: 'https://lu.ma/vibecoding12',
//   tags: ['AI', 'coding', 'hackathon'],
//   status: 'upcoming',          // upcoming | live | completed | cancelled
//   created_at: datetime()
// })

// ------------------------------------------------------------
// NODE: Program
// Ongoing structured programs at Frontier Tower.
// Programs span multiple events and have enrollment/application logic.
// ------------------------------------------------------------
// Example CREATE:
// CREATE (prog:Program {
//   id: 'program_residency',
//   name: 'Tower Residency',
//   type: 'residency',            // residency | citizenship | accelerator | series | cohort
//   description: 'Live and work at Frontier Tower for 1-3 months',
//   duration_weeks: 12,
//   floor_id: null,               // null = tower-wide
//   application_url: 'https://frontiertower.io/apply',
//   is_open: true,
//   cohort_number: 4,
//   max_participants: 20,
//   current_participants: 14,
//   start_date: date('2026-05-01'),
//   end_date: date('2026-07-31'),
//   created_at: datetime()
// })

// Named programs:
// - Tower Residency
// - Tower Citizenship
// - Vibe Coding Night (series)
// - AI Career Week
// - Longevity Week
// - Ethereum House Programming
// - Accountabili-tea
// - Paper Club
// - Community Dinner Series
// - Hackathon Series

// ------------------------------------------------------------
// NODE: Campaign
// A marketing campaign tied to one or more Events or Programs.
// Holds all generated content and tracking metadata.
// ------------------------------------------------------------
// Example CREATE:
// CREATE (c:Campaign {
//   id: 'campaign_001',
//   name: 'Vibe Coding Night #12 Promo',
//   status: 'draft',             // draft | scheduled | live | completed | archived
//   campaign_type: 'event_promo', // event_promo | program_launch | weekly_digest | recap | floor_spotlight
//   linked_event_id: 'event_001',
//   linked_program_id: null,
//   floor_id: 'floor_ai',
//   channels: ['x', 'luma', 'email'],
//   target_audience: 'residents + public',
//   tone: 'playful',             // playful | technical | community | urgent | inspirational
//   created_by: 'person_001',
//   ai_generated: true,
//   created_at: datetime(),
//   scheduled_at: datetime('2026-04-03T10:00:00'),
//   published_at: null
// })

// ------------------------------------------------------------
// NODE: ContentPiece
// A single piece of content (tweet, email, post) within a Campaign.
// ------------------------------------------------------------
// Example CREATE:
// CREATE (cp:ContentPiece {
//   id: 'content_001',
//   campaign_id: 'campaign_001',
//   channel: 'x',                // x | email | luma_description | instagram | discord | slack
//   content_type: 'pre_event',   // pre_event | day_of | live | post_event | recap | announcement
//   body: 'Vibe Coding Night is BACK this Saturday...',
//   character_count: 218,
//   hashtags: ['#vibecoding', '#frontiertower', '#AI'],
//   media_urls: [],
//   utm_link: 'https://lu.ma/vc12?utm_source=x&utm_campaign=vc12_promo',
//   status: 'draft',             // draft | approved | scheduled | published | archived
//   ai_generated: true,
//   approved_by: null,
//   published_at: null,
//   impressions: 0,
//   clicks: 0,
//   engagements: 0,
//   created_at: datetime()
// })

// ------------------------------------------------------------
// NODE: Tag
// Reusable semantic labels for themes, interests, and topics.
// Used to power the Vibe Graph cross-promotion engine.
// ------------------------------------------------------------
// Example CREATE:
// CREATE (t:Tag {
//   id: 'tag_ai',
//   name: 'AI',
//   category: 'theme',           // theme | technology | community | format | floor
//   description: 'Artificial Intelligence and Machine Learning',
//   usage_count: 0,
//   created_at: datetime()
// })

// Core tags:
// AI, Crypto, Ethereum, Longevity, Biotech, Arts, Music,
// Climate, Hardware, Governance, Community, Hackathon,
// Coding, Research, Networking, Wellness, Philosophy

// ------------------------------------------------------------
// NODE: Organization
// A company, project, DAO, lab, or collective associated with
// a person, floor, or event at Frontier Tower.
// ------------------------------------------------------------
// Example CREATE:
// CREATE (o:Organization {
//   id: 'org_001',
//   name: 'Vibe Labs',
//   type: 'startup',             // startup | DAO | lab | nonprofit | collective | partner
//   website: 'https://vibelabs.io',
//   twitter_handle: '@vibelabs',
//   floor_id: 'floor_ai',
//   description: 'AI-native product studio',
//   founded_at: date('2025-03-01'),
//   is_active: true,
//   created_at: datetime()
// })

// ------------------------------------------------------------
// NODE: Metric
// Snapshot of performance data for a Campaign or ContentPiece
// at a point in time. Enables time-series analytics.
// ------------------------------------------------------------
// Example CREATE:
// CREATE (m:Metric {
//   id: 'metric_001',
//   entity_type: 'content',      // content | campaign | event | program
//   entity_id: 'content_001',
//   channel: 'x',
//   impressions: 4200,
//   clicks: 310,
//   engagements: 87,
//   rsvps: 12,
//   conversions: 3,              // e.g. residency applications attributed
//   recorded_at: datetime()
// })
