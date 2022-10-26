import React from "react";
import axios from "axios";

class UserForm extends React.Component {
  constructor(props) {
    super(props);

    this.handleSubmit = this.handleSubmit.bind(this);
  }

  // handleChange(event) {
  //   this.setState({ value: event.target.value });
  // }

  handleSubmit(event) {
    console.log(event.target.first_name.value);
    axios
      .post("/users", {
        first_name: event.target.first_name.value,
        last_name: event.target.last_name.value,
        email: event.target.email.value,
        phone_number: event.target.phone_number.value,
        date_of_birth: event.target.date_of_birth.value,
      })
      .then(function (response) {
        console.log(response);
      })
      .catch(function (error) {
        console.log(error);
      });
    alert("A name was submitted: ");
    event.preventDefault();
  }

  render() {
    return (
      <div>
        <form onSubmit={this.handleSubmit}>
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
}

export default UserForm;
