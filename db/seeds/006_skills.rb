class Seeder
  SKILLS = [
    ['Ruby', ''],
    ['Rails', 'Ruby on Rails'],
    ['Heroku', ''],
    ['S3', 'Amazon Simple Storage Service'],
    ['MySQL', ''],
    ['SQL', ''],
    ['JavaScript', ''],
    ['JQuery', ''],
    ['Prototype', ''],
    ['CSS', ''],
    ['Bootstrap', ''],
    ['RWD', 'Responsive Web Design'],
    ['SEO', 'Référencement naturel'],
    ['SASS', ''],
    ['HTML', ''],
    ['Haml', ''],
    ['E-commerce', ''],
    ['Java', ''],
    ['Java EE', 'Java Entreprise Edition'],
    ['Git', ''],
    ['Subversion', ''],
    ['CVS', ''],
    ['PHP', ''],
    ['Web Design', ''],
    ['Ergonomie', ''],
    ['WML', ''],
    ['WAP', ''],
  ].freeze

  def seed_skills
    table_name = 'skills'
    seeding table_name
    clear_table table_name
    progress do
      now = Time.now.to_s(:db)
      SKILLS.each_with_index do |item, index|
        values_clause = (item + [index + 1, 1, now, now]).map { |v| cnx.quote(v) }.join(', ')
        sql = %(
          INSERT INTO #{table_name}
            (name, title, id, active, created_at, updated_at)
            VALUES (#{values_clause})
        )
        cnx.insert(sql)
        ahead!
      end
    end
  end
end
