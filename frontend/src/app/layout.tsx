/**
 * Root Layout Component
 *
 * This is the root layout of the Next.js application. In Next.js 13+, the layout.tsx file
 * defines the common structure that wraps all pages in your application.
 *
 * Key Concepts:
 * - This layout will be shared across all pages
 * - It defines the <html> and <body> tags
 * - The {children} prop represents the page content that will be rendered inside this layout
 * - Metadata is used for SEO (search engine optimization) - it sets the page title and description
 */

import type { Metadata } from "next";
import "./globals.css"; // Import global CSS styles that apply to the entire application

/**
 * Metadata Configuration
 *
 * This metadata object defines the default SEO information for your application:
 * - title: Appears in the browser tab and search engine results
 * - description: Shows up in search engine results and social media previews
 */
export const metadata: Metadata = {
  title: "Hello World - Full Stack App",
  description: "A simple full-stack application with Next.js and FastAPI",
};

/**
 * RootLayout Component
 *
 * This is the root layout component that wraps all pages in the application.
 *
 * @param children - The page content that will be rendered inside this layout
 * @returns The HTML structure for the entire application
 */
export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode; // React.ReactNode can be any valid React element, string, number, etc.
}>) {
  return (
    // Set the language attribute to "en" for English (helps with accessibility and SEO)
    <html lang="en">
      {/* The antialiased class makes text rendering smoother (from Tailwind CSS) */}
      <body className="antialiased">
        {/* Render the page-specific content here */}
        {children}
      </body>
    </html>
  );
}

