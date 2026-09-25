# Iris: Cosmetics E-Commerce Project Plan

Last updated: 2026-09-25 · Status: DRAFT for review

## 1. Goal and Scope

One Flutter codebase that ships:

| Target | Audience | Entry point |
|---|---|---|
| iOS + Android app | Customers | `lib/main.dart` |
| Customer website (Flutter web) | Customers | `lib/main.dart` (web build) |
| Admin app: dashboard (web) + admin app (iOS, Android) | Store staff | `lib/main_admin.dart` |

**Success looks like:** a customer can browse, search, order and track cosmetic products (skincare, makeup, hair, fragrance) on phone or web. Staff can manage products, stock, orders and customers from the web dashboard or the admin mobile app.

## 2. Fixed Decisions (from the project owner)

| Concern | Choice | Rule |
|---|---|---|
| State management | **Riverpod** (`flutter_riverpod` + `riverpod_annotation` generator) | **`setState` is banned.** See §7. |
| Routing | **go_router** | All navigation goes through the router. No `Navigator.push`. See §8. |
| Local storage | **Hive** | Cache and preferences only. See §9. |
| HTTP client | **Dio** | Single shared instance with interceptors. See §9.1. |

Already in `pubspec.yaml`: `flutter_riverpod`, `riverpod_annotation`, `riverpod_generator`, `go_router`, `equatable`, `flutter_screenutil`, `google_fonts`, `build_runner`.
Not yet added: Hive, `dio`, `flutter_secure_storage` (see §3).

### Who does what

| Claude builds | You build |
|---|---|
| Folder structure, routing, providers, repositories, Dio, Hive, models, error handling, responsive helpers | **All visual styling**: colors, fonts, spacing, layout polish, animations |
| Screens as **bare skeletons**: they wire providers and widgets together, with no styling | **All user-facing text**: titles, labels, hints, messages |
| Only the functional widgets a screen needs, unstyled, with the callback wired to the provider | **Buttons and their look**, and any extra UI you want |
| Extra features if you ask | Theme values (`app_colors.dart`, `app_text_styles.dart`, `app_theme.dart`) |

Skeleton rules for Claude: no hard-coded strings beyond a bare identifier, no custom colors, no decoration. Where text or a button is needed, leave a clearly named widget file (for example `add_to_cart_button.dart`) with its `onPressed` wired, and leave the look to you.

## 3. Assumptions and Open Decisions (please confirm)

These are my defaults. Change any of them and the plan adapts.

1. **Backend is not chosen yet.** Since you chose Dio, I now assume a **REST API** (your own server or a BaaS with REST endpoints). Firebase's SDKs use their own transport, so Dio would not be used for them. If you still want Firebase for Auth, Storage or push, it can sit beside Dio for those parts only. Every data source sits behind a repository interface (§5), so the backend can be swapped without touching UI or providers. Please tell me which backend you plan to use.
2. **Dashboard is a second entry point in the same repo**, not a separate project. It shares `core/` and models with the customer app. It builds as a web dashboard and can also ship as its own iOS and Android app. Two separate store apps need separate app IDs, names and icons (Flutter flavors: `customer` and `admin`), which is native setup done when the admin app is started.
3. **Use `hive_ce` + `hive_ce_flutter`**, the maintained community fork of the original `hive` package (which is no longer updated). The API is the same.
4. **Auth tokens go in `flutter_secure_storage`, not Hive.** Hive holds non-secret data.
5. **Text inputs need controllers, which normally need a `StatefulWidget`.** Default: add `flutter_hooks` and use `HookConsumerWidget`, so there is no `setState` and no `StatefulWidget`. The alternative is to keep form values in Riverpod notifiers only.
6. **Cosmetics-specific needs (my defaults):** products have **variants** (shade, size), **brand**, **skin/hair type**, **ingredients**, **reviews and ratings**, and stock per variant. Open questions for phase 3: guest checkout allowed? COD (cash on delivery) supported? Returns policy (opened cosmetics are often non-returnable)? Product expiry or batch shown to customers?
7. **Payments, delivery and notifications providers are not chosen.** Needed by phase 3.

## 4. Tech Stack

| Layer | Package |
|---|---|
| State | `flutter_riverpod`, `riverpod_annotation`, `riverpod_generator` |
| Routing | `go_router` |
| Local storage | `hive_ce`, `hive_ce_flutter` (to add) |
| Secure storage | `flutter_secure_storage` (to add) |
| Models | plain Dart classes with `equatable` (no `freezed`, keep it light) |
| Responsive UI | `flutter_screenutil` + our own breakpoints in `core/responsive/` |
| Fonts and icons | `google_fonts`, `amazing_icons` |
| Forms without `setState` | `flutter_hooks` + `hooks_riverpod` (to add, see §3.5) |
| HTTP | `dio` (to add) |
| Backend | REST API, not yet chosen (see §3.1) |
| Tests | `flutter_test`, `mocktail` (to add when tests start) |

## 5. Architecture

**Feature-first, with layers inside each feature.** To work on "cart", open `features/cart/`. Everything about cart lives there.

```
UI (screens, widgets)
   │ ref.watch / ref.read
   ▼
Providers (Riverpod notifiers)      ← all state lives here
   │
   ▼
Repository (abstract + implementation)
   │
   ├── Remote source (backend)
   └── Local source (Hive)
```

Rules:

- UI never talks to a repository or data source directly. It talks to providers.
- Providers never import widgets.
- A feature never imports another feature's `presentation/` or `data/`. It may only use another feature's **provider** or **model**. If two features share more, move it to `core/`.
- One class or widget per file. Aim for **under 200 lines per file**. Screens are split into small widgets (§6, "Splitting screens into widgets").

## 6. Folder Structure

```
irispharma/
├── docs/
│   └── PROJECT_PLAN.md              ← this file
├── assets/
│   ├── images/
│   ├── icons/
│   └── fonts/
├── lib/
│   ├── main.dart                    ← customer app entry (mobile + web)
│   ├── main_admin.dart              ← admin entry (web dashboard + admin mobile app)
│   │
│   ├── app/                         ← app shell, wired once
│   │   ├── app.dart                 ← MaterialApp.router
│   │   ├── bootstrap.dart           ← Hive init, ProviderScope, error hooks
│   │   ├── router/
│   │   │   ├── app_router.dart      ← customer GoRouter (provider)
│   │   │   ├── admin_router.dart    ← dashboard GoRouter (provider)
│   │   │   ├── route_paths.dart     ← all path constants
│   │   │   └── route_guards.dart    ← auth / role redirects
│   │   └── theme/
│   │       ├── app_theme.dart
│   │       ├── app_colors.dart
│   │       └── app_text_styles.dart
│   │
│   ├── core/                        ← shared, feature-independent
│   │   ├── constants/               ← api paths, box names, sizes, strings
│   │   ├── errors/                  ← failures, exceptions
│   │   ├── network/
│   │   │   ├── dio_client.dart      ← the one Dio instance (base URL, timeouts)
│   │   │   ├── interceptors/        ← auth token, refresh, logging, retry
│   │   │   └── api_endpoints.dart   ← all endpoint paths
│   │   ├── storage/
│   │   │   ├── hive_service.dart    ← open boxes, register adapters
│   │   │   ├── hive_boxes.dart      ← box name + type registry
│   │   │   └── secure_storage.dart  ← tokens
│   │   ├── responsive/              ← breakpoints, ResponsiveBuilder
│   │   ├── extensions/              ← context, string, num helpers
│   │   ├── utils/                   ← formatters, validators, debouncer
│   │   ├── providers/               ← app-wide providers (connectivity, locale)
│   │   └── widgets/                 ← reusable UI (buttons, fields, loaders)
│   │
│   ├── features/                    ← CUSTOMER app features
│   │   ├── auth/
│   │   ├── home/
│   │   ├── catalog/                 ← categories, product list, product detail
│   │   ├── search/
│   │   ├── cart/
│   │   ├── checkout/
│   │   ├── orders/
│   │   ├── wishlist/
│   │   ├── reviews/                 ← ratings and written reviews
│   │   ├── brands/
│   │   ├── profile/                 ← account, addresses
│   │   ├── notifications/
│   │   └── settings/
│   │
│   └── admin/                       ← DASHBOARD features
│       ├── shell/                   ← sidebar, top bar, responsive layout
│       └── features/
│           ├── dashboard/           ← KPIs and charts
│           ├── products/            ← CRUD, images, pricing
│           ├── inventory/           ← stock per variant, low-stock alerts
│           ├── orders/              ← process, status, refunds
│           ├── reviews/             ← moderate ratings and reviews
│           ├── customers/
│           ├── coupons/
│           └── staff/               ← roles and permissions
│
├── test/                            ← mirrors lib/ one-to-one
├── android/  ios/  web/             ← platform code (touch only for platform tasks)
└── pubspec.yaml
```

### Inside every feature (same shape everywhere)

```
features/cart/
├── data/
│   ├── models/
│   │   └── cart_item.dart
│   ├── cart_repository.dart         ← abstract interface
│   ├── cart_repository_impl.dart
│   ├── cart_remote_source.dart
│   └── cart_local_source.dart       ← Hive
├── providers/
│   ├── cart_provider.dart           ← @riverpod Notifier (+ generated .g.dart)
│   └── cart_totals_provider.dart
└── presentation/
    ├── screens/
    │   └── cart_screen.dart
    └── widgets/
        ├── cart_list/                   ← widgets used by cart_screen, grouped by screen
        │   ├── cart_item_tile.dart
        │   ├── cart_item_quantity.dart
        │   └── cart_empty_view.dart
        └── cart_summary/
            ├── cart_summary_card.dart
            ├── cart_price_row.dart
            └── cart_checkout_button.dart
```

Only create a folder when the feature needs it. A small feature may have no `local_source`.

### Splitting screens into widgets

A screen file only **assembles** widgets. It holds no styling detail and no long widget trees.

1. Every visual section of a screen becomes its own widget file in that feature's `presentation/widgets/`. Example: `product_detail_screen.dart` only lists `ProductImageGallery`, `ProductInfoHeader`, `ProductPriceBlock`, `ProductAddToCartBar`.
2. Once a screen has more than ~4 widget files, group them in a subfolder named after the screen or section (`widgets/cart_list/`, `widgets/cart_summary/`).
3. A widget is its own class in its own file. **Do not use helper methods that return widgets** (`Widget _buildHeader()`). They rebuild with the parent and cannot be `const`.
4. Widgets used by **one feature** live in that feature's `widgets/`. Widgets used by **two or more features** move to `core/widgets/` (buttons, text fields, loaders, empty and error views, product card).
5. Give widgets only the data they need (a `Product`, not the whole state) and callbacks for actions. Widgets that need state read their own provider with `ref.watch(...select(...))`.
6. Target: `build` under ~40 lines, widget file under ~100 lines, screen file under ~80 lines.
7. Use `const` constructors wherever possible.
8. **Layout per screen size.** A screen file only holds a `ResponsiveBuilder` that picks `<screen>_mobile.dart` or `<screen>_desktop.dart` from `widgets/<screen>/`. Tablet uses the mobile layout until a `<screen>_tablet.dart` is added. Both layouts reuse the same small widgets, so nothing is written twice.

### Clean code rules

- **Single responsibility.** A screen shows, a provider holds state, a repository fetches or saves, a remote source calls Dio, a local source calls Hive. If a file does two of these, split it.
- **Dependencies point inward.** UI → providers → repositories → sources (§5). Never the reverse.
- **Small functions.** One job each, about 20 lines or fewer. Prefer early returns over deep nesting.
- **Names say what and why.** `isOutOfStock`, not `flag2`. Booleans read like questions (`isLoading`, `hasDiscount`). No abbreviations except common ones (`id`, `url`).
- **No magic values.** Colors, spacing, radii, durations, strings, box names and endpoints come from constants (`app_colors.dart`, `app_sizes.dart`, `hive_boxes.dart`, `api_endpoints.dart`).
- **No duplication.** The second copy of a piece of UI or logic is the signal to extract it. Do not extract on the first use.
- **Repository interfaces** are what providers depend on, so implementations can be swapped and mocked.
- **Errors are typed.** Remote sources return our `Failure` types. Never `catch (e)` and ignore it.
- **Comments explain why, not what.** Well-named code needs no "what" comment.
- **Dead code is deleted**, not commented out.
- **Logging: use `AppLog`, never `print`.** Full standard below.
- **No business logic in widgets.** Formatting, totals and validation live in providers, models or `core/utils/`.
- **Follow `analysis_options.yaml`.** Turn on `prefer_const_constructors`, `avoid_print`, `always_declare_return_types`, and `directives_ordering`. Imports are ordered: dart, flutter, packages, then project (relative imports within a feature).

### Logging standard

One logger, one format, one tag list. Code: `lib/core/logging/`.

**Format.** Every line is `[tag] HH:mm:ss.mmm LEVEL message`, for example:
```
[http]    14:03:22.451 INFO  → GET https://api.example.com/products
[http]    14:03:22.601 INFO  ← 200 GET https://api.example.com/products (150ms)
[router]  14:03:23.010 INFO  → /products/42
[cart]    14:03:24.118 ERROR load cart failed
```
Prints in debug builds only. `AppLog.minLevel` hides lower levels.

**Tags.** Only tags from `LogTag` (`log_tag.dart`). Add a tag there before using it. System tags (`http`, `riverpod`, `router`, `storage`, `error`) are written by the core. Each feature uses its own tag (`cart`, `catalog`, and so on).

**Levels.**

| Level | Use for |
|---|---|
| `d` DEBUG | Detail useful while building: cache hit or miss, parsed counts, provider changes |
| `i` INFO | Normal events worth seeing: a request, a page change, "order placed" |
| `w` WARN | Unexpected but handled: retry, fallback to cache, empty result that should not be empty |
| `e` ERROR | Something failed. Always pass `error:` and `stackTrace:` |

**Message style.** Start with a verb and the thing: `load cart`, `add item id=42`, `load cart failed`. Put values as `key=value`. Keep it on one line. Use `AppLog.short(value)` for anything that could be long.

**Who logs what (each event is logged once, in one place).**

| Layer | Logs |
|---|---|
| Dio interceptor | Every request, response and error (`http`). Automatic. |
| Riverpod observer | Every provider create, change, fail, dispose (`riverpod`). Automatic. |
| Router | Every page change (`router`). Automatic. |
| Bootstrap | Startup steps and uncaught errors (`storage`, `error`). Automatic. |
| Repository | Feature decisions: cache hit or miss, fallback, merge (`d` or `i`) and the failure it converts (`e`). |
| Provider / notifier | Only user actions worth tracing (`add item`, `checkout started`). State changes are already logged by the observer. |
| Widgets | **Nothing.** No logs in `build` or widget files. |

**Feature usage.** Create one scoped logger per file:
```dart
final _log = AppLog.scope(LogTag.cart);
_log.i('add item id=$id qty=$qty');
_log.e('load cart failed', error: e, stackTrace: st);
```

**Never log** passwords, tokens, payment data or full personal details. The HTTP logger already skips bodies of login, register and refresh calls and never prints the `Authorization` header.

### Naming (so a file can be found without searching)

| Thing | Pattern | Example |
|---|---|---|
| File | `snake_case.dart`, named after the class | `cart_item_tile.dart` → `CartItemTile` |
| Screen | `<name>_screen.dart` | `product_detail_screen.dart` |
| Provider | `<name>_provider.dart` | `cart_provider.dart` → `cartProvider` |
| Repository | `<name>_repository.dart` / `_impl.dart` | |
| Model | `<name>.dart` in `data/models/` | `product.dart` |
| Route path | constant in `route_paths.dart` | `RoutePaths.productDetail` |
| Hive box | constant in `hive_boxes.dart` | `HiveBoxes.cart` |
| Test | same path under `test/`, suffix `_test.dart` | `test/features/cart/providers/cart_provider_test.dart` |

## 7. State Management Rules (Riverpod, no `setState`)

1. **`setState` and `StatefulWidget` are not allowed.** Screens are `ConsumerWidget` (or `HookConsumerWidget` when they need controllers). CI check: `grep -rn "setState\|extends StatefulWidget" lib/` must return nothing.
2. Use the code generator: `@riverpod` classes and functions. No hand-written `StateNotifierProvider`.
3. **Async data → `AsyncValue`.** Render with `.when` (loading / error / data). Never use manual `isLoading` booleans.
4. **UI-only state** (selected tab, filter chips, password visibility, quantity stepper) goes in a small `autoDispose` provider next to the screen, or in a hook. It does not belong in a widget.
5. **Read vs watch:** `ref.watch` in `build`. `ref.read` only in callbacks (`onPressed`, etc.). Use `ref.listen` for side effects (snackbars, navigation).
6. **Use `select`** to rebuild on one field only: `ref.watch(cartProvider.select((c) => c.count))`.
7. Repositories are exposed through providers, so tests can override them.
8. State classes are immutable (`equatable`, `copyWith`). Notifiers replace state, they never mutate it.
9. Keep `build` methods small. Extract widgets into their own files in the feature's `presentation/widgets/`, not into helper methods (§6).

## 8. Routing Rules (go_router)

- The router is a Riverpod provider (`goRouterProvider`), so it can watch auth state and redirect.
- **All paths live in `route_paths.dart`.** No string literals in screens.
- Use typed helpers or named routes: `context.goNamed(...)` / `context.push(...)`.
- Redirects live in `route_guards.dart`: logged-out users go to login, non-staff users cannot enter admin routes, and the deep link is remembered and restored after login.
- Use `StatefulShellRoute` for the bottom navigation on mobile and the sidebar on the dashboard, so each tab keeps its own stack.
- Web needs real URLs: `/products/:id`, `/orders/:id`, `/category/:slug`. Use path URL strategy (no `#`).
- Deep links and universal links (iOS and Android) map to the same routes.

## 9. Local Storage Rules (Hive)

### 9.1 HTTP rules (Dio)

- **One `Dio` instance**, created in `dio_client.dart` and exposed as a Riverpod provider (`dioProvider`). Nobody calls `Dio()` elsewhere.
- Only **remote sources** (`*_remote_source.dart`) use Dio. Providers and UI never do.
- Endpoint paths live in `api_endpoints.dart`, not in remote sources.
- Interceptors: attach the access token (read from secure storage), refresh on `401` once then retry, log in debug builds only, retry idempotent `GET`s on network errors.
- Set `connectTimeout`, `receiveTimeout` and `sendTimeout` in one place.
- Convert `DioException` into our own `Failure` types (`core/errors/`) inside the remote source, so the rest of the app never sees Dio types.
- Use `CancelToken` for search-as-you-type so stale requests are cancelled.
- Base URL comes from `--dart-define` per environment (dev, staging, prod), never hard-coded.

### 9.2 Hive

Hive is for **cache and preferences**. The backend is the source of truth.

| Box | Holds | Lifetime |
|---|---|---|
| `settings` | theme, locale, onboarding seen | permanent |
| `cart` | guest cart, synced on login | until checkout |
| `wishlist` | product ids | permanent |
| `recent_searches` | last ~10 queries | permanent |
| `catalog_cache` | categories, product pages, with a `cachedAt` timestamp | TTL, e.g. 1 hour |
| `session` | non-secret user profile snapshot | until logout |

Rules:

- Boxes are opened **once** in `bootstrap.dart` through `hive_service.dart`. Nowhere else calls `Hive.openBox`.
- Only local sources touch Hive. Providers and UI never do.
- Every stored type has a versioned `TypeAdapter`. Bump the version on a schema change and write a migration.
- Never store tokens, passwords or payment data in Hive. Use secure storage.
- Use encrypted boxes for anything containing personal data (address, phone, order history).
- Clear user-specific boxes on logout.

## 10. Roadmap

Each phase ends with something runnable.

| Phase | Deliverable | Notes |
|---|---|---|
| **0. Foundation** ✅ done | Theme stubs, router + tab shell, Hive init, Dio client, token storage, error types, responsive helpers, lint rules, `AsyncValueView` | Both `main.dart` and `main_admin.dart` build for web. Screens are empty skeletons. |
| **1. Browse** | Home, categories, product list, product detail, search | Read-only. Hive catalog cache. |
| **2. Account** | Auth (sign up, login, logout, password reset), profile, addresses | Route guards go live. |
| **3. Buy** | Cart, wishlist, checkout, payment, reviews | Needs checkout rules and payment provider (§3.6, §3.7). |
| **4. Orders** | Order history, tracking, reorder, notifications | |
| **5. Dashboard** | Admin shell, products, inventory, orders, customers, coupons, KPIs | Staff roles and permissions first. |
| **6. Release** | Performance pass, accessibility, SEO for web, store listings, CI/CD | |

## 11. Quality Gates (before any phase is called done)

- `dart analyze` clean, `dart format` applied.
- No `setState` / `StatefulWidget` (§7.1).
- Providers have unit tests. Critical screens have widget tests.
- Layout checked at phone, tablet and desktop widths.
- No file over ~200 lines without a reason. No `Widget _build...()` helper methods. Screens only assemble widgets from `presentation/widgets/` (§6).

---

## 12. Token Optimization Rules (for AI assistants working in this repo)

The goal: spend tokens only on the files the task needs. The folder structure in §6 is designed so the right path can be **derived from the feature name**, with no searching.

### 12.1 Find, don't browse

1. **Do not scan the repo.** Do not run `ls -R`, `find .`, or read directories to "get context."
2. **Derive the path from §6.** "Fix cart total" → `lib/features/cart/providers/cart_totals_provider.dart`. Go straight there.
3. If the path is unknown, use `Grep` for a symbol or a string. Do not read files to look for it.
4. If `graphify-out/` exists, query the graph first instead of reading source.
5. Work inside **one feature folder** per task. Do not open other features unless the task crosses them.

### 12.2 Read narrowly

6. **Never read a whole file when you need a part.** Use `Read` with `offset` and `limit`, or `Grep -n` with a few lines of context.
7. **Do not re-read** a file you just edited, or one already read in this session. The edit tool reports failure.
8. Do not read `docs/PROJECT_PLAN.md` in full each time. Read only the section you need (§6 for paths, §7 state rules, §8 routing, §9 Hive).
9. **Never read these** (generated, vendored, or irrelevant to app logic):
   - `*.g.dart`, `*.freezed.dart`, `*.gr.dart`
   - `pubspec.lock`, `.dart_tool/`, `build/`, `.idea/`
   - `ios/Pods/`, `ios/Runner.xcodeproj/`, `android/.gradle/`, `android/build/`
   - `macos/`, `linux/`, `windows/`
   - `android/`, `ios/`, `web/` **unless the task is platform-specific**
   - images, fonts, and other binary assets
10. To know a generated provider's name, read the annotated source file (`cart_provider.dart`), not the `.g.dart`. The naming rule is: `CartNotifier` → `cartProvider`.

### 12.3 Write small, write once

11. Keep files small (§5). A 150-line file costs a fraction of a 900-line file every time it is read.
12. One widget or class per file, so an edit reads one small file instead of a large one.
13. Use `Edit` for changes. Do not rewrite a whole file to change a few lines.
14. Do not create README, notes or summary files that were not asked for.

### 12.4 Run commands cheaply

15. **Scope commands to what changed.**
    - `dart analyze lib/features/cart` (not the whole project)
    - `flutter test test/features/cart` (not the whole suite)
    - `dart format <changed files>`
16. Run `build_runner` **only** when an annotated file changed. Use `dart run build_runner build --delete-conflicting-outputs`, and pass `watch` only when actively iterating.
17. Trim noisy output: pipe to `| tail -n 30` or `| head -n 50`. Do not dump full build logs into the conversation.
18. Do not run a full app build or `flutter clean` to check a small change. Analyze and run the targeted test.

### 12.5 Work style

19. **Batch independent tool calls** in one step (for example, read two files together).
20. Do not spawn sub-agents for lookups that one `Grep` can answer.
21. Do not restate the plan, or re-derive decisions already made in §2 and §3. Follow them.
22. Keep replies short: what changed, where, and anything that needs a decision. No long recaps of code that is visible in the diff.
23. Ask one specific question when blocked. Do not explore to guess.

### 12.6 Session hygiene (for the developer)

24. Start a fresh session (`/clear`) when switching to an unrelated feature. Long sessions re-send their whole history on every turn.
25. Use `/compact` in long sessions on one feature.
26. Give the task as a path plus a goal ("in `features/cart/providers/`, add coupon support") so no searching is needed.
27. Use a smaller model for mechanical work (renames, formatting, boilerplate) and a larger one for design and debugging.
28. Keep `CLAUDE.md` short. It loads on every turn. It should contain only the rules from §12.1 to §12.4 in a few lines, and point here for detail.

### 12.7 Optional: block wasteful reads at the tool level

Add to `.claude/settings.json` so generated and vendored paths cannot be read by accident:

```json
{
  "permissions": {
    "deny": [
      "Read(**/*.g.dart)",
      "Read(**/*.freezed.dart)",
      "Read(pubspec.lock)",
      "Read(.dart_tool/**)",
      "Read(build/**)",
      "Read(ios/Pods/**)",
      "Read(android/.gradle/**)",
      "Read(macos/**)",
      "Read(linux/**)",
      "Read(windows/**)"
    ]
  }
}
```
