# ZimCart

ZimCart is a local-data-only SwiftUI marketplace starter for the Matter Career Readiness Institute (MCRI) four-hour iOS debugging hackathon. It uses Zimbabwean products, USD prices, local seed data, and simulated checkout. No account, network connection, payment service, or third-party package is required.

## Requirements

- macOS with Xcode 15 or later (the project is currently configured with Xcode 27).
- An iOS 17 or later Simulator runtime, or a compatible iPhone.
- Git for the team workflow.

## Clone and run

```sh
git clone <repository-url>
cd ZimMart
open ZimMart.xcodeproj
```

In Xcode, select the **ZimMart** scheme and an iPhone Simulator running iOS 17 or later, then choose **Product → Run** (⌘R). To build from Terminal:

```sh
xcodebuild -project ZimMart.xcodeproj -scheme ZimMart -destination 'generic/platform=iOS Simulator' build
```

The catalogue is seeded locally and is available without internet. Orders remain in memory for the current app session. A phone number ending in `9` triggers the deterministic simulated order failure so teams can investigate failure handling.

## Features

- Product grid with category chips and search.
- Product details, stock display, and quantity controls.
- Shopping cart and subtotal.
- Delivery or collection checkout, Zimbabwean city selection, and EcoCash, bank transfer, or cash on delivery.
- Local simulated order confirmation and in-session order history.

## Tests

Open the Xcode test navigator and run the **ZimCartTests** target, or use **Product → Test** (⌘U). Some assertions intentionally fail against the hackathon starter because the exercise includes reproducible defects. Teams should use the reported expected behavior to prioritize investigation and add regression coverage as they make fixes.

## Known limitations

- This is a teaching simulation, not a live marketplace. It has no authentication, server, inventory synchronization, real payments, messaging, or delivery integration.
- Product artwork uses local SF Symbols rather than downloaded images.
- Cart and order data reset when the app process ends.
- Several behaviors are intentionally incorrect; use `Spec.md` as the student-facing acceptance criteria. Bug locations and solutions are reserved for facilitators.

## Four-hour event outline

- 00:00–00:20 briefing, roles, and rules
- 00:20–00:40 clone, build, inspect, and triage
- 00:40–02:30 debugging
- 02:30–02:40 remote stand-up
- 02:40–03:30 fixes and integration
- 03:30–03:45 testing and code freeze
- 03:45–04:00 demos and retrospective

The demonstration journey is: browse products → open a product → add it to the cart → change quantity → checkout → place an order → see confirmation.

## Suggested GitHub workflow

Create a GitHub issue for each observed problem. Agree on ownership before editing shared files, branch from the team’s agreed base, and commit small changes with meaningful messages. Open pull requests describing the reproduction, expected and actual behavior, the fix, and how it was tested. Ask a teammate to review before merging, communicate blockers in the team’s agreed remote channel, and prioritize a reliable shopping journey over cosmetic work.

See [HACKATHON_RULES.md](HACKATHON_RULES.md) for team expectations and the scoring rubric.
