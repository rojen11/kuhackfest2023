import "./index.css";
import Navbar from "./components/Navbar";
import HeroSection from "./components/HeroSection";
import Button from "./components/Button";
import Features from "./components/Features";
import Demo from "./components/Demo";
import Footer from "./components/Footer";

function App() {
  return (
    <>
      <section className=" hero-section pt-3 bg-gradient-to-r from-[#8A47F6] to-[#644AFF] h-screen flex flex-col md:p-20 drop-shadow-sm ">
        <Navbar />
        <HeroSection />
        <Button text={"Download Now"} />
      </section>
      <section className=" features-section bg-[#1D192B] flex flex-col pt-20 md:p-20">
        <Features />
      </section>
      <section className=" demo-section bg-[#1D192B] flex flex-col md:p-20">
        <Demo />
      </section>
      <section className=" demo-section bg-[#1D192B] flex flex-col md:p-20">
        <Footer />
      </section>
    </>
  );
}

export default App;
