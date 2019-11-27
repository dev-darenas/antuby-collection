const init = () => {
  $(document).on('turbolinks:load', () => {
    console.log(' init ');
  });
};

export default init;
