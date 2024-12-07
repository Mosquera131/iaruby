class ResponsesController < ApplicationController
  def create
    @form = Form.find(params[:form_id])
    @response = @form.responses.create(response_params)
    redirect_to form_path(@form)
  end

  private
    # Only allow a list of trusted parameters through.
    def response_params
      params.expect(response: [ :ai_response, :body ])
    end
end
