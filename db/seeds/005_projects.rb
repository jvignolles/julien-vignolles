class Seeder
  PROJECTS = [
    [1,  '2009', false, 6, 'Makila',               'http://www.makila.fr'],
    [2,  '2010', true,  6, 'Urbanlocker',          'http://www.urbanlocker.com'],
    [3,  '2011', false, 6, 'Galerie Chic',         'http://www.galerie-chic.fr'],
    [4,  '2011', false, 6, 'Hyperparapharmacie',   'http://www.hyperparapharmacie.com'],
    [5,  '2012', true,  6, 'Pharmasimple',         'http://pharmasimple.com'],
    [6,  '2012', true,  6, 'Color Industry',       'http://www.color-industry.fr'],
    [7,  '2012', false, 6, 'E-Shop Bensimon',      'http://eshop.bensimon.com'],
    [8,  '2013', false, 7, 'Mégarésa',             'https://www.megaresa.com'],
    [9,  '2014', false, 7, 'Auto-école Maillotte', 'http://www.autoecolemaillotte.fr'],
    [10, '2014', false, 7, 'Delphine Castagné',    'http://www.delphinecastagne.com'],
    [11, '2014', true,  7, 'Voyages Couture',      'http://www.voyagescouture.com'],
    [12, '2014', false, 7, 'N&M Box',              'http://www.nmbox.fr'],
  ].freeze

  def seed_projects
    table_name = 'projects'
    seeding table_name
    clear_table table_name
    progress do
      now = Time.now.to_s(:db)
      PROJECTS.each do |item|
        values_clause = (item + [random_html_description, 1, now, now]).map { |v| cnx.quote(v) }.join(', ')
        sql = %(
          INSERT INTO #{table_name}
            (id, year, highlight, job_id, name, website_url, description, active, created_at, updated_at)
            VALUES (#{values_clause})
        )
        cnx.insert(sql)
        ahead!
      end
    end
  end
end
