import { Feature } from "./Feature";

const Features = () => {
  return (
    <div className="w-11/12 mx-auto">
      <h1 className="text-[#9483FF] text-6xl font-semibold ">Features</h1>
      <div className="my-11">
        <div className="features grid justify-center md:grid-cols-3 gap-10">
          <Feature />
        </div>
      </div>
    </div>
  );
};

export default Features;
