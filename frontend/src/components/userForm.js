import React from "react";
import axios from "axios";

function UserForm() {
  return (
    <div>
      <form>
        <label>
          First Name
          <input placeholder="Major" name="first_name" required />
        </label>
        <label>
          Last Name
          <input placeholder="Tom" name="last_name" required />
        </label>
        <label>
          Email
          <input
            placeholder="example@mail.com"
            type="email"
            name="email"
            required
          />
        </label>
        <label>
          Phone Number
          <input
            placeholder="+44123456789"
            type="tel"
            name="phone_number"
            required
          />
        </label>
        <label>
          Date of Birth
          <input
            placeholder="DD/MM/YY"
            type="date"
            name="date_of_birth"
            required
          />
        </label>
        <button type="submit">Submit</button>
      </form>
    </div>
  );
}

export default UserForm;
