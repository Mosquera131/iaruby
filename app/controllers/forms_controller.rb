class FormsController < ApplicationController
  before_action :set_form, only: %i[ show edit update destroy ]

  # GET /forms or /forms.json
  def index
    @forms = Form.all
  end

  # GET /forms/1 or /forms/1.json
  def show
    @form = Form.find(params[:id])
    @response = @form.response
  end

  # GET /forms/new
  def new
    @form = Form.new
  end

  # GET /forms/1/edit
  def edit
  end

  # POST /forms or /forms.json
  def create
    @form = Form.new(form_params)

    if @form.save

      # Llama al servicio OpenAI con el name y description
      service = OpenServices.new
      service.generate_and_store_response(@form)

     respuesta = openai_service.generate_and_store_response(@form.id, @form.name, @form.description)
     puts "esta es la respuesta"
     puts respuesta

      redirect_to @form, notice: "Formulario creado y respuesta generada."
    end
  rescue StandardError => e
      puts respuesta, e.message, status: :unprocessable_entity
  end




  # PATCH/PUT /forms/1 or /forms/1.json
  def update
    respond_to do |format|
      if @form.update(form_params)
        format.html { redirect_to @form, notice: "Form was successfully updated." }
        format.json { render :show, status: :ok, location: @form }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @form.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /forms/1 or /forms/1.json
  def destroy
    @form.destroy!

    respond_to do |format|
      format.html { redirect_to forms_path, status: :see_other, notice: "Form was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_form
      @form = Form.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def form_params
      params.require(:form).permit(:name, :description, :processed_in_job)
    end
end
