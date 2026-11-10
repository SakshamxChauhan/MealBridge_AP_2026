import React from "react";
import {
  FaFacebook,
  FaInstagramSquare,
  FaLinkedin,
  FaPhone,
  FaGithub,
} from "react-icons/fa";
import { FaLocationDot } from "react-icons/fa6";
import { IoMdMail } from "react-icons/io";
import { Link } from "react-router";

const Footer = () => {
  return (
    <div className="bg-neutral w-full">
      <footer className=" w-full px-2 md:px-0 md:w-11/12 md:mx-auto text-neutral-content p-10 flex flex-col md:flex-row md:items-center gap-2 justify-between">
        {/* logo */}
        <div className="space-y-2">
          <Link to={"/"} className="flex items-center  justify-start ">
            
              <h1 className="text-2xl font-bold italic">Meal<span className="text-orange-300 text-2xl md:text-3xl">Bridge</span>{" "}</h1>
            
          </Link>

          <small>
            © {new Date().getFullYear()} MealBridge. All rights reserved.
          </small>
        </div>

        {/* contact information */}

        <div className="md:space-y-2">
          <div className="flex items-center gap-1 font-bold text-xl">
            <FaPhone></FaPhone>
            <p>+91 857106787944</p>
          </div>

          <div className="flex items-center gap-1 font-bold text-xl">
            <IoMdMail />
            <p>pvtnotemail@gmail.com</p>
          </div>

          <div className="flex items-center gap-1 font-bold text-xl">
            <FaLocationDot />
            <p>Rishihood University, NH-44, Delhi NCR Sonipat, Haryana</p>
          </div>
        </div>

        {/* social icons */}

        <div>
          <h1 className="text-2xl font-bold italic">Connect with us:</h1>

          <div className="flex items-center gap-2 mt-2 text-3xl">
            <a
              target="_blank"
              href="https://www.facebook.com"
            >
              <FaFacebook />
            </a>
            <a target="_blank" href="https://www.instagram.com/sakshamxchauhan/">
              <FaInstagramSquare />
            </a>
            <a
              target="_blank"
              href="https://www.linkedin.com/in/saksham-chauhan-358346384/"
            >
              <FaLinkedin />
            </a>
                <a target="_blank" href="https://github.com/SakshamxChauhan">
              <FaGithub />
            </a>
          </div>
        </div>
      </footer>
    </div>
  );
};

export default Footer;
