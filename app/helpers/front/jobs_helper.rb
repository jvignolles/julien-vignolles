module Front::JobsHelper
  SECONDS_IN_A_DAY = 24 * 60 * 60
  DAYS_IN_A_MONTH = 365.0 / 12
  MONTHS_IN_A_YEAR = 12.0

  def format_job_duration(job)
    s = job.started_on
    e = (job.ended_on || Time.zone.now.to_date)
    days = total_days = (e - s).to_i
    duration = [0, 0, 0]
    duration[1] = (days / DAYS_IN_A_MONTH).round
    if MONTHS_IN_A_YEAR <= duration[1]
      duration[0] = (duration[1] / MONTHS_IN_A_YEAR).floor
      duration[1] = [duration[1] - (duration[0] * MONTHS_IN_A_YEAR).round, 0].max
    end
    duration[2] = [days - (((duration[0] * MONTHS_IN_A_YEAR).round + duration[1]) * DAYS_IN_A_MONTH).round, 0].max
    in_words = []
    if 0 < duration[0]
      in_words << "#{pluralize(duration[0], "an")}"
    end
    if 0 < duration[1]
      in_words << "#{pluralize(duration[1], "mois")}"
    end
    # Less than 2 months
    if 0 >= duration[0] && 2 >= duration[1] && 0 < duration[2]
      in_words << "#{pluralize(duration[2], "jour")}"
    end
    in_words.join(", ")
  end
end
