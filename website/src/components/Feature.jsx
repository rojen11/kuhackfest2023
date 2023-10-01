import feature1 from "../assets/feature1.svg";
import feature2 from "../assets/feature2.svg";
import feature3 from "../assets/feature3.svg";

export const Feature = () => {
  const features = [
    {
      id: 1,
      image: feature1,
      title: "Location Reminder",
      description:
        "Our app empowers you to effortlessly set location reminders. Never forget important tasks again; get notified when you're in the right place with our intuitive location reminder feature. ",
    },
    {
      id: 2,
      image: feature2,
      title: "Explore Snaps",
      description:
        "Discover the world through a new lens! Our app lets you explore captivating snaps tied to your location reminders. Immerse yourself in the moment and relive memories with ease. ",
    },
    {
      id: 3,
      image: feature3,
      title: "Experience",
      description:
        "Experience endless fun and excitement while exploring our app! Dive into a world of captivating content, interactive features, and surprises that will keep you entertained. ",
    },
  ];

  const mappedFeauters = features.map((feature) => (
    <div className="feature text-white " key={feature.id}>
      <img src={feature.image} alt={`${feature.title} image`} />

      <h3 className="text-[#9483FF] text-2xl font-bold mt-6">
        {feature.title}
      </h3>
      <p className="mt-4 text-[#D2CBFF] font-normal">{feature.description}</p>
    </div>
  ));

  return mappedFeauters;
};
