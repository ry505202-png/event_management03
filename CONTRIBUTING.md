# Contributing & Code Style Guide

Thank you for contributing to **Celebration & Event Planner**! To maintain our top-tier **Code Quality Score of 95+** graded on structure, readability, and maintainability, all contributions must adhere to the following strict engineering standards.

---

## 1. Architectural Standards & Clean Code Rules

### File and Function Length Constraints

- **File Size**: Target **< 150 lines** per file. Top-level layout/orchestrator files must not exceed 250 lines under any circumstance.
- **Function Size**: Every function must be concise and focused on a single responsibility (**< 40 lines**). Break complex logic into pure helper functions.

### Layer Separation & Responsibilities

- **Backend (5 Layers)**:
  - `routes/`: Routing and route-to-controller mapping only. No business logic.
  - `validators/`: Express-validator rules checking query parameters and bodies.
  - `controllers/`: HTTP status code handling, parameter extraction, delegating to services.
  - `services/`: Core business logic, caching, sanitization, and LLM orchestration.
  - `middleware/`: Error handling, rate limiting, and security header injection.
- **Frontend (Separation of Concerns)**:
  - UI components must NOT make direct `fetch()` calls. Always use `apiService.js`.
  - UI components must NOT contain heavy mathematical or timeline calculations. Use pure utilities (`budgetRebalancer.js`, `timelineEngine.js`).
  - State mutations must use pure reducer helpers (`planMutators.js`).

### Centralized Constants & Zero Magic Numbers

- Never hard-code string identifiers, tab names, status codes, default budgets, or palette hex codes in components.
- Always import constants from `shared/constants.js` or dedicated domain catalogs (`client/src/constants/`).

### Logging & Error Handling

- Never use raw `console.log()` or `console.error()` in production code.
- Frontend: Use `logger` from `client/src/utils/logger.js`.
- Backend: Use `serverLogger` from `server/utils/logger.js` (which automatically redacts API keys and secrets).
- Handle errors centrally through `AppError` and `errorHandler.js` on the backend, and `parseApiError` + `ErrorAlert.jsx` on the frontend.

---

## 2. Documentation & JSDoc Requirements

Every exported function, component, hook, and API handler must have complete JSDoc documentation:

```javascript
/**
 * Rebalances category amounts proportionally when a single category is edited.
 *
 * @param {Array<object>} categories - Existing budget categories with current allocations
 * @param {number} totalBudget - Hard budget ceiling
 * @param {string} editedCategoryId - ID of the category being modified
 * @param {number|string} newAmount - New target allocation amount
 * @returns {{ categories: Array<object>, isOverflow: boolean, overflowAmount: number }}
 */
export function rebalanceCategoryAmounts(categories, totalBudget, editedCategoryId, newAmount) { ... }
```

---

## 3. Linting, Formatting & Verification Workflow

Before submitting a pull request or pushing code, run the complete verification suite:

```bash
# 1. Format all code with Prettier
npm run format

# 2. Check for ESLint errors and warnings (must be 0 warnings)
npm run lint

# 3. Verify Zod schemas
npm run verify:schemas

# 4. Run unit and integration tests (both server and client must pass 100%)
npm run test:server
npm run test:client

# 5. Verify production bundle build
npm run build

# 6. Run end-to-end and accessibility tests
npm run test:e2e
```

---

## 4. Accessibility (WCAG 2.1 AA / AAA) Standards

All UI components must be fully accessible:

1. Every interactive element (buttons, tabs, inputs) must have accessible labels (`aria-label`, `aria-labelledby`, or visible text).
2. Modals and drawers must capture focus, announce titles, and close on `Escape` key (`useEscapeKey`).
3. Tab navigation must support keyboard arrows (`ArrowLeft`, `ArrowRight`, `Home`, `End`).
4. Color contrast must meet WCAG AAA ratios (minimum 7:1 for normal text).
5. No automated Axe accessibility violations are permitted in Playwright audits.
