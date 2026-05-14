---
name: movie-times
description: Find movie showtimes at a specific theater or location. Use when the user asks about movie times, what's playing tonight, showtimes near a location, or movies at a specific theater.
license: MIT
compatibility: Requires internet access for web search
metadata:
  author: rgildea
  version: "1.0"
---

# Movie Times

Find current movie showtimes for a theater or location.

## Instructions

1. **Parse the request**: Extract the theater name or city/area from `$ARGUMENTS`. If none is given, ask the user before proceeding.

2. **Search for showtimes**: Run a web search for:
   - `"[theater or location] movie times tonight"` — to find the theater's listing page
   - If a specific date was requested, include the date in the query

3. **Fetch the showtimes page**: Prefer these sources in order (they return complete listings):
   - **Atom Tickets** (`atomtickets.com`) — most reliable for full listings
   - **Moviefone** (`moviefone.com`) — good fallback
   - The theater's own website
   - Avoid Fandango — it uses dynamic JavaScript that doesn't render in fetches

4. **Present results** using this format:

   > **[Theater Name]** — [Address]
   > Showtimes for [Date]

   | Movie | Rating | Runtime | Showtimes |
   |-------|--------|---------|-----------|
   | Title | PG-13  | 2h 10m  | 3:30, 6:45, 9:15 PM |

   List IMAX, Dolby, or other premium formats as separate rows.

5. **If listings are incomplete**: Try a second source. Note at the bottom if results may be partial.

## Tips

- "Providence Place Mall" → search `"Apple Cinemas Providence Place IMAX showtimes tonight"`
- For city-wide results, try `"[city] movie times tonight"` and pick the closest theater
- Evening showtimes are typically 6 PM onward — filter if the user asks for "tonight"
