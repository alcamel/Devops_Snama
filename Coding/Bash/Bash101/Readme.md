# Bash Scripting Tutorial 🖥️🐧

---

> **Outline**:

- [📄 Introduction](#introduction)
- [📚 Concepts & Commands](#concepts--commands)
- [🛠️ Practical Examples](#practical-examples)
- [📊 Reference Tables](#reference-tables)

---

## **Content**

### **81. Variables** 🔤

- Learn how to declare and use variables in Bash.
- **Example**:
  ```bash
  #!/bin/bash
  NAME="Gamal"
  echo "Hello, $NAME!"
  ```
- **Key Points**:
  - Variables are case-sensitive.
  - No spaces around the `=` sign when assigning values.
  - Use `readonly` to make a variable constant.

| **Command**          | **Description**                 |
| -------------------- | ------------------------------- |
| `VAR=value`          | Assign value to a variable      |
| `readonly VAR=value` | Create a constant variable      |
| `unset VAR`          | Remove the variable from memory |

---

### **82. Command Line Arguments** 🖱️

- Handle inputs passed to a script using `$1`, `$2`, etc.
- **Example**:
  ```bash
  #!/bin/bash
  echo "Script name: $0"
  echo "First argument: $1"
  echo "All arguments: $@"
  ```
- **Key Points**:
  - `$#`: Number of arguments.
  - `$@`: All arguments.
  - `$?`: Exit status of the last command.

| **Argument** | **Purpose**                        |
| ------------ | ---------------------------------- |
| `$0`         | Name of the script                 |
| `$1, $2...`  | Positional arguments               |
| `$#`         | Total number of arguments provided |
| `$@`         | All arguments as a single string   |

---

### **83. System Variables** 💻

- Explore predefined environment variables.
- **Example**:
  ```bash
  echo "User: $USER"
  echo "Home Directory: $HOME"
  echo "Shell: $SHELL"
  ```

| **Variable** | **Purpose**                               |
| ------------ | ----------------------------------------- |
| `$USER`      | Current logged-in user                    |
| `$HOME`      | Home directory of the user                |
| `$PWD`       | Current working directory                 |
| `$PATH`      | Directories searched for executable files |

---

### **84. Arithmetic Operations** ➕➖

- Perform calculations using `$(( ))`, `expr`, or `let`.
- **Example**:
  ```bash
  num1=10
  num2=5
  result=$((num1 + num2))
  echo "Sum: $result"
  ```
- **Tip**: Use `bc` for floating-point arithmetic.

| **Operator** | **Description**     | **Example** |
| ------------ | ------------------- | ----------- |
| `+`          | Addition            | `a + b`     |
| `-`          | Subtraction         | `a - b`     |
| `*`          | Multiplication      | `a * b`     |
| `/`          | Division (integer)  | `a / b`     |
| `%`          | Modulus (remainder) | `a % b`     |

---

### **85. Command Substitution** 🔄

- Execute commands and store their results in variables.
- **Example**:
  ```bash
  current_date=$(date)
  echo "Today's date is: $current_date"
  ```

| **Syntax**                  | **Description**                    |
| --------------------------- | ---------------------------------- |
| `$(command)`                | Modern way of command substitution |
| `` `command` `` (backticks) | Older way (less preferred)         |

---

### **86. Exporting Variables** 🌍

- Share variables between parent and child scripts.
- **Example**:
  ```bash
  export MY_VAR="Hello"
  ./child_script.sh
  ```

| **Command**  | **Description**                           |
| ------------ | ----------------------------------------- |
| `export VAR` | Make a variable available to child shells |
| `env`        | List all environment variables            |

---

### **87. User Input** ⌨️

- Accept user input during execution.
- **Example**:
  ```bash
  echo "Enter your name:"
  read name
  echo "Hello, $name!"
  ```

| **Command**            | **Description**                 |
| ---------------------- | ------------------------------- |
| `read VAR`             | Read input into the variable    |
| `read -p "Prompt" VAR` | Prompt user while reading input |

---

### **88. Decision Making** 🧠

- Use `if`, `else`, and `elif` for logic.
- **Example**:
  ```bash
  echo "Enter a number:"
  read num
  if [ $num -gt 10 ]; then
      echo "Greater than 10"
  else
      echo "10 or less"
  fi
  ```

---

### **90. Script for Monitoring** 📈

- Automate system monitoring with `top`, `df`, and `free`.
- **Example**:
  ```bash
  echo "CPU Usage:"
  top -b -n1 | grep "Cpu(s)"
  echo "Disk Usage:"
  df -h
  echo "Memory Usage:"
  free -m
  ```

---

### **91. Loops** 🔁

- Automate repetitive tasks using `for`, `while`, and `until`.
- **Example (For Loop)**:
  ```bash
  for i in {1..5}; do
      echo "Iteration: $i"
  done
  ```

| **Loop Type** | **Description**                   | **Example**              |
| ------------- | --------------------------------- | ------------------------ |
| `for`         | Iterate over a list of items      | `for i in 1 2 3; do ...` |
| `while`       | Execute while a condition is true | `while [ $x -lt 5 ]; do` |
| `until`       | Execute until a condition is true | `until [ $x -eq 5 ]; do` |

---

### **100. Finale Part 2** 🏁

- Use advanced scripting features to build real-world solutions.
- **Example**:

  ```bash
  #!/bin/bash

  echo "Automated Web Setup"

  echo "Installing Apache..."
  sudo apt-get update && sudo apt-get install -y apache2

  echo "Deploying HTML template..."
  echo "<h1>Welcome to Bash Automation!</h1>" > /var/www/html/index.html

  echo "Setup Complete. Access your server via its IP!"
  ```

---

## 📊 **Quick Reference Table**

| **Command**        | **Usage**                        |
| ------------------ | -------------------------------- |
| `echo`             | Print messages to the console    |
| `read`             | Capture user input               |
| `if`, `else`       | Decision-making statements       |
| `for`, `while`     | Loop through lists or conditions |
| `export`           | Share variables between scripts  |
| `chmod +x file.sh` | Make a script executable         |

---
