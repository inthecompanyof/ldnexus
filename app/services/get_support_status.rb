class GetSupportStatus < Struct.new(:support)
  NEW_RANGE        = 0..1
  OK_RANGE         = 2..3
  WORRYING_RANGE   = 4..5

  def commence!
    days = (support.created_at.to_date..Date.today).count
    comments_coefficient = support.discussed? ? 0 : 1
    score = days + comments_coefficient
    status_label_by_score(score)
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
