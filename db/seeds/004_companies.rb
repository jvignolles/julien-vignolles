class Seeder
  COMPANIES = [
    [1, 'w-HA',             'Issy-les-Moulineaux (92)', 'http://www.w-ha.com'],
    [2, 'INSIA',            'Paris XIXe (75)',          'http://www.insia.org'],
    [3, 'Airweb',           'Saint-Ouen (93)',          'http://www.airweb.eu'],
    [4, 'Solsoft',          'Levallois-Perret (92)',    'http://www.solsoft.co.uk'],
    [5, 'Rexis Consulting', 'Carquefou (44)',           ''],
    [6, 'Ciblo',            'Paris XVIIe (75)',         'http://www.ciblo.net'],
    [7, 'Freelance',        '',                         ''],
  ].freeze

  def seed_companies
    table_name = 'companies'
    seeding table_name
    clear_table table_name
    progress do
      now = Time.now.to_s(:db)
      COMPANIES.each do |item|
        values_clause = (item + [random_description(blocks: 1, words: 8), 1, now, now]).map { |v| cnx.quote(v) }.join(', ')
        sql = %(
          INSERT INTO #{table_name}
            (id, name, location, website_url, description, active, created_at, updated_at)
            VALUES (#{values_clause})
        )
        cnx.insert(sql)
        ahead!
      end
    end
  end
end
