class SheetsController < ApplicationController

  before_action :authorize, only: [:create, :destroy]

  def create  
    service = Google::Apis::SheetsV4::SheetsService.new
    service.client_options.application_name = APPLICATION_NAME
    service.authorization = authorize
  
    spreadsheet = {
      properties: {
        title: 'Daily Report'
      }
    }
    spreadsheet = service.create_spreadsheet(spreadsheet,
                                             fields: 'spreadsheetId')
    puts "Spreadsheet ID: #{spreadsheet.spreadsheet_id}"    

    Sheet.create(sheet_id: spreadsheet.spreadsheet_id)
  end

  
  def destroy
    sheets = Sheet.find(params[:sheet_id])
    sheets.destroy
  end
  
  
  
  
  
  
  
  
  private

  def authorize
    client_id = Google::Auth::ClientId.from_file CREDENTIALS_PATH
    token_store = Google::Auth::Stores::FileTokenStore.new file: TOKEN_PATH
    authorizer = Google::Auth::UserAuthorizer.new client_id, SCOPE, token_store
    user_id = "default"
    credentials = authorizer.get_credentials user_id
    if credentials.nil?
      url = authorizer.get_authorization_url base_url: OOB_URI
      puts "Open the following URL in the browser and enter the " \
               "resulting code after authorization:\n" + url
      code = gets
          credentials = authorizer.get_and_store_credentials_from_code(
              user_id: user_id, code: code, base_url: OOB_URI
          )
    end
      credentials
  end
  
  
end
