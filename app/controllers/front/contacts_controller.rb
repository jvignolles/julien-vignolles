class Front::ContactsController < Front::BaseController
  before_filter :check_contacts_active

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
  def check_contacts_active
    unless @configuration.contacts_active
      redirect_to front_home_path
      return false
    end
    true
  end

  def init_view
    @editorial = Editorial.find_by_kind(:contact)
    @front_kind = "contacts"
    @active_menus << :contacts
    @page_heading = "Me contacter"
    @breadcrumbs << { key: "contacts", name: "Contact", url: new_front_contact_path }

    # SEO
    @page_title = "#{@page_heading} • #{app_name}"
    add_seo_fields @editorial
  end
end
