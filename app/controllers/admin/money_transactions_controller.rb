class Admin::MoneyTransactionsController < Admin::BaseController
  def index

  end

  def upload
    transactions_file = params[:transactions_file]
    if transactions_file.is_a?(ActionDispatch::Http::UploadedFile)
      if transactions_file.content_type == 'text/csv'
        manager = TransactionsImport::Base.build_import_by_type(params[:transactions_type], transactions_file.tempfile)
        manager.import!

        flash[:notice] = "Successful: #{manager.successful_transactions.size + manager.new_transactions.size}.
                          Added: #{manager.new_transactions.size}.
                          Rejected: #{manager.rejected_transactions.size}."
      else
        flash[:notice] = 'Uploaded file must be a CSV file.'
      end
    else
      flash[:notice] = 'Please select a file to upload.'
    end

    render :index
  end
end
