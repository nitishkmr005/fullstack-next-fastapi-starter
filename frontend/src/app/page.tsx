/**
 * Home Page Component
 *
 * This is the main page that demonstrates a full-stack React application:
 * - Fetching data from a FastAPI backend
 * - Managing state with React hooks (useState, useEffect)
 * - Displaying different UI states (loading, error, success)
 * - Using TypeScript for type safety
 * - Styling with Tailwind CSS utility classes
 */

// "use client" directive tells Next.js this is a Client Component
// Client Components can use React hooks, browser APIs, and handle interactivity
// (Server Components are rendered on the server and cannot use hooks)
"use client";

// Import React hooks
// - useState: Manages component state (variables that can change)
// - useEffect: Runs side effects (like API calls) when component mounts
import { useState, useEffect } from "react";

/**
 * TypeScript interface for the API response
 *
 * Interfaces define the structure of objects in TypeScript
 * This provides type safety and autocompletion when working with API data
 */
interface HelloResponse {
  message: string;     // The greeting message from the backend
  timestamp: string;   // When the response was generated (ISO 8601 format)
  version: string;     // The API version number
}

/**
 * Home Component - Main page of the application
 *
 * This component fetches data from the backend API when it loads
 * and displays it to the user with proper loading and error handling
 */
export default function Home() {
  // STATE MANAGEMENT
  // useState creates state variables that trigger re-renders when changed

  // Store the API response data (null initially before data is fetched)
  const [data, setData] = useState<HelloResponse | null>(null);

  // Track loading state (true while fetching data)
  const [loading, setLoading] = useState<boolean>(true);

  // Store any error messages (null if no errors)
  const [error, setError] = useState<string | null>(null);

  // SIDE EFFECTS
  // useEffect runs when the component first mounts (displays on screen)
  // The empty [] means it only runs once, not on every re-render
  useEffect(() => {
    /**
     * Async function to fetch data from the backend API
     *
     * Using async/await makes asynchronous code easier to read
     * compared to traditional .then() chains
     */
    const fetchData = async () => {
      try {
        // Reset states before fetching
        setLoading(true);  // Show loading indicator
        setError(null);    // Clear any previous errors

        // Make HTTP GET request to the FastAPI backend
        // fetch() is a browser API for making HTTP requests
        const response = await fetch("http://localhost:8000/api/hello");

        // Check if the HTTP response is successful (status 200-299)
        if (!response.ok) {
          throw new Error(`HTTP error! status: ${response.status}`);
        }

        // Parse the JSON response body
        // response.json() converts the JSON string to a JavaScript object
        const result: HelloResponse = await response.json();

        // Update state with the fetched data (triggers re-render)
        setData(result);

      } catch (err) {
        // Handle any errors that occur during fetch
        // Check if error is an Error object to safely access .message
        setError(
          err instanceof Error ? err.message : "Failed to fetch data from API"
        );
        console.error("Error fetching data:", err);

      } finally {
        // This runs whether the try or catch block executes
        // Stop showing the loading indicator
        setLoading(false);
      }
    };

    // Call the async function to fetch data
    fetchData();
  }, []); // Empty dependency array = run only once when component mounts

  /**
   * Helper function to format ISO timestamp into a readable string
   *
   * @param timestamp - ISO 8601 timestamp string (e.g., "2025-12-26T10:00:00")
   * @returns Human-readable date and time string
   */
  const formatTimestamp = (timestamp: string) => {
    const date = new Date(timestamp);
    // toLocaleString() formats the date according to user's locale
    return date.toLocaleString();
  };

  // RENDER (JSX)
  // This return statement defines what gets displayed on the page
  return (
    // Main container with full height, centered content, and gradient background
    // Tailwind classes explained:
    // - min-h-screen: minimum height is 100% of viewport
    // - flex: use flexbox layout
    // - items-center justify-center: center content vertically and horizontally
    // - bg-gradient-to-br: background gradient from top-left to bottom-right
    // - dark:from-gray-900: dark mode background color
    // - p-8: padding of 2rem (32px)
    <div className="min-h-screen flex items-center justify-center bg-gradient-to-br from-blue-50 to-indigo-100 dark:from-gray-900 dark:to-gray-800 p-8">
      {/* Content wrapper with max width */}
      <div className="max-w-2xl w-full">

        {/* HEADER SECTION */}
        <div className="text-center mb-8">
          <h1 className="text-5xl font-bold text-gray-800 dark:text-white mb-4">
            Full-Stack Hello World
          </h1>
          <p className="text-lg text-gray-600 dark:text-gray-300">
            Next.js + React + TypeScript + Tailwind CSS + FastAPI
          </p>
        </div>

        {/* MAIN CONTENT CARD */}
        {/* This card will show different content based on loading/error/success state */}
        <div className="bg-white dark:bg-gray-800 rounded-2xl shadow-2xl p-8 mb-6">

          {/* CONDITIONAL RENDERING: LOADING STATE */}
          {/* The && operator means: "if loading is true, render this JSX" */}
          {/* This shows a spinner while data is being fetched */}
          {loading && (
            <div className="text-center py-8">
              {/* Animated spinning circle using Tailwind's animate-spin */}
              <div className="inline-block animate-spin rounded-full h-12 w-12 border-b-2 border-indigo-600"></div>
              <p className="mt-4 text-gray-600 dark:text-gray-300">
                Fetching data from backend...
              </p>
            </div>
          )}

          {/* CONDITIONAL RENDERING: ERROR STATE */}
          {/* Shows error message if there's an error and loading is complete */}
          {/* Red-tinted error panel with left border */}
          {error && !loading && (
            <div className="bg-red-50 dark:bg-red-900/20 border-l-4 border-red-500 p-6 rounded">
              <div className="flex items-center">
                {/* Error icon container (prevents shrinking) */}
                <div className="flex-shrink-0">
                  {/* SVG warning/error icon */}
                  <svg
                    className="h-6 w-6 text-red-500"
                    fill="none"
                    viewBox="0 0 24 24"
                    stroke="currentColor"
                  >
                    {/* SVG path draws a circle with exclamation mark */}
                    <path
                      strokeLinecap="round"
                      strokeLinejoin="round"
                      strokeWidth={2}
                      d="M12 8v4m0 4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"
                    />
                  </svg>
                </div>
                {/* Error message content */}
                <div className="ml-3">
                  <h3 className="text-lg font-medium text-red-800 dark:text-red-200">
                    Error connecting to backend
                  </h3>
                  {/* Display the error message from state (using curly braces for JavaScript expression) */}
                  <p className="mt-2 text-sm text-red-700 dark:text-red-300">
                    {error}
                  </p>
                  <p className="mt-2 text-xs text-red-600 dark:text-red-400">
                    Make sure the FastAPI backend is running on port 8000
                  </p>
                </div>
              </div>
            </div>
          )}

          {/* CONDITIONAL RENDERING: SUCCESS STATE */}
          {/* Shows the data when all conditions are met: data exists, not loading, no error */}
          {data && !loading && !error && (
            <div className="space-y-6">

              {/* Display the greeting message */}
              <div className="text-center">
                {/* Gradient badge showing the message from the API */}
                <div className="inline-block bg-gradient-to-r from-indigo-500 to-purple-600 text-white rounded-full px-8 py-4 text-2xl font-semibold shadow-lg">
                  {/* Access the message property from the data object */}
                  {data.message}
                </div>
              </div>

              {/* Display API response details in a grid */}
              {/* grid: CSS Grid layout, md:grid-cols-2: 2 columns on medium screens and up */}
              <div className="grid grid-cols-1 md:grid-cols-2 gap-4 mt-6">

                {/* Timestamp card */}
                <div className="bg-gray-50 dark:bg-gray-700 p-4 rounded-lg">
                  <p className="text-sm text-gray-500 dark:text-gray-400 mb-1">
                    Timestamp
                  </p>
                  {/* Call the formatTimestamp helper function to make it readable */}
                  <p className="text-lg font-medium text-gray-800 dark:text-white">
                    {formatTimestamp(data.timestamp)}
                  </p>
                </div>

                {/* API Version card */}
                <div className="bg-gray-50 dark:bg-gray-700 p-4 rounded-lg">
                  <p className="text-sm text-gray-500 dark:text-gray-400 mb-1">
                    API Version
                  </p>
                  <p className="text-lg font-medium text-gray-800 dark:text-white">
                    {data.version}
                  </p>
                </div>
              </div>

              {/* Success indicator with checkmark icon */}
              <div className="flex items-center justify-center mt-6 text-green-600 dark:text-green-400">
                {/* Green checkmark SVG icon */}
                <svg
                  className="h-6 w-6 mr-2"
                  fill="none"
                  viewBox="0 0 24 24"
                  stroke="currentColor"
                >
                  {/* SVG path draws a circle with a checkmark */}
                  <path
                    strokeLinecap="round"
                    strokeLinejoin="round"
                    strokeWidth={2}
                    d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"
                  />
                </svg>
                <span className="font-medium">
                  Successfully connected to backend!
                </span>
              </div>
            </div>
          )}
        </div>

        {/* TECH STACK INFORMATION CARD */}
        {/* This section displays all the technologies used in the application */}
        <div className="bg-white dark:bg-gray-800 rounded-xl shadow-lg p-6">
          <h2 className="text-xl font-semibold text-gray-800 dark:text-white mb-4">
            Tech Stack
          </h2>
          {/* Responsive grid: 2 columns on mobile, 3 columns on medium+ screens */}
          <div className="grid grid-cols-2 md:grid-cols-3 gap-4">
            <div className="text-center p-3 bg-gray-50 dark:bg-gray-700 rounded-lg">
              <p className="font-medium text-gray-800 dark:text-white">
                Next.js
              </p>
              <p className="text-xs text-gray-600 dark:text-gray-400">
                Frontend
              </p>
            </div>
            <div className="text-center p-3 bg-gray-50 dark:bg-gray-700 rounded-lg">
              <p className="font-medium text-gray-800 dark:text-white">React</p>
              <p className="text-xs text-gray-600 dark:text-gray-400">UI</p>
            </div>
            <div className="text-center p-3 bg-gray-50 dark:bg-gray-700 rounded-lg">
              <p className="font-medium text-gray-800 dark:text-white">
                TypeScript
              </p>
              <p className="text-xs text-gray-600 dark:text-gray-400">Types</p>
            </div>
            <div className="text-center p-3 bg-gray-50 dark:bg-gray-700 rounded-lg">
              <p className="font-medium text-gray-800 dark:text-white">
                Tailwind
              </p>
              <p className="text-xs text-gray-600 dark:text-gray-400">
                Styling
              </p>
            </div>
            <div className="text-center p-3 bg-gray-50 dark:bg-gray-700 rounded-lg">
              <p className="font-medium text-gray-800 dark:text-white">
                FastAPI
              </p>
              <p className="text-xs text-gray-600 dark:text-gray-400">
                Backend
              </p>
            </div>
            <div className="text-center p-3 bg-gray-50 dark:bg-gray-700 rounded-lg">
              <p className="font-medium text-gray-800 dark:text-white">
                Pydantic
              </p>
              <p className="text-xs text-gray-600 dark:text-gray-400">
                Validation
              </p>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}

