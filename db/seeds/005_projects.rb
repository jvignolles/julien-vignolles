class Seeder
  PROJECTS = [
    [1,  '2009', false, 6, 'Makila',               'http://www.makila.fr',              'Agence spécialiste du voyage sur mesure'],
    [2,  '2010', true,  6, 'Urbanlocker',          'http://www.urbanlocker.com',        'E-boutique vêtements et accessoires streetwear US'],
    [3,  '2011', false, 6, 'Galerie Chic',         'http://www.galerie-chic.fr',        'E-boutique de vêtements et accessoires de marque'],
    [4,  '2011', false, 6, 'Hyperparapharmacie',   'http://www.hyperparapharmacie.com', 'Parapharmacie en ligne'],
    [5,  '2012', true,  6, 'Pharmasimple',         'http://pharmasimple.com',           'Parapharmacie en ligne'],
    [6,  '2012', true,  6, 'Color Industry',       'http://www.color-industry.fr',      'E-boutique streewear et sportwear'],
    [7,  '2012', false, 6, 'E-Shop Bensimon',      'http://eshop.bensimon.com',         'E-boutique Bensimon'],
    [8,  '2013', false, 7, 'Mégarésa',             'https://www.megaresa.com',          'Solution de prise de rendez-vous en ligne pour auto-école'],
    [9,  '2014', false, 7, 'Auto-école Maillotte', 'http://www.autoecolemaillotte.fr',  'Auto-école à Bensançon'],
    [10, '2014', false, 7, 'Delphine Castagné',    'http://www.delphinecastagne.com',   'Coach pour professionnel et particulier'],
    [11, '2014', true,  7, 'Voyages Couture',      'http://www.voyagescouture.com',     'Agence de voyage sur mesure'],
    [12, '2014', false, 7, 'N&M Box',              'http://www.nmbox.fr',               'Location d’espace de stockage à Toulon'],
  ].freeze

  def seed_projects
    table_name = 'projects'
    seeding table_name
    clear_table table_name
    progress do
      now = Time.now.to_s(:db)
      count = PROJECTS.count
      PROJECTS.each_with_index do |item, index|
        values_clause = (item + [random_html_description, count - index, 1, now, now]).map { |v| cnx.quote(v) }.join(', ')
        sql = %(
          INSERT INTO #{table_name}
            (id, year, highlight, job_id, name, website_url, company_description, description, position, active, created_at, updated_at)
            VALUES (#{values_clause})
        )
        cnx.insert(sql)
        ahead!
      end
    end
  end
end
