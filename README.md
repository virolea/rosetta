# Rosetta

Rosetta is a Rails engine proviving a full-fledged internationalization (i18n) solution for your Rails application. It is designed with the following principles in mind:
- **Unobtrusiveness**: i18n matters should not get in your way developing application code.
- **Maintanbility**: time should not be spent editing, organizing or deduplicating translation files.
- **Separation of concerns**: development work is separated from translation work.

Rosetta answers those design principles by offering the following features:
- **Texts as translation keys**: Inspired by the [gettext](https://www.gnu.org/software/gettext/) approach, Rosetta uses the texts themselves as translation keys. The language the codebase is written into is the default locale.
- **Key autodiscovery**: New translation keys are automatically discovered and uniquely saved to the database. No more time spent between views and yaml files.
- **A dedicated interface**: Translators can work on a dedicated interface, separated from the codebase. They can search, filter, edit and create translations in a user-friendly environment


A real-life example speaking louder than words, here is a comparison between the Rails default I18n approach and Rosetta:

```erb
<!-- Rails with I18n -->
<h1 class="text-2xl font-semibold"><%= t("pages.home.greetings") %> </h1>
<p class="text-xl font-medium"><%= t("pages.home.introductory_text") %></p>

<!-- Rails with Rosetta -->
<h1 class="text-2xl font-semibold"><%= _ "Hi! Welcome to Rosetta" %> </h1>
<p class="text-xl font-medium">
  <%= _ "Rosetta is a Rails engine proviving a full-fledged internationalization (i18n) solution for your Rails application." %>
</p>
```

## Roadmap

|Feature|tracking|released|
|--|--|--
|Base translations||0.1.1|
|Pluralization API|https://github.com/virolea/rosetta/issues/5||
|Context API|https://github.com/virolea/rosetta/issues/6||
|Interpolation API|https://github.com/virolea/rosetta/issues/8||

## Installation
Add this line to your application's Gemfile:

```ruby
gem "rosetta-rails"
```

And then execute:
```bash
$ bundle install
```

Run the following command to install the required migrations:
```bash
$ rails rosetta:install:migrations
$ rails db:migrate
```

Finally, mount the engine in your `config/routes.rb` file:

```ruby
Rails.application.routes.draw do
  mount Rosetta::Engine => "/rosetta"
end
```

And that's it! Run your server and visit `http://localhost:3000/rosetta` to check everything is running properly.

## Usage

### The Default locale

The main convention Rosetta uses is that your codebase is written in the default locale. By default, it is set to English, as shown on the rosetta interface:

![CleanShot 2024-09-19 at 18 01 55](https://github.com/user-attachments/assets/678fad1d-64cd-463d-8c21-9a166abca715)

If your codebase is written in another language - say French - you can update the default locale in the Rosetta initializer:

```ruby
# config/initializers/rosetta.rb

Rosetta.configure do |config|
  config.set_default_locale(name: "French", code: "fr")
end
```

A locale is defined by a name and a code. The name is the human-readable name of the locale, while the code can be any combination of letters separated by a dash, like `en-GB`, `fr` and so on.

### Adding a locale

Developers shout not worry about managing locales. Locales can be added through the Rosetta interface. Visit the interface and click on the "Add locale" button. You will be prompted to enter the name and code of the locale. Once added, the locale will immediately be available and ready to be translated.

![CleanShot 2024-09-19 at 15 11 21](https://github.com/user-attachments/assets/ffe55e81-5cee-4b5b-9be1-a38abe124dfe)

### Selecting the locale in the application

The current locale is globally available in the current thread the application is running in. You can access it through the `Rosetta.locale` method. This will return a `Rosetta::Locale` instance.

It is recommended to follow the [Rails guides best practices](https://guides.rubyonrails.org/i18n.html#managing-the-locale-across-requests) to manage the locale across requests. Rosetta offers a similar helper method to set the locale for the current request:

```ruby
class ApplicationController < ActionController::Base
  around_action :set_locale

  private

  def set_locale(&action)
    Rosetta.with_locale(params[:locale], &action)
  end
```

Where locale is the code of the locale you want to set. You can then set the locale by passing the locale code as a query parameter in the URL, like `http://localhost:3000?locale=fr`. If no locale exists for this code, the default locale is used instead.

You can access available locales through `Rosetta.available_locales` to build a selector your users can use to swith between locales:

```erb
<ul>
  <% Rosetta.available_locales.each do |locale| %>
    <li><%= link_to locale.name, root_path(locale: locale.code) %></li>
  <% end %>
</ul>
```

### Translating your views

> [!IMPORTANT]
> Make sure you've correctly installed rosetta, and that your production environment has run the rosetta migrations properly before invoking the `_` helper in your views.

As stated above, Rosetta is built with unobstrusiveness in mind. To translate your view, no need to come up with a translation key, figure out the file and appropriate nesting to write to. All you need to do is include the `Rosetta::TranslationHelper` in your `ApplicationHelper` and wrap your text with the `_` method in your view:

```ruby
module ApplicationHelper
  include Rosetta::TranslationHelper
end
```

```erb
<h1"><%= _ "Hi! Welcome to Rosetta" %> </h1>
```

Rosetta will automatically detect the new translation keys and save them to the database. You can then visit the Rosetta interface to add a translation for a given locale.

### Adding translations

Translations can be added through the Rosetta interface. Visit the interface and click on "Manage" button next to the locale you want to add translations for. You will access the list of your app keys, and the corresponding translations, should they exist. To add or edit a translation, hover the translation cell and click on "edit". You can then enter the translation and save it.

![CleanShot 2024-09-19 at 15 14 32](https://github.com/user-attachments/assets/d6d57b0a-034c-409e-8ff1-bfcae84aa1c8)


Saving the new translation **will not immediately reflect in your application**. This is by desgin for performance reasons. To make new translations available in your app, click on the "deploy" button at the top of the page. Translations for the given locale will be reloaded and made available in your app.

![CleanShot 2024-09-19 at 15 15 30](https://github.com/user-attachments/assets/51a9b582-b35e-4df4-a79b-1e0f238715a0)


### Configuration

#### Configuring a base controller

By default, Rosetta inherits from `ActionController::Base`. If you want to restrict access to the Rosetta interface, you can make Rosetta inherit from your own base controller, by configuring it in the initializer:

```ruby
# config/initializers/rosetta.rb

Rosetta.configure do |config|
  # config.set_default_locale(name: "French", code: "fr")
  config.parent_controller_class = "AdminController"
end
```

**Note**: The class name needs to be a string.

#### Setting up the queue for the Autodiscovery Job

Rosetta uses a background job to automatically discover new translations in your codebase. It enqueues jobs in the queue set by default. To configure it to target another queue:

```ruby
# config/initializers/rosetta.rb

Rosetta.configure do |config|
  config.queues[:autodiscovery] = "low_priority"
end
```

### I18n Support

As of now, Rosetta does not integrate with the `i18n` gem as a custom backend. It might be done in the future, however it's been decided to build Rosetta independently for now. You still need to use `i18n` for backwards compatibility of your existing translations, localization, as well as the translations of gems that depend on it.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
