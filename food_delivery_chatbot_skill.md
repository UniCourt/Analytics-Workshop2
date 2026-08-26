# Food Delivery Chatbot – Development Instructions

Build a complete Food Delivery Customer Support Chatbot application.

The application must be built using Python and Django and should run completely using Docker Compose.

---

## 1. Technology Stack

Use the following technologies:

- Python 3.11+
- Django
- Django REST Framework where APIs are required
- HTML/CSS/JavaScript for the chatbot UI
- NVIDIA AI API for sentiment analysis
- Docker
- Docker Compose

### Important

Do not use a database for this project.

All orders, coupons, tickets, and other application data should be stored in Python data structures such as dictionaries/lists or JSON files.

The application should work immediately after:

```shell
docker compose up --build
```

The Docker setup must automatically install dependencies and start the Django application.

---

## 2. Application Objective

Build a chatbot for a food delivery application.

The user should be able to interact with the chatbot using natural language.

Examples:

- Where is my order?
- Where is my order 123?
- Can you check order 123?
- What is the status of my order 456?
- Do you have any coupons?
- Are there any discounts available?
- I have a problem with my order
- My order is very late
- My food hasn't arrived
- I am very unhappy with the service

The chatbot should understand the user's intent and provide an appropriate response.

---

## 3. Chatbot UI

Create a simple, modern chatbot interface.

The page should contain:

- Chat header
- Chat message area
- User messages
- Bot messages
- Text input
- Send button
- Loading indicator while processing
- Error handling

The UI should look like a real food-delivery customer support chatbot.

Example:

```text
+---------------------------------------+
|        🍔 Food Delivery Assistant     |
+---------------------------------------+

Bot:
Hi! 👋 How can I help you today?

User:
Where is my order 123?

Bot:
Your order #123 is currently out for delivery.
The delivery partner should reach you in
approximately 20 minutes.

-----------------------------------------
[ Type your message...          ] [Send]
+---------------------------------------+
```

---

## 4. Mock Order Data

Since there is no database, create predefined orders in Python.

For example:

```python
ORDERS = {
    "1": {
        "status": "Out for Delivery",
        "restaurant": "Pizza Palace",
        "items": ["Margherita Pizza", "Garlic Bread"],
        "estimated_delivery": "20 minutes"
    },
    "2": {
        "status": "Preparing",
        "restaurant": "Burger House",
        "items": ["Cheese Burger", "French Fries"],
        "estimated_delivery": "35 minutes"
    },
    "3": {
        "status": "Delivered",
        "restaurant": "Indian Spice",
        "items": ["Butter Chicken", "Naan"],
        "estimated_delivery": "Delivered"
    }
}
```

Add at least 5 predefined orders with different statuses.

Possible statuses:

- Order Confirmed
- Preparing
- Ready for Pickup
- Out for Delivery
- Delivered
- Cancelled
- Delayed

---

## 5. Order Tracking

The chatbot must recognize order-related questions.

Examples:

- Where is my order 123?
- What is happening with order 123?
- Can you track 123?
- Check my order 123
- Order 123 status?

The chatbot should extract the order ID from the user's message.

If the order exists:

```text
Your order #123 is currently Out for Delivery.

Restaurant: Pizza Palace
Items: Margherita Pizza, Garlic Bread
Estimated delivery: 20 minutes
```

If the order does not exist:

```text
I couldn't find order #999.

Please check the order ID and try again.
```

If the user asks:

```text
Where is my order?
```

without providing an order ID, ask:

```text
Sure! Please provide your order ID so I can check the status.
For example: "Where is my order 123?"
```

---

## 6. Coupon / Discount Support

Create predefined coupons without using a database.

Example:

```python
COUPONS = [
    {
        "code": "WELCOME50",
        "description": "50% off for new users",
        "max_discount": 100
    },
    {
        "code": "FOOD20",
        "description": "20% off on orders above ₹500",
        "max_discount": 150
    },
    {
        "code": "FREEDEL",
        "description": "Free delivery on orders above ₹299",
        "max_discount": 50
    }
]
```

The chatbot should recognize questions such as:

- Do you have any coupons?
- Any discounts available?
- What offers do you have?
- Can I get a coupon?
- Show me today's offers

Response example:

```text
🎉 Here are some available offers:

WELCOME50
50% off for new users, up to ₹100

FOOD20
20% off on orders above ₹500, up to ₹150

FREEDEL
Free delivery on orders above ₹299.
```

---

## 7. Intent Detection

Implement basic intent detection for the chatbot.

The application should identify intents such as:

- ORDER_STATUS
- COUPON
- COMPLAINT
- DELIVERY_ISSUE
- ORDER_NOT_READY
- GENERAL_QUERY
- UNKNOWN

For example:

```text
"Where is order 123?"
→ ORDER_STATUS

"Do you have any coupons?"
→ COUPON

"My food hasn't arrived"
→ DELIVERY_ISSUE

"My order is still not ready"
→ ORDER_NOT_READY

"I hate this service"
→ COMPLAINT
```

Use a simple and maintainable architecture.

Do not over-engineer the intent detection.

A combination of keyword/rule-based detection and AI sentiment analysis is sufficient for this project.

---

## 8. Sentiment Analysis Using NVIDIA AI

Use an NVIDIA AI API/key for sentiment analysis.

The NVIDIA API key must never be hardcoded.

Read it from an environment variable:

```text
NVIDIA_API_KEY
```

Example `.env`:

```env
NVIDIA_API_KEY=your_nvidia_api_key
```

Use the NVIDIA model/API to determine the user's sentiment.

Possible sentiment values:

- POSITIVE
- NEUTRAL
- NEGATIVE
- ANGRY

Example:

```text
User:
"My order is extremely late. This is ridiculous!"

Sentiment:
ANGRY
```

Another example:

```text
User:
"Thanks, the delivery was really fast!"

Sentiment:
POSITIVE
```

The sentiment result should be available internally to the chatbot logic.

---

## 9. AI Prompt for Sentiment Analysis

Use a structured prompt for the NVIDIA model.

The AI should return JSON similar to:

```json
{
    "sentiment": "ANGRY",
    "confidence": 0.94
}
```

Allowed sentiment values:

- POSITIVE
- NEUTRAL
- NEGATIVE
- ANGRY

Handle invalid AI responses gracefully.

If the NVIDIA API is unavailable, the application should not crash.

Fallback to:

```text
NEUTRAL
```

and continue processing the user's request.

---

## 10. Ticket Creation

The chatbot must create a support ticket when the user reports an issue.

There is no database.

Therefore, tickets can be stored in an in-memory Python list.

Example:

```python
TICKETS = []
```

Each ticket should contain:

```json
{
    "ticket_id": "TKT-1001",
    "order_id": "123",
    "issue_type": "DELIVERY_DELAY",
    "description": "Order has not arrived yet",
    "sentiment": "ANGRY",
    "status": "OPEN"
}
```

Generate ticket IDs automatically.

Example:

- TKT-1001
- TKT-1002
- TKT-1003

---

## 11. When to Create a Ticket

Create a support ticket for issues such as:

- My order is very late
- My food hasn't arrived
- My order is not ready
- The restaurant hasn't prepared my food
- There is a problem with my order
- I want to complain
- My order is wrong
- My food is missing

Example:

```text
User:
My order 123 is still not ready and I've been waiting for an hour.

Bot:
I'm sorry about the delay. I understand how frustrating that can be.

I've created a support ticket for you.

Ticket ID: TKT-1001
Issue: Order preparation delay
Order: #123
Status: Open

Our support team will look into this.
```

---

## 12. Sentiment + Ticket Priority

Use sentiment to determine ticket priority.

For example:

- ANGRY → HIGH
- NEGATIVE → MEDIUM
- NEUTRAL → LOW
- POSITIVE → LOW

Ticket example:

```json
{
    "ticket_id": "TKT-1001",
    "order_id": "123",
    "issue_type": "DELIVERY_DELAY",
    "description": "...",
    "sentiment": "ANGRY",
    "priority": "HIGH",
    "status": "OPEN"
}
```

If the customer is angry, the chatbot should respond empathetically.

Example:

```text
I'm really sorry about this. I understand how frustrating
it is to wait for an order that hasn't arrived.
```

Do not make the chatbot overly verbose.

---

## 13. Ticket Management

Create an internal endpoint to view tickets.

Example:

```http
GET /api/tickets/
```

Response:

```json
[
    {
        "ticket_id": "TKT-1001",
        "order_id": "123",
        "issue_type": "DELIVERY_DELAY",
        "sentiment": "ANGRY",
        "priority": "HIGH",
        "status": "OPEN"
    }
]
```

Also create:

```http
GET /api/orders/
```

to view the predefined orders.

And:

```http
GET /api/coupons/
```

to view available coupons.

---

## 14. Chat API

Create an API endpoint:

```http
POST /api/chat/
```

Request:

```json
{
    "message": "Where is my order 123?"
}
```

Response:

```json
{
    "message": "Your order #123 is currently out for delivery.",
    "intent": "ORDER_STATUS",
    "sentiment": "NEUTRAL",
    "ticket_created": false
}
```

For an issue:

```json
{
    "message": "I'm sorry about the delay. I've created support ticket TKT-1001.",
    "intent": "DELIVERY_ISSUE",
    "sentiment": "ANGRY",
    "ticket_created": true,
    "ticket_id": "TKT-1001"
}
```

---

## 15. Project Architecture

Use a clean Django project structure.

Suggested structure:

```text
food_delivery_chatbot/
│
├── manage.py
├── requirements.txt
├── Dockerfile
├── docker-compose.yml
├── .dockerignore
├── .env.example
├── README.md
│
├── chatbot/
│   ├── __init__.py
│   ├── admin.py
│   ├── apps.py
│   ├── urls.py
│   ├── views.py
│   ├── services/
│   │   ├── __init__.py
│   │   ├── chatbot_service.py
│   │   ├── sentiment_service.py
│   │   ├── order_service.py
│   │   ├── coupon_service.py
│   │   └── ticket_service.py
│   ├── data/
│   │   ├── orders.py
│   │   └── coupons.py
│   └── templates/
│       └── chatbot/
│           └── index.html
│
└── config/
    ├── __init__.py
    ├── settings.py
    ├── urls.py
    ├── asgi.py
    └── wsgi.py
```

Keep business logic outside Django views as much as possible.

---

## 16. Dockerfile

Create a production-friendly Dockerfile.

Requirements:

- Use Python 3.11+
- Install dependencies from requirements.txt
- Copy the project into the container
- Expose port 8000
- Start Django automatically

The container should be able to run with:

```shell
docker compose up --build
```

---

## 17. Docker Compose

Create `docker-compose.yml`.

There should be no database service because this project intentionally does not use a database.

Example architecture:

```text
docker-compose
      |
      v
Django Application
      |
      +---- Chat API
      |
      +---- Order Service
      |
      +---- Coupon Service
      |
      +---- Ticket Service
      |
      +---- NVIDIA AI API
```

The Django application should be available at:

```text
http://localhost:8000
```

---

## 18. Environment Variables

Create `.env.example`.

Example:

```env
DEBUG=True
SECRET_KEY=change-me
NVIDIA_API_KEY=
NVIDIA_MODEL=
```

Do not commit the actual NVIDIA API key.

The Docker Compose configuration should load environment variables from `.env`.

---

## 19. Requirements

Create `requirements.txt`.

Include only the dependencies actually required by the application.

At minimum, include:

- Django
- djangorestframework
- requests
- python-dotenv

Use the appropriate NVIDIA/OpenAI-compatible SDK only if it is actually required by the selected NVIDIA API integration.

Avoid unnecessary packages.

---

## 20. Error Handling

The application must gracefully handle:

### NVIDIA API failure

If NVIDIA API is unavailable:

```text
Sentiment analysis unavailable.
```

Use `NEUTRAL` as the fallback sentiment.

The chatbot must continue working.

### Invalid order

Return:

```text
I couldn't find that order. Please check your order ID.
```

### Empty message

Return:

```text
Please enter a message so I can help you.
```

### Unknown question

Return something like:

```text
I'm sorry, I didn't quite understand that.

I can help you with:
• Order tracking
• Coupons and offers
• Delivery issues
• Order complaints
```

---

## 21. Chatbot Conversation Examples

The implementation should support conversations like:

### Example 1 – Order tracking

```text
User:
Where is my order 123?

Bot:
Your order #123 is currently out for delivery.
Estimated delivery time is 20 minutes.
```

### Example 2 – Missing order ID

```text
User:
Where is my order?

Bot:
Sure! Please provide your order ID so I can check its status.
```

### Example 3 – Coupon

```text
User:
Any coupons available?

Bot:
Yes! 🎉 Here are some available offers...
```

### Example 4 – Delivery complaint

```text
User:
My order 123 is extremely late. This is ridiculous!

Bot:
I'm really sorry about the delay. I understand how frustrating this is.

I've created support ticket TKT-1001 with HIGH priority.
```

### Example 5 – Order not ready

```text
User:
My order 456 is still not ready.

Bot:
I'm sorry about the wait.

I've created support ticket TKT-1002 for the order preparation issue.
```

---

## 22. Code Quality Requirements

Follow good Python practices.

Requirements:

- PEP8
- Type hints where useful
- Meaningful function/class names
- Small functions
- No business logic directly inside templates
- No hardcoded API keys
- Environment-based configuration
- Proper exception handling
- Logging for important errors
- No unnecessary dependencies
- Add comments only where they improve understanding

Do not over-engineer the solution.

This is a demonstration/workshop project, so prioritize:

- Simplicity
- Readability
- Easy setup
- Easy demonstration
- Clean architecture

---

## 23. README

Create a detailed `README.md`.

It must explain:

### Prerequisites

- Docker
- Docker Compose
- NVIDIA API key

### Configuration

Explain how to create `.env`:

```env
NVIDIA_API_KEY=your_key
```

### Run

The primary command should be:

```shell
docker compose up --build
```

Then open:

```text
http://localhost:8000
```

### API documentation

Document:

- `POST /api/chat/`
- `GET /api/orders/`
- `GET /api/coupons/`
- `GET /api/tickets/`

Include example requests and responses.

### Architecture

Explain the flow:

```text
User
 ↓
Chat UI
 ↓
Django Chat API
 ↓
Intent Detection
 ↓
 ├── Order Service
 ├── Coupon Service
 ├── Ticket Service
 └── NVIDIA Sentiment Analysis
 ↓
Response
 ↓
Chat UI
```

---

## 24. Testing

Add basic automated tests.

Test at least:

### Order

```text
Where is order 123?
```

Expected:

```text
ORDER_STATUS
```

### Unknown order

```text
Where is order 999?
```

Expected:

```text
Order not found
```

### Coupon

```text
Do you have coupons?
```

Expected:

```text
COUPON
```

### Complaint

```text
My food is very late
```

Expected:

```text
DELIVERY_ISSUE
```

and a ticket should be created.

### Sentiment

Test positive, neutral, negative, and angry messages.

### Empty input

Verify the API handles an empty message correctly.

---

## 25. Important Implementation Constraint

Do not introduce PostgreSQL, SQLite, Redis, Celery, Kafka, RabbitMQ, or any other external service.

This is intentionally a stateless demo application with mock data stored in Python.

Tickets can be stored in memory.

Therefore, tickets will disappear when the container restarts. This is acceptable and should be clearly documented in the README.

---

## 26. Final Acceptance Criteria

The implementation is complete only when all of the following work:

- `docker compose up --build` successfully builds the application
- Django starts automatically
- Chat UI opens at http://localhost:8000
- User can send chat messages
- Order IDs can be extracted from natural language
- Predefined orders can be queried
- Coupon questions work
- Sentiment analysis uses NVIDIA AI
- NVIDIA API key comes from environment variables
- NVIDIA API failure does not crash the application
- Customer complaints create tickets
- Ticket priority is based on sentiment
- Tickets receive unique IDs
- `/api/tickets/` returns created tickets
- `/api/orders/` returns mock orders
- `/api/coupons/` returns coupons
- `/api/chat/` works
- Automated tests are included
- README contains complete setup instructions
- No database is required
- No API keys are hardcoded

### Development Approach

Build the application completely rather than providing pseudo-code.

Create all required files, Django configuration, API endpoints, services, templates, Docker configuration, tests, and README.

The final project must be runnable with:

```shell
docker compose up --build
```

with no manual application setup after the container starts.
