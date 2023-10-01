import logo from "../assets/snappoint2.svg";
import Button from "./Button";

const Footer = () => {
  return (
    <footer className="bg-gradient-to-r from-[#8A47F6] to-[#644AFF] rounded-3xl my-10 pt-5 gap-3 md:gap-0 flex flex-col items-center justify-center w-11/12 mx-auto">
      <div className="card flex flex-col md:flex-row  items-center justify-center font-bold p-10">
        <img src={logo} alt="snappoint" height={95} width={66} />
        <h1 className=" text-white text-3xl md:text-6xl ">SnapPoint.</h1>
      </div>
      <div className="md:self-end p-3 md:pr-5 md:pb-5">
        <Button text={"Download Now"} />
      </div>
    </footer>
  );
};

export default Footer;
