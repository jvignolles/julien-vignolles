class Front::ContactsController < Front::BaseController
  def index
    return redirect_to(new_front_contact_path)
  end

  def new
    @contact = Contact.new
    @contact.subject = "J’ai une question…" if @contact.subject.blank?
    init_view
  end

  def create
    p = params.require(:contact).permit([:name, :email, :phone, :subject, :description])
    @contact = Contact.new(p)
    if @contact.save
      Notifier.contact({
        :contact => @contact,
      }).deliver # delay # SIDEKIQ
      flash[:notice] = "Votre message a bien été envoyé"
      return redirect_to(new_front_contact_path)
    end
    init_view
    render :new
  end

private
  def init_view
    @editorial = Editorial.find_by_kind(:contact)
    @front_kind = "contacts"
    @active_menus << :contacts
    @page_heading = "Me contacter"
    @page_title = "#{@page_heading} | #{app_name}"
    @breadcrumbs << { key: "contacts", name: "Contact", url: new_front_contact_path }
  end
end
