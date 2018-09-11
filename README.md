Pssgrs
================

[![Deploy to Heroku](https://www.herokucdn.com/deploy/button.png)](https://heroku.com/deploy)

This application was generated with the [rails_apps_composer](https://github.com/RailsApps/rails_apps_composer) gem
provided by the [RailsApps Project](http://railsapps.github.io/).

Rails Composer is supported by developers who purchase our RailsApps tutorials.

Problems? Issues?
-----------

Need help? Ask on Stack Overflow with the tag 'railsapps.'

Your application contains diagnostics in the README file. Please provide a copy of the README file when reporting any issues.

If the application doesn't work as expected, please [report an issue](https://github.com/RailsApps/rails_apps_composer/issues)
and include the diagnostics.

Ruby on Rails
-------------

This application requires:

- Ruby 2.4.1
- Rails 5.2.0

Learn more about [Installing Rails](http://railsapps.github.io/installing-rails.html).

Getting Started
---------------

Documentation and Support
-------------------------

Issues
-------------

Similar Projects
----------------

Contributing
------------

Credits
-------

License
-------

Variables
-------
heroku config:set DOMAIN_NAME=pssgrs.com
heroku config:set GMAIL_USERNAME=bouaroua.samuel@gmail.com
heroku config:set GMAIL_PASSWORD=jcinrwyelnhtvkwc
#config figaro, poser toutes les variables du fichier cfg
figaro heroku:set -e production
heroku rake db:migrate
heroku run rake db:seed

Tools
-------
heroku logs -t


rails g devise:views

rails g scaffold Passenger name:string photo:string shortcut:string token:string

rails g scaffold Event address:string city:string country:string latitude:float longitude:float photo:string passenger:references user:references published:boolean


#Generer le controlleur devise
https://github.com/plataformatec/devise/wiki/Tool:-Generate-and-customize-controllers
https://stackoverflow.com/questions/10596238/get-nested-params
$ rails g devise:controllers users -c=registrations #=> `/controllers/users/registrations_controller`.rb`

#Generer la config geocoder
rails generate geocoder:config

#routing via attributs
https://stackoverflow.com/questions/22236619/dynamic-rails-routes-based-on-database-models

#nested forms
https://stackoverflow.com/questions/35140956/rails-nested-attributes-with-devise-signup-form

#prefill valeurs via controlleur
https://stackoverflow.com/questions/30736114/how-to-set-default-value-for-association-with-simple-form

#redirection du nouveau participant vers ses contributions
https://stackoverflow.com/questions/25253039/automatically-sign-in-after-confirm-with-devise
#Keep params after a submit
https://stackoverflow.com/questions/3401671/rails-keep-params-after-a-submit

#envoyer une notif aux admins à la creation d'un users
https://stackoverflow.com/questions/17479864/rails-devise-send-user-email-after-sign-up-create
https://launchschool.com/blog/handling-emails-in-rails
#si publié
https://blog.toshima.ru/2017/04/06/saved-change-to-attribute.html

# email et localization
https://launchschool.com/blog/handling-emails-in-rails
https://niallburkley.com/blog/localize-rails-emails/

#contactform
https://www.codementor.io/simi736/send-email-using-mailform-gem-and-sendgrid-on-heroku-using-rails-5-eyy4zuwnl
https://stackoverflow.com/questions/11093848/rails-undefined-method-model-name-for-nilclassclass
https://mdbootstrap.com/javascript/modals/

#conserver les params changement de preferred_language
https://stackoverflow.com/questions/29002068/rails-i18n-passed-params-get-lost

#redirect to en conservant les messages https://stackoverflow.com/questions/20368717/rails-i-cant-pass-a-validation-error-in-a-redirect

#trad helpers submit buttons
https://stackoverflow.com/questions/16977371/submit-button-helper-with-i18n-t

#form validation clientside
https://stackoverflow.com/questions/19116306/javascript-jquery-validation-on-required-fields
http://jsfiddle.net/bradleytrager/4puBy/

http://codkal.com/add-jquery-validation-rails-5-forms-without-gem/
https://jqueryvalidation.org/email-method/

#font awesome links
https://stackoverflow.com/questions/34077072/referencing-font-awesome-icons-in-rails-link-to-statements

#devise email tester
http://ionrails.com/2014/12/21/using-actionmailerpreview-with-devise-mailers-in-rails-4-1/

#img upload
https://stackoverflow.com/questions/4459379/preview-an-image-before-it-is-uploaded

$ heroku buildpacks:add -i 1 https://github.com/heroku/heroku-buildpack-activestorage-preview
$heroku run bash
homebrew update yarn
bundle gem update

# afficher une partiale si action
https://stackoverflow.com/questions/13395153/how-to-render-partial-on-everything-except-a-certain-action

# custom styles
https://stackoverflow.com/questions/23413512/fonts-are-not-found-404-on-heroku
https://dzone.com/articles/practical-rails-adding-a-bootstrap-theme
https://css-tricks.com/snippets/css/using-font-face/

rails g migration RemoveTokenFromPassengers token:string

#flash message model
https://gorails.com/forum/how-to-raise-a-warning-message-from-the-model

#remove backdrop
https://stackoverflow.com/questions/32459337/how-to-remove-bootstrap-modal-overlay

#routing localize
https://www.netguru.co/codestories/til-2-how-to-include-language-code-in-rails-app
https://stackoverflow.com/questions/14823773/rails-i18n-not-working-properly-on-heroku
https://lingohub.com/frameworks-file-formats/rails5-i18n-ruby-on-rails/#

# validation form color
https://stackoverflow.com/questions/18754020/bootstrap-with-jquery-validation-plugin

#file upload bootstrap
https://bootsnipp.com/snippets/eNbOa

#placement erreurs et filesize
https://stackoverflow.com/questions/13200659/custom-error-label-placement-using-jquery-validate-for-all-or-some-of-your-erro
https://stackoverflow.com/questions/26175483/jquery-validate-file-size
#clusters
https://esri.github.io/esri-leaflet/examples/styling-clusters.html

#rediriger vers espace sauf si ressource protégée
https://stackoverflow.com/questions/28253024/redirecting-after-sign-in-with-devise

#calendar
http://datetime-picker-input.herokuapp.com/

#traduire pays
https://stackoverflow.com/questions/35029667/how-to-convert-the-country-selects-country-code-to-country-name

#relative time time_ago_in_words
https://stackoverflow.com/questions/195740/how-do-you-do-relative-time-in-rails

#gestion erreur controller
https://pdabrowski.com/blog/ruby-on-rails/refactoring/rescue-errors-in-a-controller
