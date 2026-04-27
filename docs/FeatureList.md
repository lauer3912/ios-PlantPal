# PlantPal - AI Plant Care Assistant

## Concept
PlantPal uses AI to help users identify plants, get personalized care guides, track watering schedules, and connect with a community of plant lovers. Target: **欧美市场** (US/EU plant parents).

## Category
- **Primary:** Lifestyle / Utilities
- **Secondary:** Health & Fitness (mental wellness through plant care)

## Monetization
- **Free tier:** 3 plant identifications/month, basic care reminders
- **Premium:** $4.99/month or $39.99/year
  - Unlimited AI identifications
  - Advanced plant health analysis
  - Personalized care plans
  - Ad-free experience
  - Priority support

---

## Feature List (66 Total)

### 🌿 P0 - Core Features (50)

| # | Feature | Description | Priority |
|---|---------|-------------|----------|
| 1 | AI Plant Identification | Snap/photo plant → AI identifies species with 95%+ accuracy | P0 |
| 2 | Care Guide Database | Comprehensive care info for 10,000+ plants | P0 |
| 3 | Watering Reminder | Smart notifications based on plant needs + user schedule | P0 |
| 4 | Plant Profile | Name, photo, species, location, birthdate per plant | P0 |
| 5 | Care Calendar | Visual calendar showing all care tasks | P0 |
| 6 | Light Requirements | Track and get alerts for light needs | P0 |
| 7 | Humidity Tracking | Humidity level recommendations + alerts | P0 |
| 8 | Temperature Monitoring | Ideal temp range per plant + weather integration | P0 |
| 9 | Fertilizing Schedule | Auto-calculated fertilizing reminders | P0 |
| 10 | Repotting Alerts | Track pot size, suggest repotting timing | P0 |
| 11 | Pest Detection | AI analyze photo → identify pests + solutions | P0 |
| 12 | Health Score | Weekly plant health assessment (1-100) | P0 |
| 13 | Growth Tracker | Log height, leaves count, growth milestones | P0 |
| 14 | Photo Timeline | Auto-gallery of plant photos by date | P0 |
| 15 | Quick Actions | One-tap "Watered", "Fertilized", "Moved" logging | P0 |
| 16 | Search Plants | Search by name, care difficulty, light needs | P0 |
| 17 | Browse by Room | Plants organized by room (bedroom, bathroom, kitchen) | P0 |
| 18 | Care Difficulty Filter | Easy/Medium/Expert filter | P0 |
| 19 | Pet-Safe Filter | Show only non-toxic plants for pets | P0 |
| 20 | Light Level Filter | Low/Medium/Bright/Direct light filter | P0 |
| 21 | Search History | Recent searches quick access | P0 |
| 22 | Favorites | Save plants to favorites list | P0 |
| 23 | Plant Nicknames | Custom names for each plant | P0 |
| 24 | Multiple Plant Support | Track unlimited plants | P0 |
| 25 | Today's Tasks | Dashboard showing today's care tasks | P0 |
| 26 | Overdue Alerts | Notification for missed care tasks | P0 |
| 27 | Weather Integration | Adjust reminders based on local forecast | P0 |
| 28 | Dark Mode | Full dark theme support | P0 |
| 29 | Light Mode | Clean light theme | P0 |
| 30 | System Theme | Auto-follow iOS appearance | P0 |
| 31 | Offline Access | All care guides available offline | P0 |
| 32 | iCloud Sync | Sync across devices via iCloud | P0 |
| 33 | Widget - Next Care | Home screen widget showing next task | P0 |
| 34 | Widget - Plant Count | Quick stats widget | P0 |
| 35 | Haptic Feedback | Tactile feedback on actions | P0 |
| 36 | Accessibility - VoiceOver | Full VoiceOver support | P0 |
| 37 | Accessibility - Dynamic Type | Scalable text throughout | P0 |
| 38 | Accessibility - Color Contrast | WCAG AA compliant | P0 |
| 39 | Onboarding Flow | 3-screen intro + plant add tutorial | P0 |
| 40 | Push Notifications | Care reminders, tips, growth milestones | P0 |
| 41 | Notification Center | All notifications in one place | P0 |
| 42 | Care Tips Notifications | Weekly tips based on season | P0 |
| 43 | Plant Anniversary | "Your plant is 1 year old!" celebration | P0 |
| 44 | First Watering Reminder | Special guidance for new plants | P0 |
| 45 | Seasonal Alerts | Winter/Summer care adjustments | P0 |
| 46 | Care History Log | Complete log of all care actions | P0 |
| 47 | Export Data | Export plant data as JSON | P0 |
| 48 | Share Plant | Generate beautiful plant card to share | P0 |
| 49 | Plant Gallery | Grid view of all plants with status indicators | P0 |
| 50 | Plant Detail View | Full info + care schedule + history | P0 |

### 🌱 P1 - Enhanced Features (16)

| # | Feature | Description | Priority |
|---|---------|-------------|----------|
| 51 | PlantPal AI Chat | Chat with AI plant expert for advice | P1 |
| 52 | Plant Shop | Browse plant accessories (external links) | P1 |
| 53 | PlantSwap Community | Local plant exchange board | P1 |
| 54 | Care Streak | Daily care streak rewards | P1 |
| 55 | Achievement Badges | "Plant Parent Pro", "Perfect Week" etc. | P1 |
| 56 | Weekly Report | AI-generated plant health summary | P1 |
| 57 | Plant Diagnosis | Upload sick plant photo → AI diagnosis | P1 |
| 58 | Species Comparison | Compare care needs side-by-side | P1 |
| 59 | Care Difficulty Prediction | AI predicts if plant suits lifestyle | P1 |
| 60 | Smart Home Integration | HomeKit light/humidity sensor sync | P1 |
| 61 | Health Trends | Graph plant health over time | P1 |
| 62 | Light Meter | Use camera as light meter | P1 |
| 63 | Humidity Meter | Manual humidity logging | P1 |
| 64 | Plant Name Origin | Fun facts about plant names | P1 |
| 65 | Seasonal Wallpapers | Exclusive plant wallpapers for subscribers | P1 |
| 66 | Expert Consultation | Book 1-on-1 plant expert call | P1 |

---

## Technical Specifications

### Bundle ID
`com.ggsheng.PlantPal`

### Deployment Target
iOS 17.0+

### Architecture
- SwiftUI + UIKit (hybrid)
- MVVM pattern
- Local storage: UserDefaults + SQLite.swift
- Cloud sync: CloudKit

### Dependencies
- SnapKit (Auto Layout)
- Kingfisher (Image caching)
- Lottie (Animations)

### Assets Required
- AppIcon (19 sizes)
- SF Symbols for UI
- 10,000+ plant database (JSON)
- Onboarding illustrations
- Empty state illustrations

---

## Design Direction

### Visual Style
- **Apple Design Awards** level quality
- Clean, organic, nature-inspired
- Rich greens + warm earth tones
- Soft rounded corners (16pt radius)
- Subtle shadows for depth

### Color Palette
| Role | Light | Dark |
|------|-------|------|
| Primary | #22C55E (Emerald) | #4ADE80 |
| Secondary | #84CC16 (Lime) | #A3E635 |
| Accent | #F59E0B (Amber) | #FBBF24 |
| Background | #FAFAF5 (Cream) | #1A1C19 |
| Surface | #FFFFFF | #2D3129 |
| Text Primary | #1F2937 | #F9FAFB |
| Text Secondary | #6B7280 | #9CA3AF |

### Typography
- SF Pro Display (headings)
- SF Pro Text (body)
- Title: 28pt Bold
- Body: 16pt Regular
- Caption: 13pt Regular

### Layout
- Tab-based navigation (4 tabs)
  1. Home (Today's Tasks)
  2. My Plants (Gallery)
  3. Discover (Browse/Search)
  4. Profile (Settings)
- Card-based content
- 8pt grid system
- Bottom sheet for quick actions

---

## Monetization Details

### Free Tier
- 3 AI identifications/month
- 5 plant limit
- Basic care reminders
- Ads enabled

### Premium ($4.99/mo or $39.99/yr)
- Unlimited identifications
- Unlimited plants
- Advanced health analysis
- AI Chat access
- No ads
- Priority support
- Exclusive wallpapers

### In-App Purchase IDs
- `plantpal.premium.monthly` - $4.99
- `plantpal.premium.yearly` - $39.99

---

## Privacy & Compliance

### Data Collection
- Photos used only for plant identification
- No sale of personal data
- GDPR compliant for EU

### Required Permissions
- Camera (plant photos)
- Photo Library (import plant photos)
- Notifications (care reminders)
- Location (weather - optional)
