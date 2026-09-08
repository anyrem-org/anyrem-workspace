# Support Soonio status

Status: in-progress
Last Reviewed: 2026-09-07

## Progress

- Web development: entry at sidebar bottom and Settings; responsive modal with QR/Buy Me a Coffee tabs, vi/en copy and locale-based default.
- Payment actions disabled pending real bank/QR/payment URL. No backend or external payment interaction.
- Feature spec and status created.

## Validation

Node 22.23.1, frozen-lockfile install, ESLint, TypeScript, existing 4 test files and build pass. Touched files formatted. Full check blocked by 18 pre-existing formatting issues outside scope; build retains large-chunk warning.

Browser/mobile appearance and interaction not verified; prior Chrome escalation declined. Existing tests do not cover the new modal. Real copy/download/payment link behavior remains pending configuration.

## Donation tree demo — 2026-09-08

- Added isolated SVG tree card to Support modal and development-only `/preview/donation-tree` entry.
- Five stages, interval progress, watering/absorption/growth/idle sequence, final-stage watering, reduced-motion bypass and timer cleanup implemented. Donation trigger is provider-independent; totals remain local to the mounted demo.
- Frozen-lockfile install completed with local dependencies; pnpm update metadata lookup failed under network restrictions (no dependency change required).
- Seven test files pass, including new reducer/progress tests for all boundaries, ordered updates, repeated clicks, maturity, invalid amounts and reduced motion. Scoped ESLint/Prettier and TypeScript/build pass.
- Full `pnpm check` blocked by pre-existing unused `SupportButton` import in SettingsPage; separate full formatting check reports 17 unrelated files. Build retains large-chunk warning.
- Browser verification blocked: sandbox denied Chrome launch and escalation was declined. Mobile rendering, visual animation and browser keyboard interaction remain unverified.

## Animation polish — 2026-09-08

- Visual-only refinement: upper-right can entrance, separate pouring rotation, staggered drops with varied fall times/drift, soil darkening/ripple, gentle tree compression/rebound and leaf response.
- Growth layers animate the outgoing tree, trunk stretch, branch expansion, new-leaf unfolding and canopy fill before a soft settle. Fixed 320 × 270 SVG canvas; quiet idle sway/occasional leaf motion pause during active phases. No animation dependency added.
- Existing component API, reducer, stage/progress helpers and busy guard unchanged. Phase durations now watering 1400ms, absorbing 450ms, growing 900ms (2750ms total for an upgrade). Reduced-motion bypass and timer cleanup preserved.
- Node 22.23.1 frozen install completed; scoped ESLint/Prettier, all seven test files and TypeScript/build pass. Full check still blocked by existing unused SettingsPage import and 17 unrelated formatting issues; existing bundle-size warning remains.
- Browser visual verification remains incomplete; the earlier Chrome escalation refusal was respected.

## Soft minimal SVG redesign — 2026-09-08

- Shorter, wider silhouette with rounded leaf ellipses, overlapping soft canopy ellipses, warm rounded trunk and a smaller muted soil patch. No face, gradients, filters, masks or raster assets.
- Shared stage geometry progresses from seed to two-leaf sprout, six-leaf plant, small canopy and fuller mature canopy with eight accent leaves. Fixed canvas and existing donation API, reducer, thresholds, progress, animation phases/timings and reduced-motion behavior preserved.
- Instance-prefixed SVG IDs identify ground, soil/ripple, tree, trunk, branches/individual branches, canopy, leaves/individual leaves, previous-growth layer, watering can/tilt and five individual water drops. Leaves have independent reveal, absorption and idle transforms.
- Frozen local install, scoped ESLint/Prettier, seven test files and TypeScript/build pass. Full check still stops on the pre-existing unused SupportButton import in SettingsPage; build retains its bundle-size warning. Browser visuals remain unverified following the earlier declined Chrome escalation.
- For an animation-tool handoff, export rendered stage SVGs, resolve theme/CSS variables to concrete values, retain descriptive group names and recreate CSS keyframes, pivots and phase timing in the destination tool. Conditional stages/watering layers need exporting explicitly; no Rive import has been verified.
