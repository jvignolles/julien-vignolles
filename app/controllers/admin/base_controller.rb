class Admin::BaseController < ApplicationController
  include AdminLayout # See /app/concerns/admin_layout.rb
  include Admin::BaseHelper

  alias_method :current_user, :current_admin

  layout "admin_intern"

  MENU = {
    home:           { name: "Accueil",         url: "admin_home_path" },
    contacts:       { name: "Contacts",        url: "admin_contacts_path", badge: "@badge_contacts", badge_kind: "warning" },
    homepage:       { name: "Homepage",        url: "", children: {
      banners:        { name: "Bannières",       url: "admin_banners_path" },
      highlights:     { name: "Mises en avant",  url: "admin_highlights_path" },
    }},
    projects:       { name: "Projets",         url: "admin_projects_path" },
    experiences:    { name: "CV",              url: "", children: {
      companies:      { name: "Entreprises",     url: "admin_companies_path" },
      jobs:           { name: "Emplois",         url: "admin_jobs_path" },
      educations:     { name: "Études",          url: "admin_educations_path" },
      skills:         { name: "Compétences",     url: "admin_skills_path" },
    }},
    blog:           { name: "Blog",            url: "", children: {
      blog_topics:    { name: "Articles",        url: "admin_blog_topics_path" },
      blog_tags:      { name: "Tags",            url: "admin_blog_tags_path" },
    }},
    editorials:     { name: "Éditoriaux",      url: "admin_editorials_path" },
    configurations: { name: "Configuration",   url: "admin_configurations_path", condition: "current_admin.admin?" },
    admins:         { name: "Administrateurs", url: "admin_admins_admins_path" },
  }
end
