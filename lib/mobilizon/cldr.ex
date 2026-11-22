defmodule Mobilizon.Cldr do
  @moduledoc """
  Module to define supported locales
  """

  use Cldr,
    locales: Application.compile_env(:mobilizon, :cldr)[:locales],
    add_fallback_locales: false,
    gettext: nil,
    providers: [Cldr.Number, Cldr.Calendar, Cldr.DateTime, Cldr.Language],
    precompile_transliterations: [{:latn, :arabext}]

  def known_locale?(locale) do
    Mobilizon.Cldr.known_locale_names()
    |> Enum.map(&Atom.to_string/1)
    |> Enum.member?(locale)
  end

  def locale_or_default(locale, default \\ "en") do
    if known_locale?(locale) do
      locale
    else
      default
    end
  end
end
