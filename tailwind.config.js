module.exports = {
  content: [
    "./app/components/**/*.{html,erb,rb}",
    "./app/views/**/*.html.erb",
    "./app/helpers/**/*.rb",
    "./app/assets/stylesheets/**/*.css",
    "./app/javascript/**/*.js",
    "./node_modules/flowbite/**/*.js",
    "./config/initializers/simple_form.rb",
  ],
  plugins: [require("flowbite/plugin")],
};
