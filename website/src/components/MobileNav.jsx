import { AiOutlineClose } from "react-icons/ai";
import { NavLinks } from "./NavLinks";

// eslint-disable-next-line react/prop-types
const MobileNav = ({ setOpen }) => {
  return (
    <div className="fixed inset-0 bg-black/95 grid place-content-center py-10">
      <span className="absolute right-5 top-5" onClick={() => setOpen(false)}>
        <AiOutlineClose className="text-2xl" />
      </span>

      <div className="overflow-y-auto w-screen">
        <ul
          className="flex flex-col justify-around gap-10 font-poppins font-semibold text-3xl text-center"
          onClick={() => setOpen(false)}
        >
          <NavLinks />
        </ul>
      </div>
    </div>
  );
};

export default MobileNav;
