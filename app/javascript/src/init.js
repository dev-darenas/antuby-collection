import iniActivities from './activities'

const init = () => {
  $(document).on('turbolinks:load', () => {
    if($(".type_activity").length > 0){
      iniActivities()
    }
  });
};

export default init;
