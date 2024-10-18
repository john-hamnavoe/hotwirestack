class BoardsController < ApplicationController
  include SearchSessionManageable
  index_viewable Board
  before_action :set_board, only: %i[show edit update destroy]

  # GET /boards or /boards.json
  def index
    @query, @pagy, @boards = apply_search_session(Board.includes(:owner), @index_view)
  end

  # GET /boards/1 or /boards/1.json
  def show
  end

  # GET /boards/new
  def new
    @board = Board.new
  end

  # GET /boards/1/edit
  def edit
  end

  # POST /boards or /boards.json
  def create
    @board = Board.new(board_params)
    @board.owner ||= Current.user

    handle_create(@board, board_params, boards_path)
  end

  # PATCH/PUT /boards/1 or /boards/1.json
  def update
    handle_update(@board, board_params, boards_path)
  end

  # DELETE /boards/1 or /boards/1.json
  def destroy
    handle_destroy(@board, boards_path)
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_board
    @board = Board.find(params.expect(:id))
  end

  # Only allow a list of trusted parameters through.
  def board_params
    params.expect(board: [:name, :owner_id, :active])
  end
end
