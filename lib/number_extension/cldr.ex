defmodule NumberExtension.Cldr do
  use Cldr,
    locales: ["en", "pt"],
    default_locale: "pt",
    providers: [Cldr.Number]
end
