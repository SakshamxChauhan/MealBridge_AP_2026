import React, { useContext } from "react";
import { Link, NavLink } from "react-router";
import { AuthContext } from "../../Context/AuthContext";
import { toast } from "react-toastify";

const Nav = () => {
  const { user,handlesignOut } = useContext(AuthContext);

  const logoutUser = async () => {
    try {
        await handlesignOut();
        toast.success("Successfully logged out!");
    } catch (error) {
        toast.error(error.message);
    }
};
//primary ka mtlb intended theme styling 
//z-50	Gives it a high stacking order (z index )
  return (
    <div className="w-full primary  fixed z-50  text-white">
      <div className="navbar responsive shadow-sm">
        <div className="navbar-start">
          <div className="dropdown">
            <div tabIndex={0} role="button" className="btn btn-ghost lg:hidden">
{/* btn-ghost: Gives it a minimal, transparent button style. */}
              <svg
                xmlns="http://www.w3.org/2000/svg"
                className="h-5 w-5"
                fill="none"
                viewBox="0 0 100 100"
                stroke="currentColor"
              >
                {" "}
                <path
                  strokeLinecap="round"
                  strokeLinejoin="round"
                  strokeWidth="2"
                  d="M4 6h16M4 12h8m-8 6h16"
                />{" "}
              </svg>
            </div>
            <ul
              tabIndex={0}
              className="menu menu-sm dropdown-content bg-gray-600 rounded-box z-1 mt-3 w-52 p-2 shadow"
            >
              {/* <li className="text-sm font-bold">
                <NavLink className={({ isActive }) => (isActive ? "border-b rounded-none border-b-orange-300" : "")}
                  to={"/"}>Home</NavLink>
              </li>

              <li className="text-sm font-bold">
                <NavLink
                  className={({ isActive }) => (isActive ? "border-b rounded-none border-b-orange-300" : "")}
                  to={"/avlailablefood"}>Available Foods</NavLink>
              </li>

              {user &&
              <>
              <li className="text-sm font-bold">
              <NavLink
                className={({ isActive }) => (isActive ? "border-b rounded-none border-b-orange-300" : "")}
                to={"/addfood"}>Add Food</NavLink></li>
              <li className="text-sm font-bold">
                <NavLink
                  className={({ isActive }) => (isActive ? "border-b rounded-none border-b-orange-300" : "")}
                  to={"/managefood"}>Manage My Food
                </NavLink>
              </li>
              <li className="text-sm font-bold">
                <NavLink className={({ isActive }) => (isActive ? "border-b rounded-none border-b-orange-300" : "")}to={"/foodrequest"}>My Food Request</NavLink>
              </li>
                </>
              }

             <li className="text-sm font-bold">
              <NavLink className={({ isActive }) => (isActive ? "border-b rounded-none border-b-orange-300" : "")}
                to={"/blogs"}>Blog</NavLink></li> */}
            </ul>
          </div>

          <Link to={"/"} className="md:text-2xl text-xl italic font-extrabold">Meal<span className="text-orange-300 text-2xl md:text-3xl">Bridge</span>{" "}
          </Link>
        </div>

        <div className="navbar-center hidden lg:flex">
          <ul className="menu menu-horizontal px-1">
            <li className="text-sm font-bold">
              <NavLink
                className={({ isActive }) => (isActive ? "border-b rounded-none border-b-orange-300" : "")}
                to={"/"}>
                Home
              </NavLink>
            </li>

            <li className="text-sm font-bold">
              <NavLink
                className={({ isActive }) => (isActive ? "border-b rounded-none border-b-orange-300" : "")}
                to={"/avlailablefood"}>
                Available Foods
              </NavLink>
            </li>
            {
              user&&<>
              <li className="text-sm font-bold">
              <NavLink
                className={({ isActive }) => (isActive ? "border-b rounded-none border-b-orange-300" : "")}
                to={"/addfood"}>
                Add Food
              </NavLink>
            </li>
            <li className="text-sm font-bold">
              <NavLink
                className={({ isActive }) => (isActive ? "border-b rounded-none border-b-orange-300" : "")}
                to={"/managefood"}>
                Manage My Food
              </NavLink>
            </li>
            <li className="text-sm font-bold">
              <NavLink
                className={({ isActive }) => (isActive ? "border-b rounded-none border-b-orange-300" : "")}
                to={"/foodrequest"}>
                My Food Request
              </NavLink>
            </li>
              </>
            }

             <li className="text-sm font-bold">
              <NavLink
                className={({ isActive }) => (isActive ? "border-b rounded-none border-b-orange-300" : "")}
                to={"/blogs"}>
                Blog
              </NavLink>
            </li>
          </ul>
        </div>
        <div className="navbar-end flex gap-3">


          {user ? (
            <>
              <div className="avatar w-11 h-11">
                <div className=" ring-offset-base-100  rounded-full ring-1 ring-offset-2">
                  <img src={user?.photoURL || "/default-avatar.png"} alt="User profile"/>
                </div>
              </div>
              <button onClick={logoutUser} className=" btn">Logout</button>
            </>
          ) : (
            <>
              <NavLink className={'btn'} to={"/login"}>LogIn</NavLink>
              <NavLink className={'btn'} to={"/signup"}>SignUp</NavLink>
            </>
          )}
        </div>
      </div>
    </div>
  );
};

export default Nav;
