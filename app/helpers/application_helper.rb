module ApplicationHelper
  include ActionView::Helpers::TextHelper
  include FormatMethods

  def app_name
    @configuration.try(:app_name).present? ? @configuration.app_name : Figaro.env.app_name
  end

  def civilities(format = :short)
    ["mr", "mrs"].map { |code| [format_civility(code, format), code] }
  end

  def company_name
    @configuration.try(:company_name).present? ? @configuration.company_name : Figaro.env.company_name
  end

  def copyright_years
    year = Time.now.year
    year > Figaro.env.site_start_year.to_i ? "#{Figaro.env.site_start_year}&ndash;#{year}".html_safe : year.to_s
  end

  def dyn_image_url(name)
    (ActionController::Base.asset_host.present? ? '' : root_url[0..-2]) + image_path(name)
  end

  def email_contact
    @configuration.try(:email_contact).present? ? @configuration.email_contact : Figaro.env.email_contact
  end

  def format_date(date, format = :default)
    return '' if date.blank?
    date = date.to_date unless date.is_a?(Date)
    I18n.localize(date, format: format)
  end

  def format_education_dates(education, format = :month_year)
    dates = []
    dates << education.started_on.year if education.started_on.present?
    dates << education.ended_on.year if education.ended_on.present?
    dates.uniq.join(" - ")
  end

  def format_job_dates(job, format = :month_year)
    dates = [format_date(job.started_on, format)]
    if job.ended_on
      dates << format_date(job.ended_on, format)
    else
      dates << "aujourd’hui"
    end
    dates.join(" - ")
  end

  def i18n_simple_form_label(model, key)
    translation = I18n.t("simple_form.labels.#{model}.#{key}", default: "")
    translation = I18n.t("simple_form.labels.defaults.#{key}", default: "") if translation.blank?
    translation = I18n.t("activerecord.models.attributes.#{model}.#{key}", default: key.to_s.humanize) if translation.blank?
    translation
  end

  def icon(name, opts = {})
    classes = (opts.delete(:class) || "").to_s.split(" ")
    name = "glyphicon glyphicon-#{name}" unless name.starts_with?("glyphicon-")
    classes << name
    opts.merge!(:class => classes)
    capture_haml do
      haml_tag(:i, "", opts)
    end
  end

  def image_url(source)
    URI.join(root_url, image_path(source))
  end

  def inside_layout(layout = "application", &block)
    render :inline => capture(&block), :layout => "layouts/#{layout}"
  end

  def on_production_site?
    Rails.env.production? && Figaro.env.production_site.to_bool
  end

  def simple_form_classes(classes = [])
    a = SimpleForm.default_form_class.split(" ") || []
    a += ["form-regular", "form-with-alerts"]
    a += classes.is_a?(String) ? classes.split(" ") : classes
    a.uniq
  end

  def split_on_the_middle(str)
    m = str.length / 2
    i1 = str[0..(m-1)].rindex(/\s/)
    i2 = str.index(/\s/, m)
    n = [i1, i2].reject(&:nil?).min { |x| (x - m).abs }
    [str[0..(n-1)], str[(n+1)..-1]]
  end

  def span_on_2_lines(str)
    capture_haml do
      split_on_the_middle(str).map do |x|
        haml_tag :span, x
      end
    end
  end

  def trunc(text, length = 20)
    truncate(text, length: length, omission: '…')
  end

  def trunc_html(text, length = 30)
    trunc(HTMLEntities.new.decode(ActionController::Base.helpers.strip_tags(text)), length)
  end

  def has_flashes?
    flash.present? && (arr = [:error, :alert, :notice, :h_alert, :h_notice] & flash.keys.map(&:to_sym)).present? && (arr.detect { |x| flash[x].present? })
  end

  BOOTSTRAP_ALERT_LEVEL = {
    error:     "danger",
    alert:     "danger",
    notice:    "success",
    warning:   "warning",
    h_error:   "danger",
    h_alert:   "danger",
    h_notice:  "success",
    h_warning: "warning",
  }

  def alert_for(level)
    BOOTSTRAP_ALERT_LEVEL[level] || "info"
  end
end
