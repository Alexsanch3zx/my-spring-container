# Screenshot Guide for Assignment Submission

## Required Screenshots

### Screenshot 1: Kubernetes Resources (`kubectl get all`)

**What to capture:**
Run this command in your terminal and take a screenshot:

```bash
kubectl get all
```

**What should be visible:**
- ✅ 2 Deployments: `deployment.apps/react-deployment` and `deployment.apps/spring-deployment`
- ✅ 2 Services: `service/react-service` (NodePort 30080) and `service/spring-service` (NodePort 30081)
- ✅ 4 Pods total: 2 React pods and 2 Spring Boot pods (all STATUS = Running)
- ✅ Multiple ReplicaSets (showing deployment history)

**File name**: `screenshots/kubectl-get-all.png`

---

### Screenshot 2: React UI - Initial View

**What to capture:**
1. Open your browser to http://localhost:30080
2. Make sure the URL bar is visible at the top
3. Capture the main page showing "Item Management System"

**What should be visible:**
- ✅ URL bar showing: `http://localhost:30080`
- ✅ Page title: "Item Management System"
- ✅ "Add New Item" and "Refresh" buttons
- ✅ Message: "No items found. Add your first item to get started!" (if empty)

**File name**: `screenshots/react-ui-home.png`

---

### Screenshot 3: CREATE Operation - Adding a New Item

**What to capture:**
1. Click "Add New Item" button
2. Fill in the form:
   - **Name**: `Laptop`
   - **Description**: `Dell XPS 15 - Development Machine`
3. Take screenshot showing the form filled out (before clicking Add Item)

**What should be visible:**
- ✅ URL bar: `http://localhost:30080`
- ✅ Form with filled fields
- ✅ "Add Item" and "Cancel" buttons

**File name**: `screenshots/create-operation.png`

---

### Screenshot 4: READ Operation - Viewing Items

**What to capture:**
1. After adding the item, it should appear in the list
2. Add 2-3 more items for a better demonstration
3. Take screenshot showing the list of items

**Example items to add:**
- Name: `Laptop`, Description: `Dell XPS 15 - Development Machine`
- Name: `Monitor`, Description: `27-inch 4K Display`
- Name: `Keyboard`, Description: `Mechanical RGB Keyboard`

**What should be visible:**
- ✅ URL bar: `http://localhost:30080`
- ✅ "Items (3)" heading showing count
- ✅ List of items with names and descriptions
- ✅ Each item showing "Edit" and "Delete" buttons
- ✅ Item IDs visible

**File name**: `screenshots/read-operation.png`

---

### Screenshot 5: UPDATE Operation - Editing an Item

**What to capture:**
1. Click "Edit" button on one of the items
2. Modify the name or description
3. Take screenshot showing the edit form

**What should be visible:**
- ✅ URL bar: `http://localhost:30080`
- ✅ Inline edit form showing current values
- ✅ "Save" and "Cancel" buttons
- ✅ Modified text in the input fields

**File name**: `screenshots/update-operation.png`

---

### Screenshot 6: DELETE Operation - Removing an Item

**What to capture:**
1. Click "Delete" button on an item
2. Take screenshot of the confirmation dialog (if browser shows it)
3. OR take screenshot after deletion showing the item removed from the list

**What should be visible:**
- ✅ URL bar: `http://localhost:30080`
- ✅ Updated list with one fewer item
- ✅ Remaining items still displayed

**File name**: `screenshots/delete-operation.png`

---

### Screenshot 7: Full CRUD Demonstration (Optional but Recommended)

**What to capture:**
Take a screenshot showing the complete application with multiple items, demonstrating that all operations work.

**What should be visible:**
- ✅ URL bar: `http://localhost:30080`
- ✅ Multiple items in the list
- ✅ "Add New Item" button available
- ✅ Each item has Edit/Delete functionality

**File name**: `screenshots/full-crud-demo.png`

---

## How to Take Screenshots on macOS

1. **Full Screen**: Press `Command + Shift + 3`
2. **Selected Area**: Press `Command + Shift + 4` (then drag to select area)
3. **Specific Window**: Press `Command + Shift + 4`, then press `Space`, then click the window

Screenshots are saved to your Desktop by default.

---

## Organizing Screenshots

1. Move all screenshots to the `screenshots/` directory:
   ```bash
   mv ~/Desktop/screenshot*.png screenshots/
   ```

2. Rename them appropriately:
   ```bash
   cd screenshots/
   mv screenshot1.png kubectl-get-all.png
   mv screenshot2.png react-ui-home.png
   mv screenshot3.png create-operation.png
   mv screenshot4.png read-operation.png
   mv screenshot5.png update-operation.png
   mv screenshot6.png delete-operation.png
   ```

---

## Verification Checklist

Before submitting, verify:
- [ ] All screenshots are clear and readable
- [ ] URL bar is visible in browser screenshots
- [ ] `kubectl get all` shows 4 pods (2 React + 2 Spring)
- [ ] All CRUD operations are demonstrated
- [ ] Screenshots are named appropriately
- [ ] Screenshots are in the `screenshots/` directory

