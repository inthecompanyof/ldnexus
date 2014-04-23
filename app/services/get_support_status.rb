class GetSupportStatus < Struct.new(:support)
  NEW_RANGE        = 0..1.day
  OK_RANGE         = 1.day..2.days
  WORRYING_RANGE   = 2.days..4.days

  def commence!
    time_diff = Time.zone.now - Time.zone.at(support.created_at)
    score_booster = support.discussed? ? 0 : 12.hours
    score = time_diff + score_booster
    status_label_by_score score
  end

  private

  def status_label_by_score(score)
    ranges = [
      { range: NEW_RANGE, name: 'new' },
      { range: OK_RANGE, name: 'ok' },
      { range: WORRYING_RANGE, name: 'worrying' }
    ]
    result = ranges.find { |r| r[:range].include?(score) } || {}
    result.fetch :name, 'critical'
  end
end
