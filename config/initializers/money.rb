# frozen_string_literal: true

Money.default_currency = :eur
Money.locale_backend = :i18n
Money.rounding_mode = BigDecimal::ROUND_HALF_UP
Money.default_infinite_precision = true
