require "yaml"
require "digest/md5"

class Core
    getter locales_path : String

    def initialize(locales_path : String, default_locale : String = "en")
        @locales_path = locales_path
        @default_locale = default_locale
        @all_locales = Hash(String, YAML::Any).new
        load_locales
    end

    def question_and_answers(locale : String = @default_locale)
        locale = @default_locale unless is_valid_locale(locale)
        random_question_index = random_index_for(locale)

        locales = @all_locales[locale].as_h
        current_question = locales.keys[random_question_index]

        encrypted_answers(locales, current_question)
    end

    def encrypted_answers(locales, question)
        md5_answers = [] of String | Int32

        locales[question].as_a.each do |answer|
            md5_answers << Digest::MD5.hexdigest(answer.to_s.downcase)
        end

        { "q" => question.to_s, "a" => md5_answers }
    end

    private def is_valid_locale(str : String)
        return false if str.blank?
        return false if str.size != 2

        @all_locales.keys.includes?(str.downcase)
    end

    private def random_index_for(locale : String)
        Random.new.rand(0..@all_locales[locale].as_h.keys.size - 1)
    end

    private def load_locales
      Dir.glob("#{locales_path}/*.yml") do |file|
          locale = File.basename(file, File.extname(file))
          yaml = File.open(file.to_s) { |content| @all_locales[locale.to_s] = YAML.parse(content) }
      end
    end
end
