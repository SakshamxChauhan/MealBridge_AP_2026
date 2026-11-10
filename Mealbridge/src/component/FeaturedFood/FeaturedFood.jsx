import React from "react";
import { Link } from "react-router";
import { FaArrowRight } from "react-icons/fa6";
// This imports a right-arrow icon from the React Icons library.It renders the arrow as a React component.

const FeaturedFood = ({ food }) => {
  const { _id,   foodName, foodImage } = food;
  return (
   <div className="card bg-base-100  shadow-sm">
    {/* figure is An HTML semantic element commonly used to group images or illustrations. */}
  <figure>
    <img
      src={foodImage}
      alt={foodName}
      className="h-90 w-full object-cover" />
  </figure>
  <div className="card-body">
    <h2 className="card-title">
      {foodName}
      <div className="badge badge-secondary">Featured</div>
      {/* A badge is a small label used to highlight information. */}
    </h2>
    <p>Notes : {food.notes}</p>
    <p>Quantity: {food.quantity}</p>
    <p>Expired by: {food.expiredDate}</p>
    <div className="card-actions flex items-center justify-end">
      <Link className="text-green-700 font-semibold flex items-center justify-center gap-1" to={`/details/${_id}`}>Details <span><FaArrowRight /></span></Link>
      {/* Backticks allow you to insert JavaScript variables inside a string using ${}. */}
      
    </div>
  </div>
</div>
  );
};

export default FeaturedFood;
