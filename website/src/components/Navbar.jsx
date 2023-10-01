import { GiHamburgerMenu } from "react-icons/gi";

import logo from "../assets/snappoint.svg";
import { useState } from "react";
import MobileNav from "./MobileNav";
import { NavLinks } from "./NavLinks";

const Navbar = () => {
  const [open, setOpen] = useState(false);
  return (
    <div className="w-11/12 mx-auto md:w-full  ">
      <nav className="flex justify-between items-center text-[#F1EFFF] ">
        <div className="image">
          <img src={logo} alt="snappoint logo" className="w-12 md:w-auto" />
        </div>
        <div className="links">
          <ul className="md:flex gap-5 hidden  justify-center items-center">
            <NavLinks />
          </ul>
          <button className="md:hidden" onClick={() => setOpen(!open)}>
            <GiHamburgerMenu className="text-2xl" />
          </button>
          {open && <MobileNav setOpen={setOpen} />}
        </div>
      </nav>
    </div>
  );
};

export default Navbar;
