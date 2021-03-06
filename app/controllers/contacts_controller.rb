class ContactsController < ApplicationController
  before_action :set_contact, only: [:show, :update, :destroy]

  # GET /contacts
  def index
    @contacts = Contact.all

    # only: mostra apenas o que foi pedido, ex: only: [:name, :email]
    # except: o inverso do only
    # status: mostra o status da requisição, etc: status: :ok
    # method: adiciona um campo na resposta (Adicionar no model)

    render json: @contacts #, methods: [:birthdate_br]
  end

  # GET /contacts/1
  def show
    render json: @contact , include: [:kind, :address, :phone] #, meta: {author: "Jhonata"}
  end

  # POST /contacts
  def create
    @contact = Contact.new(contact_params)

    if @contact.save
      render json: @contact, include: [:kind, :phones, :address], status: :created, location: @contact
    else
      render json: @contact.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /contacts/1
  def update
    if @contact.update(contact_params)
      render json: @contact, include: [:kind, :phones, :address]
    else
      render json: @contact.errors, status: :unprocessable_entity
    end
  end

  # DELETE /contacts/1
  def destroy
    @contact.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contact
      @contact = Contact.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def contact_params
      params.require(:contact).permit(
        :name,
        :email,
        :birthdate,
        :kind_id,
        phones_attributes:
          [:id, :number, :_destroy],
        address_attributes:
          [:id, :street, :city]
      )
    end
end
