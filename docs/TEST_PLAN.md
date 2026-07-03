# Test Plan — FilmPack App

## 1. Overview

| Field         | Details                     |
|---------------|-----------------------------|
| App Name      | FilmPack                    |
| Version       | 1.0.0                       |
| Date          | 07/01/2026                  |
| Tester        | Aaron Villalobos            |
| Objective     | Validate core 'FilmPack' creation and feed functionality through manual testing |

---

## 2. Scope

### In Scope
- FilmPack creation flow (photo selection, title, caption, submission)
- Feed display and scrolling
- Local data persistence
- Edge cases and input validation

### Out of Scope
- Networking / backend integration
- Authentication
- Third-party integrations

---

## 3. Test Environment

| Field         | Details              |
|---------------|----------------------|
| Device        | iPhone 15 Pro        |
| iOS Version   | iOS 26.5             |
| Xcode Version | 26.3                 |
| App Version   | 1.0.0                |
| Date Tested   | 07/01/2026           |

---

## 4. FilmPack Creation Test Cases

| TC-ID  | Title                                        | Precondition                              | Steps                                                                                                      | Expected Result                                                   | Actual Result | Status          | Notes |
|--------|----------------------------------------------|-------------------------------------------|------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------|---------------|-----------------|-------|
| TC-001 | Create FilmPack with 1 photo                 | App open, 1+ photo in library             | 1. Tap "+" 2. Select 1 photo from library 3. Add title "Sample" 4. Add caption "Test" 5. Tap "Checkmark"| FilmPack appears in feed with correct title, caption, and 1 photo    | FilmPack appears in feed with correct title, date, caption, and 1 photo              | Pass | The feed itself consists of previews of the full FilmPack with the title, date, and photo.     |
| TC-002 | Submit with no title                         | App open, 1+ photo selected               | 1. Tap "+" 2. Select 1 photo 3. Leave title empty 4. Add caption 5. Tap "Checkmark"              | "Checkmark" button is disabled                        | "checkmark" button is disabled             | Pass  |       |
| TC-003 | Submit with no caption                       | App open, 1+ photo selected               | 1. Tap "+" 2. Select 1 photo 3. Add title 4. Leave caption empty 5. Tap "Checkmark"              | FilmPack appears in feed with correct title, no caption, and 1 photo                        | FilmPack appears in feed with correct title, no caption, and 1 photo              | Pass |       |
| TC-004 | Submit with no photos selected               | App open                                  | 1. Tap "+" 2. Skip photo selection 3. Add title and caption 4. Tap "Checkmark"                   | "Checkmark" button is disabled                        | "Checkmark" is not disabled; app crashes              | Fail |       |
| TC-005 | Submit with title and caption both empty     | App open, 1+ photo selected               | 1. Tap "+" 2. Select 1 photo 3. Leave title and caption empty 4. Tap "Checkmark"                 | "Checkmark" button is disabled, submission blocked        | "Checkmark" button is disabled, submission blocked              | Pass |       |
| TC-006 | Add maximum number of photos allowed (8)         | App open, photo library has max+ photos   | 1. Tap "+" 2. Select exactly the max number of photos 3. Add title and caption 4. Tap "Checkmark" | FilmPack created successfully with all photos, title, caption, and date                     | FilmPack created successfully with all photos, title, caption, and date              | Pass |       |
| TC-007 | Exceed maximum photo limit                   | App open, photo library has max+ photos   | 1. Tap "+" 2. Attempt to select more than the max allowed photos                             | Selection capped or error shown, cannot exceed limit              | Selection capped, cannot select more than 8 photos          | Pass  |       |
| TC-008 | Title at maximum character limit (20)            | App open, 1+ photo selected               | 1. Tap "+" 2. Select 1 photo 3. Enter title at exact character limit 4. Tap "Checkmark"          | FilmPack created successfully                                      |  FilmPack created successfully             | Pass |       |
| TC-009 | Title exceeds character limit                | App open, 1+ photo selected               | 1. Tap "+" 2. Select 1 photo 3. Attempt to type past character limit in title field          | Input capped                                       | Input capped              | Pass |       |
| TC-010 | Caption at maximum character limit (50)           | App open, 1+ photo selected               | 1. Tap "+" 2. Select 1 photo 3. Enter title 4. Enter caption at exact character limit 5. Tap "Checkmark"        | FilmPack created successfully                                      | FilmPack created successfully               | Pass  |       |
| TC-011 | Caption exceeds character limit              | App open, 1+ photo selected               | 1. Tap "+" 2. Select 1 photo 3. Attempt to type past character limit in caption field        | Input capped                                       | Input capped          | Pass |       |
| TC-012 | Cancel mid-creation flow                     | App open                                  | 1. Tap "+" 2. Select photos, add title and caption 3. Tap "X"                           | No FilmPack saved, feed unchanged, shows "Discard Park"                                  |  No FilmPack saved, feed unchanged, shows "Discard Park"             | Pass |       |
| TC-013 | Add photos, remove one, then submit          | App open, 3+ photos in library            | 1. Tap "+" 2. Select 3 photos 3. Remove 1 photo 4. Add title and caption 5. Tap "Checkmark"     | FilmPack created with only the 2 remaining photos                  | FilmPack created with only the 2 remaining photos              | Pass |       |
| TC-014 | Create multiple FilmPacks back to back        | App open                                  | 1. Create and share FilmPack A 2. Immediately create and share FilmPack B                                   | Both FilmPacks appear in feed with correct data in correct order           | Both FilmPacks appear in feed with correct data in correct order              | Pass |       |
| TC-015 | FilmPacks persists after app relaunch          | 1+ FilmPack already created                | 1. Create and share a FilmPack 2. Force quit app 3. Relaunch app 4. Navigate to feed                       | FilmPack still visible in feed with correct title, caption, photos, and date | FilmPack still visible in feed with correct title, caption, photos, and date              | Pass |       |

---

## 5. Feed Test Cases

| TC-ID  | Title                                              | Precondition                        | Steps                                                                                   | Expected Result                                                    | Actual Result | Status          | Notes |
|--------|----------------------------------------------------|-------------------------------------|-----------------------------------------------------------------------------------------|--------------------------------------------------------------------|---------------|-----------------|-------|
| TC-016 | Feed displays empty state with 0 filmpacks          | No filmpacks created                 | 1. Open app 2. Navigate to feed                                                         | Empty state message shown (e.g. "No FilmPacks yet - Create a FilmPack to start seeing your Polaroids")                 | Empty state message shown (e.g. "No FilmPacks yet - Create a FilmPack to start seeing your Polaroids")              | Pass |       |
| TC-017 | Feed displays correctly with 1 FilmPack             | 1 filmpack created                   | 1. Navigate to feed                                                                     | FilmPack card shows correct title, date, and photo               | FilmPack card shows correct title, date, and photo              | Pass |       |
| TC-018 | Feed displays correctly with 5 FilmPacks            | 5 filmpacks created                  | 1. Navigate to feed 2. Scroll through all photos                                         | All 5 FilmPacks render correctly                                     | All 5 FilmPacks render correctly        | Pass  |       |
| TC-019 | Feed displays correctly with 10+ FilmPacks          | 10+ filmpacks created                | 1. Navigate to feed 2. Scroll through all photos                                         | All FilmPacks render correctly, no missing or duplicate cards       | All FilmPacks render correctly, no missing or duplicate cards              | Pass |       |
| TC-020 | FilmPacks appear in reverse chronological order     | 3+ filmpacks created                 | 1. Create FilmPack A, then B, then C 2. Navigate to feed                                 | Feed order: C → B → A (newest first)                               | Feed order: A → B → C (newest last)               | Fail |       |
| TC-021 | FilmPack title and caption display correctly        | 1+ filmpack created                  | 1. Navigate to feed 2. Inspect filmpack card                                             | Title and caption match what was entered during creation           | Title and caption match what was entered during creation              | Pass |       |
| TC-022 | FilmPack photos render correctly on feed card       | 1+ filmpack created with photos      | 1. Navigate to feed 2. Inspect filmpack card photos                                      | Photos display in polaroid frame style without distortion          |  Photos display in polaroid frame style without distortion             | Pass |       |
| TC-023 | Scroll through feed with 20+ filmpacks smoothly     | 20+ filmpacks created                | 1. Navigate to feed 2. Scroll from top to bottom continuously                           | No lag, freezing, or dropped frames during scrolling               |  No lag, freezing, or dropped frames during scrolling         | Pass |       |
| TC-024 | Feed persists after app relaunch                   | 1+ filmpack created                  | 1. Create filmpacks 2. Force quit app 3. Relaunch 4. Navigate to feed                   | All previously created filmpacks still visible                      | All previously created filmpacks still visible              | Pass  |       |
| TC-025 | Feed updates immediately after new filmpack created | Feed open with existing filmpacks    | 1. Create a new filmpack 2. Share to feed 3. Navigate to feed                            | New filmpack appears at top of feed without requiring app restart   | New filmpack appears at top of feed without requiring app restart     | Pass  |       |

---

## 6. Test Summary Log

| Metric              | Result |
|---------------------|--------|
| Total Test Cases    | 25     |
| Passed              | 23     |
| Failed              | 2      |
| Blocked             | 0      |
| Pass Rate           | 92     |
| Bugs Found          | 2      |
| Bugs Resolved       | 1      |

---

## 7. Bug Log

| Bug-ID  | TC-ID  | Description | Severity               | Steps to Reproduce | Expected Result | Actual Result | Status                        | Notes |
|---------|--------|-------------|------------------------|--------------------|-----------------|---------------|-------------------------------|-------|
| 001     | TC-004 | App crashes when a FilmPack without a photo is submitted            | Critical | 1. Tap "+" 2. Skip photo selection 3. Add title and caption 4. Tap "Checkmark"  | "Checkmark" button is disabled                | "Checkmark" is not disabled; app crashes when submitted     | Resolved |       |
| 002     | TC-020 | FilmPacks appear in chronological order instead of reverse           | Minor |  1. Create FilmPack A, then B, then C 2. Navigate to feed                | Feed order: C → B → A (newest first)                |  Feed order: A → B → C (newest last)   | Open |       |

### Severity Guide
| Level    | Definition                              |
|----------|-----------------------------------------|
| Critical | App crashes or data is lost             |
| Major    | Feature broken but app does not crash   |
| Minor    | Visual or cosmetic issue only           |
