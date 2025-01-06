## Peoplebox Assignments
### Problem Statement:
1. Create a new branch called `feature/new-feature` from the `main` branch.
2. Add a file named `example.txt` with the text "Hello, World!".
3. Push the changes to the remote repository.

---

## Steps Followed:

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/ujwala04m/peoplebox_assignments.git
   cd peoplebox_assignments
2. **Switch to the `main` Branch**:
   ```bash
   git checkout main
   git pull origin main
3.**Create and Switch to a New Branch**:
```bash
Create a new branch named `feature/new-feature` and switch to it:
git checkout -b feature/new-feature
4 **reate the File**:
Create a file named `example.txt` and add the content "Hello, World!" using the command:
```bash
echo "Hello, World!" > example.txt
5**tage and Commit the File**:
Stage the new file and commit it with an appropriate message:
```bash
git add example.txt
git commit -m "Add example.txt with 'Hello, World' text"
