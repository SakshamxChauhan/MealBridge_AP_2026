/* eslint-disable no-unused-vars */
import React from "react";
import { Link } from "react-router";
import { motion } from "motion/react";

const Banner = () => {
  return (
    <div
      className="hero min-h-screen"
      style={{
        backgroundImage:
          "url(https://images.unsplash.com/photo-1617878227827-8360231f7f03?q=80&w=3056&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=NHwxMjA3fDA%3D)",
      }}
    >
      <div className="hero-overlay"></div>
      <div className="hero-content text-neutral-content text-center">
        <div className="max-w-md">
          <motion.h1
            initial={{ scale: 0 }}
            animate={{ scale: 1, transition: { duration: 2 } }}
            className="mb-5 text-5xl font-bold"
          >
            Join the Fight Against{" "}
            <motion.span
              animate={{
                color: ["#50cc0d", "#d84117f5", "#f6d70e"],
                transition: { duration: 5, repeat: Infinity },
              }}
            >
              Food Waste
            </motion.span>{" "}
          </motion.h1>
          <motion.p className="mb-5"
            initial={{opacity:0,y:50}}
            animate={{opacity:1,y:0}}
            transition={{duration:2, ease:'easeOut'}}
          >
            Share your surplus food with those who needs it the most. Together, we can build a community where no one sleeps hungry.
          </motion.p>
          <motion.div
          initial={{opacity:0,y:50}}
            animate={{opacity:1,y:0}}
            transition={{duration:3, ease:'easeOut'}}
          className="flex items-center justify-center gap-2">
            <Link
              className="border px-3 py-2 hover:primary"
              to={"/avlailablefood"}>Explore Food
            </Link>
            <Link
              className="border primary px-3 py-2 hover:bg-none"
              to={"/addfood"}
            >
              Donate Food
            </Link>
          </motion.div>
        </div>
      </div>
    </div>
  );
};

export default Banner;
