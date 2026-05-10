# Elite Home Repairs & Decor

A complete Flutter web application for a home repairs and decoration business. Built with Flutter Web, GoRouter navigation, and Supabase backend integration.

## Features

### Customer Side
- **Home Page** - Hero banner, services preview, stats, projects preview, reviews, CTA
- **Services Page** - Grid of all services with filtering by category
- **Service Detail** - Full service info with features, pricing, and booking CTA
- **Projects/Gallery** - Before/after project showcase with filtering
- **Project Detail** - Full project info, materials, customer review
- **Booking** - Complete booking form with validation
- **Reviews** - Customer reviews with rating distribution
- **Contact** - Contact info, working hours, service areas, social links

### Admin Side
- **Admin Login** - Secure authentication screen
- **Dashboard** - Stats cards, quick actions, recent bookings
- **Manage Services** - Add, edit, delete, toggle services
- **Manage Projects** - Add projects with before/after images, publish/unpublish
- **Manage Bookings** - View, accept, reject, mark progress, complete
- **Manage Comments** - Approve, delete, reply to comments
- **Manage Reviews** - Approve, feature, delete reviews

## Tech Stack

- **Flutter 3.x** - UI Framework
- **GoRouter** - Navigation
- **Supabase** - Backend (Auth, Database, Storage)
- **Google Fonts** - Typography
- **Flutter Animate** - Animations
- **Intl** - Date formatting

## Project Structure

```
lib/
  main.dart                 # Entry point
  app.dart                  # App configuration & routing
  core/
    theme/                  # App colors & theme
    constants/              # App constants
    widgets/                # Reusable widgets
  features/
    home/                   # Home screen
    services/               # Services screens
    projects/               # Projects screens
    booking/                # Booking screens
    reviews/                # Reviews screen
    contact/                # Contact screen
    admin/                  # All admin screens
  models/                   # Data models
  services/                 # API services
```

## Getting Started

### 1. Setup Flutter
```bash
flutter doctor
```

### 2. Install Dependencies
```bash
cd elite_home_repairs
flutter pub get
```

### 3. Configure Supabase
Update `lib/main.dart` with your Supabase credentials:
```dart
await Supabase.initialize(
  url: 'https://your-project.supabase.co',
  anonKey: 'your-anon-key',
);
```

### 4. Run the App
```bash
# For web
flutter run -d chrome

# For mobile
flutter run
```

### 5. Build for Production
```bash
flutter build web --release
```

## Supabase Setup

### Tables Required

1. **services**
   - id (uuid)
   - name (text)
   - description (text)
   - image_url (text)
   - starting_price (numeric)
   - price_text (text)
   - category (text)
   - is_active (boolean)
   - created_at (timestamp)

2. **projects**
   - id (uuid)
   - title (text)
   - description (text)
   - before_image_url (text)
   - after_image_url (text)
   - image_urls (text[])
   - location (text)
   - service_type (text)
   - date_completed (date)
   - likes (int)
   - comments (int)
   - is_published (boolean)
   - created_at (timestamp)

3. **bookings**
   - id (uuid)
   - full_name (text)
   - phone_number (text)
   - whatsapp_number (text)
   - email (text)
   - location (text)
   - service_needed (text)
   - preferred_date (date)
   - preferred_time (text)
   - problem_description (text)
   - image_url (text)
   - status (text)
   - created_at (timestamp)
   - updated_at (timestamp)

4. **reviews**
   - id (uuid)
   - customer_name (text)
   - rating (numeric)
   - review_message (text)
   - service_done (text)
   - date (date)
   - is_approved (boolean)
   - is_featured (boolean)
   - created_at (timestamp)

5. **comments**
   - id (uuid)
   - project_id (uuid)
   - user_name (text)
   - comment (text)
   - is_approved (boolean)
   - reply (text)
   - created_at (timestamp)

6. **admin_users**
   - id (uuid)
   - email (text)
   - created_at (timestamp)

### Storage Bucket
- Create a bucket named `project-images` for image uploads

## Navigation Routes

| Route | Screen |
|-------|--------|
| `/` | Home |
| `/services` | Services List |
| `/services/:id` | Service Detail |
| `/projects` | Projects Gallery |
| `/projects/:id` | Project Detail |
| `/booking` | Booking Form |
| `/booking/success` | Booking Success |
| `/reviews` | Reviews |
| `/contact` | Contact |
| `/admin/login` | Admin Login |
| `/admin/dashboard` | Admin Dashboard |
| `/admin/services` | Manage Services |
| `/admin/projects` | Manage Projects |
| `/admin/projects/add` | Add Project |
| `/admin/bookings` | Manage Bookings |
| `/admin/comments` | Manage Comments |
| `/admin/reviews` | Manage Reviews |

## Screenshots

The app features a modern, professional design with:
- Teal primary color scheme (#1A5F7A)
- Gold accent color (#E8A838)
- Clean card-based layouts
- Smooth animations
- Responsive design for all screen sizes

## License

MIT License - Free for personal and commercial use.

## Support

For questions or support, contact: info@elitehomerepairs.com
