module Searchable
  extend ActiveSupport::Concern

  class_methods do
    def search_with_fields(query, searchable_fields)
      return all if query.blank?

      parsed = parse_date(query)

      # Separa os campos de acordo com o tipo
      date_fields = []
      text_fields = []

      searchable_fields.each do |field, type|
        if %i[date datetime].include?(type)
          date_fields << field
        else
          text_fields << field
        end
      end

      if parsed
        build_date_query(parsed, date_fields)
      else
        build_text_query(query, text_fields)
      end
    end

    private

    def build_date_query(parsed, date_fields)
      return all if date_fields.empty?

      conditions = []
      params = {}

      date_fields.each do |field|
        case parsed[:type]
        when :month_year
          conditions << "(EXTRACT(MONTH FROM #{field}) = :month_#{field} AND EXTRACT(YEAR FROM #{field}) = :year_#{field})"
          params["month_#{field}".to_sym] = parsed[:month]
          params["year_#{field}".to_sym] = parsed[:year]
        when :day_month
          conditions << "(EXTRACT(DAY FROM #{field}) = :day_#{field} AND EXTRACT(MONTH FROM #{field}) = :month_#{field})"
          params["day_#{field}".to_sym] = parsed[:day]
          params["month_#{field}".to_sym] = parsed[:month]
        when :full_date
          conditions << "(DATE(#{field}) = :date_#{field})"
          params["date_#{field}".to_sym] = Date.new(parsed[:year], parsed[:month], parsed[:day])
        end
      end

      where(conditions.join(" OR "), params)
    end

    def build_text_query(query, text_fields)
      return all if text_fields.empty?

      conditions = text_fields.map { |field| "#{field} ILIKE :q" }.join(" OR ")
      where(conditions, q: "%#{query}%")
    end

    def parse_date(query)
      return nil if query.blank?

      parts = query.strip.split("/").map { |part| part.to_i.to_s }.map(&:to_i)
      return nil if parts.empty?

      begin
        case parts.length
        when 2
          first, second = parts
          if second > 31
            { type: :month_year, month: first, year: second }
          else
            { type: :day_month, day: first, month: second }
          end
        when 3
          day, month, year = parts
          { type: :full_date, day: day, month: month, year: year }
        else
          nil
        end
      rescue ArgumentError
        nil
      end
    end
  end
end
