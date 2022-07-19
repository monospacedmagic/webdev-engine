# Categories

This document explains the categories that projects in this monorepo are grouped by.

## Apps
- Contain Pages composed of Components, as well as Endpoints.
- Based on SvelteKit.
- Collectively make up the frontend.

### Components
- (Collections of) Reusable Svelte components.

## Libraries
- Collections of data structures and logic reusable across different (types of) projects.

## Services
- Microservices with a GraphQL API.
- Collectively make up the backend.

## Tools
- Can be used to execute tasks that revolve around building or working on (parts of) projects within this monorepo.

## Templates
- Templates to be used by tools to generate (parts of) projects.

## Meta
Projects that fit one or more of these constraints:
- the project stores data that relates to the monorepo as a whole
- the project doesn't fit into any of the other categories

## Other directories
These directories don't contain projects but are explained here as well for convenience.

### common
- Global configuration

### common/scripts
- Scripts that can be executed as-is from anywhere within the repo
- Offer shortcuts to make working with Tools easier and more comfortable
