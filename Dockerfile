# Use an official, lightweight Python runtime as a parent image
FROM python:3.11-slim

# Set the working directory inside the container
WORKDIR /app

# Copy the requirements file into the container first to leverage caching
COPY requirements.txt .

# Install the needed packages specified in requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application code into the container
COPY . .

# Make port 5000 available to the world outside this container
EXEDPORT 5000

# Run app.py when the container launches
CMD ["python", "app.py"]

