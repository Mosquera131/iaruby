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
      if @form.processed_in_job == "Job Encolado"
        flash[:notice] = "Tu solicitud está en proceso. Te notificaremos por correo cuando esté lista."
        # Encolar el trabajo para procesar la respuesta y manejar el correo
        ProcessOpenAiJob.perform_later(@form.id)
      else
        # Procesar directamente en el hilo principal
        response = ProcessOpenAiJob.new.perform(@form.id)
        flash[:notice] = "Formulario creado y procesado en el hilo principal. Respuesta: #{response}"
      end
      redirect_to @form
    else
      render :new, status: :unprocessable_entity
    end
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
      params.require(:form).permit(:name, :description, :processed_in_job, :email, :avatar)
    end
end
