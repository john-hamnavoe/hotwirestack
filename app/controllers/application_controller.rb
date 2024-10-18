class ApplicationController < ActionController::Base
  include Pagy::Backend
  include SearchSessionTokenable
  include SetCurrentRequestDetails
  include IndexViewable
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  # allow_browser versions: :modern

  protected

  def handle_create(record, params, redirect_path)
    if record.save
      redirect_to with_search_session_token(redirect_path), notice: t("messages.created", record_name: record.class.name.humanize)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def handle_update(record, params, redirect_path)
    if record.update(params)
      redirect_to with_search_session_token(redirect_path), notice: t("messages.updated", record_name: record.class.name.humanize)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def handle_destroy(record, redirect_path)
    record.destroy!

    redirect_to with_search_session_token(redirect_path), status: :see_other, notice: t("messages.destroyed", record_name: record.class.name.humanize)
  end
end
