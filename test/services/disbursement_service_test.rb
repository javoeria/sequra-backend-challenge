require 'test_helper'

class DisbursementServiceTest < ActiveSupport::TestCase
  test 'should have keyword arguments' do
    assert_raises(ArgumentError) do
      DisbursementService.get(0, 2018)
    end
  end

  test 'create_all should not duplicate entries' do
    before = DisbursementService.get(week: 1, year: 2018, merchant_id: 1).size
    DisbursementService.create_all(week: 1, year: 2018)
    after = DisbursementService.get(week: 1, year: 2018, merchant_id: 1).size
    assert_equal(before, after)
    assert_equal(1, after)
  end
end
