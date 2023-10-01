// eslint-disable-next-line react/prop-types
const Button = ({ text }) => {
  return (
    <div className="rounded-3xl bg-white self-center px-12 py-2 inline-flex cursor-pointer">
      {text}
    </div>
  );
};

export default Button;
