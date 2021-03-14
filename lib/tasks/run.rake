namespace :run do
  task disbursements_weekly: :environment do
    day = Time.zone.yesterday
    DisbursementService.create_all(week: day.cweek, year: day.year)
  end
end
