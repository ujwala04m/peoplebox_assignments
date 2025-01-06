// Function to convert snake_case keys to camelCase keys
function convertSnakeToCamel(obj) {
    const newObject = {};

    for (const [key, value] of Object.entries(obj)) {
        // Convert snake_case to camelCase
        const camelCaseKey = key.replace(/_([a-z])/g, (_, letter) => letter.toUpperCase());
        newObject[camelCaseKey] = value; // Assign the value to the new camelCase key
    }

    return newObject;
}


const snakeCaseObject = {
    "first_name": "John",
    "last_name": "Doe",
    "email_address": "john.doe@example.com"
};

const camelCaseObject = convertSnakeToCamel(snakeCaseObject);
console.log(camelCaseObject);
