class Admin::MoneyTransactionsController < Admin::BaseController
  def index

  end

  def upload
    transactions_file = params[:transactions_file]
    if transactions_file.is_a?(ActionDispatch::Http::UploadedFile)
      if transactions_file.content_type == 'text/csv'
        flash[:notice] = 'YAAY'
        manager = TransactionsImport::Manager.new(transactions_file.tempfile)
        manager.import!
      else
        flash[:notice] = 'Uploaded file must be a CSV file.'
      end
    else
      flash[:notice] = 'Please select a file to upload.'
    end

    render :index
  end
end
