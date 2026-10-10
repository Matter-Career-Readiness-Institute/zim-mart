# Codex Project Specification: ZimCart — The Broken Build

## 1. Project Overview

Build a deliberately buggy SwiftUI e-commerce application called **ZimCart**, designed for a four-hour debugging hackathon for junior iOS developers at Matter Career Readiness Institute (MCRI), Zimbabwe.

ZimCart is a local-data-only shopping application that simulates an online marketplace for customers in Zimbabwe. Customers can browse products, search and filter a catalogue, manage a shopping cart, select delivery or collection, choose a payment method, check out, and view their orders.

The repository must be prepared for a supervised, four-hour, team-based debugging competition.

**The core objective is to give students an existing application that they must understand, debug, prioritise, and improve. Do not build a finished application and then merely describe possible bugs. Plant real, reproducible bugs in the code.**

## 2. Critical Requirements

- Native iOS application using Swift and SwiftUI.
- Use the latest stable Xcode-compatible Swift language features available in the development environment.
- No backend.
- No network requests.
- No API keys, credentials, or third-party service dependencies.
- No external package dependencies unless absolutely necessary; prefer none.
- All product, customer, cart, and order data must be available locally.
- The project must be straightforward to clone, open, build, and run in the iOS Simulator.
- Use deterministic seed data so every student sees the same products and initial state.
- The starter application must compile successfully before students begin the exercise.
- The application must contain intentional semantic, business-logic, state-management, and runtime bugs.
- Bugs must be reproducible and suitable for junior developers to investigate using Xcode, breakpoints, console output, and SwiftUI previews where appropriate.
- Do not plant random syntax errors, missing files, missing assets, broken dependencies, or unrelated environment problems.
- Do not silently repair the intentional bugs when preparing or testing the repository.

**Important:** A successful baseline build is a prerequisite, not a bug to plant. Students should be able to run the application immediately and investigate incorrect behaviour. Document optional build-error exercises separately if useful, without breaking the main starter branch.

## 3. Target Users and Context

The target users are junior Swift and SwiftUI developers who have completed introductory iOS development training.

The app should be simple enough for them to understand but substantial enough to require investigation and coordination.

Use familiar Zimbabwean context throughout the application:

- Product prices displayed in USD.
- Example delivery locations including Harare, Bulawayo, Mutare, Gweru, Masvingo, and Victoria Falls.
- Locally relevant grocery, electronics, household, agricultural, and fashion products.
- Payment options such as EcoCash, bank transfer, and cash on delivery.
- A delivery-versus-collection choice.

This is a simulated shopping experience. Do not implement real payments, messaging, authentication, or delivery integrations.

## 4. Technology and Architecture

Use a small, understandable SwiftUI architecture.

Suggested structure:

ZimCart/
- App/
  - ZimCartApp.swift
- Models/
  - Product.swift
  - CartItem.swift
  - Customer.swift
  - Order.swift
  - CheckoutOptions.swift
- Data/
  - SeedData.swift
  - LocalStore.swift
- ViewModels/
  - ProductViewModel.swift
  - CartViewModel.swift
  - CheckoutViewModel.swift
  - OrderViewModel.swift
- Views/
  - MainTabView.swift
  - ProductListView.swift
  - ProductDetailView.swift
  - CartView.swift
  - CheckoutView.swift
  - OrderConfirmationView.swift
  - OrderHistoryView.swift
  - OrderDetailView.swift
  - Components/
- Resources/
  - Assets.xcassets
- Tests/
  - ZimCartTests/
- README.md
- HACKATHON_RULES.md
- FACILITATOR_ANSWER_KEY.md

Adapt this structure if a simpler implementation is more appropriate. Avoid overengineering.

Use `NavigationStack` for navigation and modern SwiftUI state-management patterns compatible with the selected deployment target.

Keep business logic sufficiently separated from the views so students can trace state changes and debug calculations.

## 5. Application Features

### Feature A: Product Catalogue

Display a scrollable grid or list of products.

Each product must include:

- Unique identifier.
- Name.
- Description.
- Category.
- Price in USD.
- Stock quantity.
- Locally available image or bundled placeholder.
- Optional rating.

Include at least 12 seed products across Electronics, Food, Home, Fashion, and Agriculture.

Requirements:

- The catalogue loads on launch.
- Product cards display correct names, images, and prices.
- Tapping a product opens its detail screen.
- Products with no available stock are clearly identified.
- The layout works on standard iPhone Simulator sizes.

### Feature B: Search and Filtering

Customers must be able to:

- Search by product name.
- Filter by category.
- Reset the category filter.
- See a useful empty state when no results match.
- Combine search and category filtering.

Search should be case-insensitive and ignore leading or trailing whitespace.

### Feature C: Product Details

Display:

- Product name and image.
- Description.
- Price.
- Stock availability.
- Quantity selector.
- Add-to-cart button.

Prevent quantities below one and quantities exceeding available stock.

The UI should reflect whether an item can be added to the cart.

### Feature D: Shopping Cart

Customers must be able to:

- View all cart items.
- Add products.
- Increase or decrease quantities.
- Remove individual items.
- View item subtotals.
- View the overall cart subtotal.
- Continue shopping.
- Navigate to checkout.

Define the expected behaviour clearly: adding a product already in the cart updates its quantity rather than creating a duplicate line item.

The cart badge and totals must reflect the actual cart state.

### Feature E: Checkout

Create a checkout screen inspired by conventional online shopping experiences.

Sections:

1. Delivery method.
2. Delivery address and contact details.
3. Payment method.
4. Order summary.
5. Place-order action.

Delivery options:

- Delivery.
- Collection.

Payment options:

- EcoCash.
- Bank transfer.
- Cash on delivery.

Customer information:

- Full name.
- Phone number.
- Delivery address when delivery is selected.
- City.

Define a fixed simulated delivery fee of $3.00 for delivery and $0.00 for collection.

The checkout summary must calculate:

- Item subtotal.
- Delivery fee.
- Final total.

Validate required fields and prevent invalid checkout attempts.

Collection must not require a delivery address.

### Feature F: Order Placement

When a valid order is placed:

- Generate a unique local order identifier.
- Store a snapshot of the purchased items, quantities, prices, payment method, delivery method, and applicable address.
- Record the order total.
- Set the initial order status to Pending.
- Display an order confirmation.
- Clear the active cart only after successful order creation.
- Prevent repeated taps from accidentally creating duplicate orders.
- Display a recoverable error if simulated order submission fails.

Implement simulated success and failure using local logic only. No HTTP requests or real payment processing.

### Feature G: Order History

Customers must be able to:

- View previously placed orders.
- See each order's identifier, date, total, and status.
- Open an order to see its details.
- View the original order items and prices.

Order history should remain available during the app session. Persisting orders between launches is optional and should not take priority over the core debugging exercise.

## 6. Bug Seeding Strategy

Plant approximately 22 intentional defects across the application.

Target distribution:

- 3 product catalogue and filtering defects.
- 2 product detail defects.
- 5 cart and calculation defects.
- 6 checkout and validation defects.
- 3 order creation and confirmation defects.
- 2 navigation or state propagation defects.
- 1 order-history defect.

Some defects may overlap in their visible symptoms, but each must have a clearly identified root cause.

Do not announce the bug locations to students. Give them the requirements and acceptance criteria, not the answers.

### Bug quality requirements

Every planted bug must:

1. Exist in the actual source code.
2. Be reproducible with a clear sequence of user actions.
3. Have a specific expected result.
4. Have a different, incorrect actual result.
5. Be fixable within a junior developer's capabilities.
6. Be traceable to a meaningful programming mistake.
7. Avoid making the entire application unusable.
8. Avoid requiring an API, network connection, or external account to reproduce.
9. Avoid depending on timing or random behaviour.
10. Be documented in the private facilitator answer key.

Include a mixture of:

- Incorrect arithmetic.
- Incorrect Boolean conditions.
- Missing or misplaced state updates.
- Stale derived values.
- Incorrect filtering predicates.
- Incorrect optional handling.
- Invalid navigation state.
- Incorrect quantity handling.
- Incorrect validation rules.
- Incorrect order/cart lifecycle handling.
- UI controls connected to the wrong actions.
- Errors involving value types, reference types, or state ownership where appropriate.

Prefer genuine debugging exercises over arbitrary typos.

The baseline project must build and launch. Do not introduce uncompilable code into the default student branch.

## 7. Required MVP Acceptance Criteria

These are the functional outcomes students must work towards.

### Catalogue
- The catalogue displays the seeded products.
- Product details open correctly.
- Search returns the expected matching products.
- Category filtering returns the correct products.
- Search and filtering work together.

### Cart
- Adding a product updates the cart.
- Adding the same product again updates its quantity.
- Increasing quantity changes the subtotal.
- Decreasing quantity changes the subtotal.
- Quantity cannot fall below one through the quantity controls.
- Removing an item removes only the selected item.
- The cart badge reflects the cart.
- The cart subtotal is correct.

### Checkout
- Delivery and collection can be selected.
- The selected method is reflected in the order summary.
- Delivery adds $3.00.
- Collection adds $0.00.
- The displayed total equals the item subtotal plus the applicable fee.
- Required customer details are validated.
- A valid payment method is required.
- Collection does not require a delivery address.

### Order creation
- Valid checkout creates an order.
- The confirmation screen shows the correct order.
- The total and purchased items match the checkout.
- The cart clears after successful order creation.
- An unsuccessful order attempt preserves the cart.
- Repeated submission does not create duplicate orders.

### Order history
- The newly placed order appears in order history.
- Opening the order displays the correct items and totals.
- Order details remain consistent with the original purchase.

## 8. Local Data and Assets

Create deterministic seed data for all products and sample orders.

Requirements:

- No API calls.
- No remote image loading.
- No dependence on internet access.
- Bundle product images where practical.
- Otherwise use local SF Symbols or bundled placeholder artwork.
- Use a single consistent USD currency format.
- Make stock quantities explicit.
- Include enough sample products to exercise search, filtering, stock validation, and cart calculations.

Seed data must not be randomised between runs.

## 9. Testing and Validation

Create a small number of XCTest unit tests for core business logic, particularly:

- Cart subtotal calculations.
- Delivery fee calculations.
- Checkout total calculations.
- Quantity limits.
- Product filtering.
- Order total consistency.

The tests should make the expected business rules explicit.

Where appropriate, some tests may fail against the intentionally buggy implementation. Document which failures correspond to planted defects in the private facilitator materials.

Do not make the entire test suite unusable. Students should be able to run tests, inspect failures, and use them to investigate problems.

Before handing over the repository:

1. Build the project successfully.
2. Confirm that the app launches in the iOS Simulator.
3. Confirm that local seed data loads.
4. Verify that the planted defects are reproducible.
5. Verify that there are no missing assets or dependencies.
6. Ensure that the README accurately describes how to run the project.
7. Keep the correct fixes out of the student-facing files and Git history.

## 10. GitHub Collaboration

Prepare the repository for a team-based remote collaboration exercise.

The README must include:

- Project overview.
- Prerequisites.
- Clone instructions.
- How to open the project.
- How to select an iOS Simulator.
- How to build and run.
- How to run tests.
- Feature list.
- Known limitations.
- Suggested GitHub workflow.

Create a HACKATHON_RULES.md containing:

- Team members should communicate before editing shared files.
- Each issue should describe the problem and expected behaviour.
- Fixes should be developed on branches.
- Changes should be committed with meaningful messages.
- Pull requests should explain the bug, the fix, and how it was tested.
- Teammates should review each other's changes.
- Teams should prioritise a working MVP over cosmetic improvements.
- Students should communicate blockers and progress through their agreed remote channel.

Do not include bug locations, expected patches, or the private answer key in the student-facing documentation.

## 11. Facilitator Answer Key

Create FACILITATOR_ANSWER_KEY.md separately from the student-facing instructions.

For each of the approximately 22 defects, document:

- Unique bug ID.
- Severity: Critical, High, Medium, or Low.
- Category: Build, Logic, State, Runtime, Navigation, Validation, or UX.
- Affected file and relevant symbol.
- Steps to reproduce.
- Expected behaviour.
- Actual behaviour.
- Root cause.
- Suggested correction.
- How to verify the fix.
- Related acceptance criteria.

Include a dependency map showing which defects should be fixed before others.

Identify the 10 defects that most directly affect the checkout-to-order-confirmation MVP journey.

Keep this document untracked or in a separate facilitator-only location. Do not commit the answer key to the student-facing repository or expose it through a public branch.

## 12. Four-Hour Hackathon Design

Optimise the exercise for four hours.

Suggested schedule:

- 00:00–00:20 — Briefing, roles, and rules.
- 00:20–00:40 — Clone, build, inspect, and triage.
- 00:40–02:30 — Main debugging period.
- 02:30–02:40 — Remote stand-up.
- 02:40–03:30 — Final fixes and integration.
- 03:30–03:45 — Testing and code freeze.
- 03:45–04:00 — Demonstrations and retrospective.

The required demonstration flow is:

Browse products → open a product → add it to the cart → change quantity → checkout → place order → see confirmation.

The main judging criterion is whether the team can demonstrate a reliable core shopping journey, not whether it fixes every planted bug.

## 13. Scoring Rubric

Prepare a scoring rubric totalling 100 points:

- Core MVP functionality: 40 points.
- Debugging quality and correctness: 20 points.
- GitHub workflow and code review: 15 points.
- Remote communication and collaboration: 15 points.
- Testing and final demonstration: 10 points.

Reward clear diagnosis and tested fixes over the number of lines changed.

Do not award points simply for deleting failing code or disabling a feature to hide a defect.

## 14. Implementation Instructions for Codex

Work in this order:

1. Inspect the current repository and determine whether a suitable Xcode project already exists.
2. If necessary, create a new native SwiftUI project with a valid project configuration.
3. Implement the working app structure and deterministic local data.
4. Build and run the clean baseline.
5. Add intentional bugs in small, independently understandable changes.
6. Verify each planted bug and record its reproduction steps.
7. Add unit tests and identify which expected tests fail because of planted defects.
8. Write the student README and hackathon rules.
9. Prepare the private facilitator answer key separately.
10. Run the final build and launch checks again.

Do not stop after writing a proposal or architecture document. Implement the project files.

If you have access to Xcode and the iOS Simulator, use them to validate the build and runtime behaviour. If you do not, state clearly which checks were not performed; do not claim that the project has been successfully built or launched.

Before finishing, report:

- Files created or modified.
- How to open and run the application.
- The exact build and runtime checks performed.
- The number of seeded defects.
- The locations of the student materials and private facilitator materials.
- Any remaining limitations.

**Final success condition:** A junior developer can clone the repository, open it in Xcode, run ZimCart without network access, reproduce its incorrect behaviour, and begin fixing meaningful bugs within the first 20 minutes.
