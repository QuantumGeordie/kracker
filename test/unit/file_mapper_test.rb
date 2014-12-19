require 'test_helper'

class FileMapperTest < DomGlancyTestCase

  def setup
    prep_locations_for_test
  end

  def teardown
    delete_test_locations
  end

  def test_file_mapper_run
    test_name = 'gram_parsons'

    file_mapper = DomGlancy::FileMapper.new
    file_mapper.stubs(:map_page).returns(mapping_json)
    result = file_mapper.run(test_name)

    assert result[0], 'Mapping result should be true to indicate successful mapping'
    assert_equal '', result[1], 'empty string error message from a successful mapping'

    files_in_current_dir = Dir[File.join(DomGlancy.configuration.current_file_location, '*')]
    assert_equal 1, files_in_current_dir.count
    assert_equal files_in_current_dir.first, File.join(DomGlancy.configuration.current_file_location, "#{test_name}.yaml")
  end

  def mapping_json
    "--- - id: '12'   height: 238   visible: true   tag: DIV   width: 720   class: grid   left: 43   top: 14 - id: '14'   height: 0   visible: true   tag: SPAN   width: 0   class: mm--title_text_sub   left: 71   top: 86 "
  end
end
