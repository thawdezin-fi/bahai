# app_master_plan.md

## 1. Project Overview

* **App Name:** Baha'i Myanmar (ဘဟာအီ မြန်မာ)
* **Vision:** To provide a comprehensive digital gateway for both seekers (Beginners) and believers (Ultimate) to access Baha'i teachings in the Burmese language.
* **Core Value:** Unity, Peace, and Independent Investigation of Truth.

---

## 2. Target Audience & Content Strategy

| User Type | Needs | Content Focus |
| --- | --- | --- |
| **Beginners (လူသစ်)** | Simple concepts, FAQ, history. | "Introduction to Faith" guides, videos, and basic principles. |
| **Baha'is (အဆင့်မြင့်)** | Holy texts, prayers, calendar. | Kitáb-i-Aqdas, Badi Calendar, Deepening materials. |

---

## 3. App Structure (4-Tab System)

### Tab 1: Home (လမ်းညွှန်)

* **Feature:** Introduction for Newcomers.
* **Content:** * *Daily Bread:* A randomly generated quote from Bahá'u'lláh.
* *The 3 Pillars:* Interactive cards explaining God, Religion, and Humanity.
* *Quick Start:* "ဘဟာအီ ဆိုတာ ဘာလဲ?" (5-minute read).
* *Latest News:* Community updates (Global and Local).



### Tab 2: Library (ဉာဏ်အလင်း)

* **Feature:** Digital Bookstore & Reader.
* **Content:**
* *Beginner Section:* "Paris Talks", "The New Era".
* *Ultimate Section:* "The Hidden Words", "Seven Valleys", "Kitáb-i-Iqán".
* *Functionality:* Search feature (English/Burmese), Bookmark, and Night Mode.



### Tab 3: Spiritual (ဝိညာဉ်ခွန်အား)

* **Feature:** Prayers & Meditation.
* **Content:**
* *Prayer Categories:* Healing, Protection, Unity, Departed.
* *Audio Integration:* Listen to prayers chanted in Burmese or Persian.
* *Obligatory Prayers:* Reminders for daily prayers (Short, Medium, Long).



### Tab 4: Utilities (လက်တွေ့ဘဝ)

* **Feature:** Community Tools & Settings.
* **Content:**
* *Badi Calendar:* Current Baha'i month, day, and upcoming Feast days.
* *Q&A / Support:* Direct contact to local Baha'i institutions.
* *Profile:* User settings and Reading progress.



---

## 4. Technical Architecture (For the Programmer)

* **Framework:** **Flutter** (Recommended for Cross-platform iOS/Android and smooth UI).
* **State Management:** **Riverpod** or **Provider** (Clean and scalable).
* **Database:** * Local: **Hive** or **SQFlite** (For offline reading).
* Cloud: **Firebase Firestore** (For syncing news and daily quotes).


* **Architecture:** **Clean Architecture** (Separation of concerns: Data, Domain, and Presentation).

---

## 5. Development Roadmap (The Sprint Plan)

### Phase 1: Foundation (Zero)

* Setup Flutter environment.
* Design UI/UX Wireframes (Minimalist & Peace-focused).
* Collect Burmese translations for basic prayers and intro texts.

### Phase 2: Core Features (Building)

* Implement **Bottom Navigation Bar**.
* Develop **Library Tab** with PDF/Markdown support.
* Build **Prayer Tab** with category filtering.

### Phase 3: Advanced Features (Ultimate)

* Add **Badi Calendar** logic (Handling 19-day cycles).
* Implement **Offline Support** using Local Database.
* Dark Mode and Typography optimization (Burmese Unicode).

### Phase 4: Launch & Maintenance (Complete)

* Beta testing with local Baha'i community.
* Play Store / App Store deployment.
* Continuous content updates.

---

## 6. Success Metrics

* **Retention:** How often users use the Daily Prayer feature.
* **Engagement:** Number of books read in the Library.
* **Impact:** Increased awareness of Baha'i principles in Myanmar.

---
