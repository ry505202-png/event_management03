# Security Policy

## Vulnerability Audit & Status

As of October 2026, automated audits with `npm audit` and `npm audit --omit=dev` report:

```
found 0 vulnerabilities
```

- **Production Dependencies (`npm audit --omit=dev`)**: 0 Critical, 0 High, 0 Moderate, 0 Low.
- **Development Dependencies (`npm audit`)**: 0 Critical, 0 High, 0 Moderate, 0 Low.

## Resolved Advisories

The following 6 vulnerabilities previously identified in devDependencies were resolved by updating direct devDependencies (`vite`, `vitest`, and `@vitest/coverage-v8`) to their patched releases:

| Package               | Advisory / GHSA                                                                                                                                    | Severity        | Resolution                                      | Type                  |
| --------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------- | --------------- | ----------------------------------------------- | --------------------- |
| `vitest`              | [GHSA-5xrq-8626-4rwp](https://github.com/advisories/GHSA-5xrq-8626-4rwp)                                                                           | Critical        | Upgraded to `vitest@^4.1.12`                    | Dev-only              |
| `@vitest/coverage-v8` | Dependent on vulnerable Vitest (`<=3.2.5`)                                                                                                         | Critical        | Upgraded to `@vitest/coverage-v8@^4.1.12`       | Dev-only              |
| `vite`                | [GHSA-587h-7wmj-h5pm](https://github.com/advisories/GHSA-587h-7wmj-h5pm) & related path traversal advisories                                       | High / Moderate | Upgraded to `vite@^6.4.5`                       | Dev-only              |
| `@vitest/mocker`      | [GHSA-82fw-gwwq-j7x9](https://github.com/advisories/GHSA-82fw-gwwq-j7x9), [GHSA-qxg6-89mg-rqv8](https://github.com/advisories/GHSA-qxg6-89mg-rqv8) | Moderate        | Upgraded via `vitest@^4.1.12`                   | Dev-only (transitive) |
| `vite-node`           | Dependent on vulnerable Vite                                                                                                                       | Moderate        | Upgraded via `vitest@^4.1.12`                   | Dev-only (transitive) |
| `esbuild`             | [GHSA-67mh-4wv8-2f99](https://github.com/advisories/GHSA-67mh-4wv8-2f99)                                                                           | Moderate        | Upgraded to `esbuild@^0.25.0` via `vite@^6.4.5` | Dev-only (transitive) |

## Reporting Security Issues

To report a vulnerability or security concern, please open a private report or contact the maintainers directly.
