class Seeder
  EDUCATIONS = [
    [1, nil,          '1999-09-30', 3, 'BAC S', 'mathématique',
      'Lycée Van Gogh', 'Aubergenville (78)', 'http://www.lyc-vangogh-aubergenville.ac-versailles.fr'],
    [2, '1999-10-01', '2002-06-30', 2, 'DEUG MIAS (Mathématique et Informatique Appliquées aux Sciences)', 'informatique',
      'UVSQ (Université de Versailles Saint-Quentin', 'Versailles (78)', 'http://www.uvsq.fr'],
    [3, '2002-10-01', '2005-09-30', 1, 'Diplôme d’ingénieur en informatique', 'SIGL (Génie Logiciel)',
      'INSIA', 'Paris XIe (75)', 'http://www.ingesup.com'],
  ].freeze

  def seed_educations
    table_name = 'educations'
    seeding table_name
    clear_table table_name
    progress do
      now = Time.now.to_s(:db)
      EDUCATIONS.each do |item|
        values_clause = (item + [random_html_description, 1, now, now]).map { |v| cnx.quote(v) }.join(', ')
        sql = %(
          INSERT INTO #{table_name}
            (id, started_on, ended_on, position, name, `option`, establishment, location, website_url, description, active, created_at, updated_at)
            VALUES (#{values_clause})
        )
        cnx.insert(sql)
        ahead!
      end
    end
  end
end
