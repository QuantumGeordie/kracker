module DomGlancy
  class AnalysisReporter
    @test_root
    @set_current_not_master
    @set_master_not_current
    @set_changed_master
    @changed_pairs

    def initialize(test_root, set_current_not_master,set_master_not_current, set_changed_master, changed_pairs)
      @test_root              = test_root
      @set_current_not_master = set_current_not_master
      @set_master_not_current = set_master_not_current
      @set_changed_master     = set_changed_master
      @changed_pairs          = changed_pairs
    end

    def create_diff_file
      filename = ::DomGlancy::FileNameBuilder.new(@test_root).diff
      svg = make_svg
      File.open(filename, 'w') { |file| file.write(svg) }
      save_set_info('current_not_master', @set_current_not_master)
      save_set_info('master_not_current', @set_master_not_current)
      save_set_info('changed_master',     @set_changed_master)
      save_set_info('changed_pairs',      @changed_pairs)
    end

    private

    def make_svg
      svg = ::DomGlancy::SVG.new(@set_current_not_master, @set_master_not_current, @set_changed_master)
      svg.generate_svg
    end

    def save_set_info(suffix, data_set)
      filename = File.join(::DomGlancy.configuration.diff_file_location, "#{@test_root}__#{suffix}__diff.yaml")
      File.open(filename, 'w') { |file| file.write(data_set.to_a.to_yaml) }
    end
  end
end
