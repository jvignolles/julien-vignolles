class Seeder
  JOBS = [
    [1, '2003-05-01', '2003-12-31', 1, 'Développeur Java'],
    [2, '2004-01-01', '2004-04-30', 2, 'Professeur assistant Java / J2EE et MySQL'],
    [3, '2004-06-01', '2004-11-30', 3, 'Développeur Java'],
    [4, '2004-12-01', '2005-10-15', 4, 'Développeur Java / J2EE'],
    [5, '2005-10-16', '2007-09-30', 5, 'Consultant ITIL'],
    [6, '2007-10-01', '2013-01-15', 6, 'Ingénieur R&D Ruby on Rails / Chef de projet web'],
    [7, '2013-01-16', nil,          7, 'Développeur fullstack Ruby on Rails'],
  ].freeze

  def seed_jobs
    table_name = 'jobs'
    seeding table_name
    clear_table table_name
    progress do
      now = Time.now.to_s(:db)
      JOBS.each do |item|
        values_clause = (item + [random_html_description, 1, now, now]).map { |v| cnx.quote(v) }.join(', ')
        sql = %(
          INSERT INTO #{table_name}
            (id, started_on, ended_on, company_id, name, description, active, created_at, updated_at)
            VALUES (#{values_clause})
        )
        cnx.insert(sql)
        ahead!
      end
    end
  end
end
