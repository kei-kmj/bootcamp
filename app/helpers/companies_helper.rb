# frozen_string_literal: true

module CompaniesHelper
  def all_companies_with_empty
    Company.all.to_a.unshift(Company.new(name: 'æć±ăȘă'))
  end
end
