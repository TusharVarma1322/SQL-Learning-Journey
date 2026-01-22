# SQL Triggers: Complete Guide & Real-World Use Cases

## 🎯 Golden Rules to Remember

### Rule 1: BEFORE vs AFTER
```
BEFORE → Modify or validate data BEFORE it enters the database
AFTER  → React to changes AFTER they're saved (logging, cascading)
```

### Rule 2: NEW vs OLD Availability
| Operation | OLD (before) | NEW (after) |
|-----------|--------------|-------------|
| INSERT    | ❌ No        | ✅ Yes      |
| UPDATE    | ✅ Yes       | ✅ Yes      |
| DELETE    | ✅ Yes       | ❌ No       |

### Rule 3: The DEADLY Mistake - Infinite Loops
**NEVER** perform INSERT/UPDATE/DELETE on the same table inside its trigger!

```sql
-- ❌ WRONG - Creates infinite loop
CREATE TRIGGER bad_trigger
AFTER INSERT ON employees
FOR EACH ROW
BEGIN
    INSERT INTO employees VALUES(...);  -- CRASH!
END;

-- ✅ CORRECT - Use BEFORE + SET
CREATE TRIGGER good_trigger
BEFORE INSERT ON employees
FOR EACH ROW
BEGIN
    SET NEW.column = value;  -- Safe!
END;
```

### Rule 4: Modifying Data
```sql
-- ✅ CORRECT in BEFORE trigger
SET NEW.hire_date = CURDATE();

-- ❌ WRONG - Cannot use UPDATE on NEW
UPDATE employees SET NEW.hire_date = CURDATE();

-- ❌ WRONG - Cannot modify in AFTER trigger
```

### Rule 5: Stopping Actions
Use `SIGNAL` to prevent invalid operations:
```sql
IF NEW.salary < 0 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Salary cannot be negative';
END IF;
```

---

## 🚫 Common Errors to Avoid

### ❌ Error 1: Modifying After INSERT/UPDATE
```sql
-- WRONG
CREATE TRIGGER after_error
AFTER INSERT ON employees
FOR EACH ROW
BEGIN
    SET NEW.hire_date = CURDATE();  -- Too late!
END;
```
**Fix:** Use `BEFORE INSERT` instead

### ❌ Error 2: Recursive Trigger (Infinite Loop)
```sql
-- WRONG
CREATE TRIGGER recursive_error
AFTER UPDATE ON products
FOR EACH ROW
BEGIN
    UPDATE products SET stock = stock - 1;  -- Triggers itself!
END;
```
**Fix:** Update a different table or use BEFORE + SET

### ❌ Error 3: Forgetting Delimiter
```sql
-- WRONG - Semicolon ends trigger early
CREATE TRIGGER my_trigger
BEFORE INSERT ON table
FOR EACH ROW
BEGIN
    SET NEW.col = 1;  -- This ; breaks it
END;
```
**Fix:** Always use DELIMITER

### ❌ Error 4: Accessing OLD in INSERT
```sql
-- WRONG
CREATE TRIGGER insert_error
BEFORE INSERT ON employees
FOR EACH ROW
BEGIN
    IF OLD.salary > 1000 THEN  -- OLD doesn't exist yet!
END;
```
**Fix:** Only use NEW in INSERT triggers

### ❌ Error 5: Not Handling NULL Values
```sql
-- RISKY
IF NEW.email = '' THEN  -- Misses NULL case
```
**Fix:** Check for both: `IF NEW.email IS NULL OR NEW.email = '' THEN`

---

## 🌍 Real-World Use Cases

### 1️⃣ Data Validation & Auto-Correction
**When:** Enforce business rules before data is saved

```sql
-- Example: Normalize email addresses
DELIMITER $$
CREATE TRIGGER normalize_email
BEFORE INSERT ON users
FOR EACH ROW
BEGIN
    SET NEW.email = LOWER(TRIM(NEW.email));
    
    IF NEW.email NOT LIKE '%@%.%' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Invalid email format';
    END IF;
END$$
DELIMITER ;
```

**Real-world scenarios:**
- Auto-format phone numbers: `(555) 123-4567` → `5551234567`
- Convert text to uppercase for consistency
- Prevent negative prices or quantities
- Set default values based on business logic

---

### 2️⃣ Audit Logging & History Tracking
**When:** Track who changed what and when

```sql
-- Example: Employee salary change audit
CREATE TABLE salary_audit (
    audit_id INT AUTO_INCREMENT PRIMARY KEY,
    emp_no INT,
    old_salary DECIMAL(10,2),
    new_salary DECIMAL(10,2),
    changed_by VARCHAR(50),
    changed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DELIMITER $$
CREATE TRIGGER log_salary_changes
AFTER UPDATE ON employees
FOR EACH ROW
BEGIN
    IF OLD.salary != NEW.salary THEN
        INSERT INTO salary_audit (emp_no, old_salary, new_salary, changed_by)
        VALUES (NEW.emp_no, OLD.salary, NEW.salary, USER());
    END IF;
END$$
DELIMITER ;
```

**Real-world scenarios:**
- Compliance requirements (GDPR, SOX, HIPAA)
- Track inventory changes
- Monitor price adjustments
- Security breach detection

---

### 3️⃣ Maintaining Data Integrity & Cascading Updates
**When:** Keep related data synchronized

```sql
-- Example: Auto-update order totals when items change
DELIMITER $$
CREATE TRIGGER update_order_total
AFTER INSERT ON order_items
FOR EACH ROW
BEGIN
    UPDATE orders
    SET total_amount = (
        SELECT SUM(quantity * price)
        FROM order_items
        WHERE order_id = NEW.order_id
    )
    WHERE order_id = NEW.order_id;
END$$
DELIMITER ;
```

**Real-world scenarios:**
- Update product stock when orders are placed
- Recalculate aggregate values (totals, averages)
- Maintain denormalized data for performance
- Sync data across systems

---

### 4️⃣ Business Rule Enforcement
**When:** Prevent invalid operations

```sql
-- Example: Prevent deleting customers with active orders
DELIMITER $$
CREATE TRIGGER prevent_customer_delete
BEFORE DELETE ON customers
FOR EACH ROW
BEGIN
    DECLARE order_count INT;
    
    SELECT COUNT(*) INTO order_count
    FROM orders
    WHERE customer_id = OLD.customer_id
    AND status = 'active';
    
    IF order_count > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Cannot delete customer with active orders';
    END IF;
END$$
DELIMITER ;
```

**Real-world scenarios:**
- Prevent negative inventory
- Enforce credit limits
- Restrict deletion of referenced records
- Validate complex business rules

---

### 5️⃣ Automatic Timestamps & Metadata
**When:** Track creation and modification times

```sql
-- Example: Auto-update modified timestamp
DELIMITER $$
CREATE TRIGGER set_updated_at
BEFORE UPDATE ON products
FOR EACH ROW
BEGIN
    SET NEW.updated_at = NOW();
    SET NEW.updated_by = USER();
END$$
DELIMITER ;
```

**Real-world scenarios:**
- Track record creation/update times
- Set default user/session values
- Generate unique identifiers
- Maintain version numbers

---

### 6️⃣ Complex Calculations & Derived Values
**When:** Auto-calculate values from other fields

```sql
-- Example: Calculate age from birth date
DELIMITER $$
CREATE TRIGGER calculate_age
BEFORE INSERT ON employees
FOR EACH ROW
BEGIN
    SET NEW.age = TIMESTAMPDIFF(YEAR, NEW.birth_date, CURDATE());
END$$
DELIMITER ;
```

**Real-world scenarios:**
- Calculate discounts based on loyalty tier
- Compute commission amounts
- Set expiration dates
- Calculate payment due dates

---

## 📊 Quick Decision Chart

```
Need to modify incoming data?
└─> Use BEFORE INSERT/UPDATE + SET NEW.column

Need to validate and reject bad data?
└─> Use BEFORE + SIGNAL SQLSTATE

Need to log changes?
└─> Use AFTER + INSERT INTO audit_table

Need to update other tables?
└─> Use AFTER + UPDATE other_table

Need to prevent deletion?
└─> Use BEFORE DELETE + SIGNAL (if conditions met)

Need to keep totals/aggregates updated?
└─> Use AFTER INSERT/UPDATE/DELETE + UPDATE parent_table
```

---

## 🔧 Performance Tips

1. **Keep triggers fast** - They run on EVERY row operation
2. **Avoid complex logic** - Move heavy processing to stored procedures
3. **Index properly** - Triggers that query tables need good indexes
4. **Batch operations** - Be aware triggers fire for each row in bulk inserts
5. **Test with volume** - A trigger that works for 10 rows might fail with 10,000

---

## 📝 Template for Safe Trigger Creation

```sql
DELIMITER $$

CREATE TRIGGER trigger_name
[BEFORE|AFTER] [INSERT|UPDATE|DELETE] ON table_name
FOR EACH ROW
BEGIN
    -- 1. Declare variables if needed
    DECLARE variable_name datatype;
    
    -- 2. Validation logic
    IF [condition] THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error message';
    END IF;
    
    -- 3. Modification logic (BEFORE only)
    SET NEW.column = value;
    
    -- 4. Cascading logic (AFTER only)
    INSERT INTO audit_table ...;
    UPDATE other_table ...;
    
END$$

DELIMITER ;
```

---

## 🎓 When NOT to Use Triggers

- **Heavy computation** → Use scheduled jobs instead
- **Complex business logic** → Use application layer
- **Cross-database operations** → Use stored procedures
- **User interaction needed** → Handle in application
- **Temporary validation** → Use CHECK constraints instead

Here is the specific breakdown.

### Use **BEFORE** Trigger

* **If you want to Validate Data:**
* *Example:* "Check if `age` is negative. If yes, stop the insert."


* **If you want to Format Data:**
* *Example:* "Force the `email` field to always be lowercase, even if the user typed uppercase."


* **If you want to Set Default Values dynamically:**
* *Example:* "If the user didn't provide a `created_at` date, set it to `NOW()`."


* **If you want to Calculate a Value for the same row:**
* *Example:* "Take `price` and `quantity` from the input, calculate `total_cost`, and save it in the same row."



### Use **AFTER** Trigger

* **If you want to Update Another Table:**
* *Example:* "A new order was placed. Now, go to the `inventory` table and subtract 1 from the stock."


* **If you want to Log History (Audit Trail):**
* *Example:* "A user changed their password. Insert a row into the `password_history` table to keep a record."


* **If you want to Calculate Statistics:**
* *Example:* "A new student registered. Update the `total_students` count in the `classes` table."


* **If you want to Send Notifications (via a queue table):**
* *Example:* "A payment was marked 'failed'. Insert a row into the `email_queue` table so the backend knows to email the user."



### The "One Sentence" Rule

* If you are messing with **THE SAME ROW** being inserted/updated  Use **BEFORE**.
* If you are messing with **DIFFERENT TABLES**  Use **AFTER**.

**Would you like a code template for any of these specific scenarios?**