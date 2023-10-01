import logo from "../assets/snappoint2.svg";

const HeroSection = () => {
  return (
    <div className="card flex flex-col md:flex-row  items-center justify-center font-bold self-center justify-self-center h-[75vh]">
      <img src={logo} alt="snappoint" width={96} />
      <h1 className=" text-white text-5xl md:text-8xl ">SnapPoint.</h1>
    </div>
  );
};

export default HeroSection;
