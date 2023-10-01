import Screens from "../assets/Screens.svg";

const Demo = () => {
  return (
    <div className="w-11/12 mx-auto">
      <h1 className="text-[#9483FF] text-6xl font-semibold ">Demo</h1>
      <div className="w-75 md:w-full">
        <img src={Screens} alt="screens image" className="max-w-full " />
      </div>
    </div>
  );
};

export default Demo;
