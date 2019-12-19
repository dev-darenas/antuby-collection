class NotesController < ApplicationController
  before_action :load_note, only: %w(edit update)

  def index
    @model = params[:model]
              .constantize
              .table_name
              .singularize
              .camelize
    @id = params[:id]

    @notes = params[:model].constantize
                           .find(params[:id])
                           .notes
                           .includes(:user)
                           .order(created_at: :desc)
  end

  def new
    @note = Note.new(
              notable: params[:model].constantize.find(params[:id])
            )
  end

  def create
    @note = current_user.notes.new(note_params)

    respond_to do |format|
      if @note.save
        flash.now[:success] = 'Nota creada'
        format.js { render action: :show }
      else
        flash.now[:error] = @edit.errors.details
        format.js { render action: :new }
      end
    end
  end

  def show
  end

  def edit
  end

  def update
    respond_to do |format|
      if @note.update(note_params)
        flash.now[:success] = 'Nota creada'
      else
        flash.now[:error] = @edit.errors.details
      end

      format.js { render action: :show }
    end
  end

  private

  def note_params
    params.require(:note)
      .permit(
        :description,
        :notable_type,
        :notable_id
      )
  end

  def load_note
    @note = Note.find(require_id)
  end
end
