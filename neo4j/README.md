# Neo4j Graph Schema: Frontier Tower VibeMarketing

This directory contains the Neo4j graph schema definitions for the Frontier Tower VibeMarketing application. The graph models the relationships between people, floors, events, and marketing campaigns to enable AI-powered cross-promotion and community intelligence.

### Files
- `schema/nodes.cypher`: Node label and property definitions.
- `schema/relationships.cypher`: Relationship types, properties, and directionality.
- `schema/constraints.cypher`: Uniqueness and existence constraints.
- `schema/indexes.cypher`: Performance and fulltext search indexes.

## Setup Instructions

1. **Start Neo4j**: Use the provided `docker-compose.yml` (if available) or connect to an AuraDB instance.
2. **Apply Schema**: Run the Cypher files in the following order:
   1. `schema/constraints.cypher`
   2. `schema/indexes.cypher`
   3. `schema/nodes.cypher`
   4. `schema/re lationships.cypher`

## Data Model Overview

### Core Nodes
- **Person**: Residents, employees, or visitors. (`id`, `name`, `bio`, `interests`)
- **Floor**: Physical locations within Frontier Tower. (`number`, `name`, `category`)
- **Event**: Community gatherings or workshops. (`id`, `name`, `type`, `date`)
- **Campaign**: Marketing efforts. (`id`, `title`, `goal`)
- **Brand**: Associated companies or entities. (`name`, `industry`, `vibe`)

### Key Relationships
- `(Person)-[:LIVES_ON|WORKS_ON]->(Floor)`
- `(Event)-[:HELD_ON]->(Floor)`
- `(Person)-[:PARTICIPATED_IN]->(Event)`
- `(Campaign)-[:TARGETS_FLOOR]->(Floor)`
- `(Campaign)-[:PROMOTES_EVENT]->(Event)`
- `(Person)-[:INTERESTED_IN]->(Brand)`
