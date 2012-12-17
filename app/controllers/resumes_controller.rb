class ResumesController < ApplicationController
  before_filter :signed_in_user
  
  # GET /resumes
  # GET /resumes.json
  def index
    @resumes = current_user.resumes

      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @resumes }
      end
 #   end
  end

  # GET /resumes/1
  # GET /resumes/1.json
  def show
    @resume = Resume.find(params[:id])
    tag = Tag.find(@resume.tag_id)

    @positions = tag.positions.order("start_date DESC").uniq
    @activities = tag.activities.order("start_date DESC").uniq
    @awards = tag.awards.order("date DESC").uniq
    @education = tag.education.order("start_date DESC").uniq
    @skills = tag.skills

    @user_info = @resume.get_user_info

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /resumes/new
  # GET /resumes/new.json
  def new
    @resume = current_user.resumes.new
    @styles = Style.create_styles_array
    @tags = current_user.tags

    respond_to do |format|
      format.html
      format.json { render :partial => "resumes/show.json" }
    end
  end

  # GET /resumes/1/edit
  def edit
    @resume = Resume.find(params[:id])
    @styles = Style.create_styles_array
    @tags = current_user.tags
  end

  # POST /resumes
  # POST /resumes.json
  def create
    @resume = current_user.resumes.new(params[:resume])

    respond_to do |format|
      if @resume.save
        flash[:success] = 'Resume was successfully created.'
        format.html { redirect_to @resume }
        format.json { render json: @resume, status: :created, location: @resume }
      else
        format.html { render action: "new" }
        format.json { render json: @resume.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /resumes/1
  # PUT /resumes/1.json
  def update
    @resume = Resume.find(params[:id])

    respond_to do |format|
      if @resume.update_attributes(params[:resume])
        flash[:success] = 'Resume was successfully updated.'
        format.html { redirect_to @resume }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @resume.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /resumes/1
  # DELETE /resumes/1.json
  def destroy
    @resume = Resume.find(params[:id])
    @resume.destroy

    respond_to do |format|
      format.html { redirect_to resumes_url }
      format.json { head :no_content }
    end
  end

  def export
    @resume = Resume.find(params[:id])
    tag = Tag.find(@resume.tag_id)

    @positions = tag.positions.order("start_date DESC")
    @activities = tag.activities.order("start_date DESC")
    @awards = tag.awards.order("date DESC")
    @education = tag.education.order("start_date DESC")
    @skills = tag.skills


#    @data = @tag.build_resume_by_tag
    @user_info = @resume.get_user_info

        render :pdf => "resume", 
               :template => "/resumes/export.html.erb",
               :show_as_html => params[:debug].present? # renders html version if you set debug=true in URL
#               :user_style_sheet => @resume.style.screen_filename.path
#               :user_style_sheet => 'test1'
  end

  def analyze
    # Figure out the resume and tag to analyze
    @resume = Resume.find(params[:id])
    tag = Tag.find(@resume.tag_id)

    # Get the appropriate resume content
    experiences = tag.experiences
    activities = tag.activities
    awards = tag.awards
    education = tag.education
    skills = tag.skills

    # Combine all the elements into one string
    string = combine_strings(experiences, "description")
    string << combine_strings(awards, "description")
    string << combine_strings(education, "major")
    string << combine_strings(skills, "description")

    # Break up the string and count the frequency of each word
    @frequency_array = split_and_count(string)

    data_table = GoogleVisualr::DataTable.new
    data_table.new_column('string', 'Word')
    data_table.new_column('number', 'Frequency')

    data_table_array = Array.new
    @frequency_array.each do |key, value|
      temp_array = Array.new
      temp_array << key.to_s
      temp_array << value

      data_table_array << temp_array
    end

    chart_height = data_table_array.count * 15

    data_table.add_rows(data_table_array)
    option = { width: 250, 
               height: chart_height, 
               fontSize: 12, 
               :legend => 'none', 
               bar: { :groupWidth => '90%' }, 
               vAxis: { :textPosition => 'out' },
               chartArea: { :left => '40%', :top => 20, :height => '100%', :width => '100%' }
             }
#    formatter = GoogleVisualr::BarFormat.new()
#    formatter.columns(1)

#    data_table.format(formatter)
#    options = { :width => 300, :allowHtml => true }
#    @chart = GoogleVisualr::Interactive::Table.new(data_table, options)
     @chart = GoogleVisualr::Interactive::BarChart.new(data_table, option)

    respond_to do |format|
      format.html
    end
  end

  def map
    @resume = Resume.find(params[:id])

    respond_to do |format|
      format.html
    end
  end

  def get_map_data
    @resume = Resume.find(params[:id])
#    @tag = Tag.find(@resume.tag_id)

#    map = Array.new
#    map += tag.awards
#    map += tag.activities
#    map += tag.education
#    map += tag.positions

#    sorted_map = map.sort_by(&:start_date)

@map_data = Analysis.map_json(@resume.tag_id)

    respond_to do |format|
      format.json
    end
  end

  private
    def combine_strings(data, method_name)
      string = " "

      # Check hwo method name was provided and convert to symbol if necessary
      case method_name
        when Symbol
          method = method_name
        when String
          method = method_name.gsub(/\s+/, "_").downcase.to_sym
        else
          return false
      end

      # Move through the data and combine into one string
      data.each do |d|
        string << ' ' 
        string << d[method]
      end

      return string
    end

    def split_and_count(data_string)
      # Split the string of any non alpha-numeric character
      data_array = data_string.split(/[^a-zA-Z0-9-]+/)

      # Remove stop words
      stop_words = ['a','able','about','across','after','all','almost','also','am','among','an',
                    'and','any','are','as','at','be','because','been','but','by','can','cannot',
                    'could','dear','did','do','does','either','else','ever','every','for','from',
                    'get','got','had','has','have','he','her','hers','him','his','how','however',
                    'i','if','in','into','is','it','its','just','least','let','like','likely','may',
                    'me','might','most','must','my','neither','no','nor','not','of','off','often',
                    'on','only','or','other','our','own','rather','said','say','says','she','should',
                    'since','so','some','than','that','the','their','them','then','there','these',
                    'they','this','tis','to','too','twas','us','wants','was','we','were','what','when',
                    'where','which','while','who','whom','why','will','with','would','yet','you','your']
      data_array.delete(:"")
      data_array.delete(/[^a-zA-Z0-9]+/)

      # Create a hash to store the values
      frequency = Hash.new

      data_array.each do |word|
        # Check whether the word is in the stop word list
        if !stop_words.include?(word.downcase)
          if frequency.include?(word.downcase.to_sym)
            # Increment the count for the word
            frequency[word.downcase.to_sym] += 1
          else
            frequency[word.downcase.to_sym] = 1
          end
        end
      end

      # Sort by frequency count

      return frequency
    end
end
