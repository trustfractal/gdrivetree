require "google/apis/drive_v3"
require "googleauth"
require "googleauth/stores/file_token_store"

module GoogleTree
  OOB_URI = "urn:ietf:wg:oauth:2.0:oob".freeze
  APPLICATION_NAME = "Drive API Tree".freeze
  CREDENTIALS_PATH = "credentials.json".freeze
  TOKEN_PATH = "token.yaml".freeze
  SCOPE = Google::Apis::DriveV3::AUTH_DRIVE_METADATA_READONLY

  CACHE_FILE_PATH = "filescache"

  def self.authorize
    client_id = Google::Auth::ClientId.from_file(CREDENTIALS_PATH)
    token_store = Google::Auth::Stores::FileTokenStore.new(file: TOKEN_PATH)
    authorizer = Google::Auth::UserAuthorizer.new(client_id, SCOPE, token_store)
    user_id = "default"
    credentials = authorizer.get_credentials(user_id)

    if credentials.nil?
      url = authorizer.get_authorization_url(base_url: OOB_URI)
      puts "Open the following URL in the browser and enter the " \
           "resulting code after authorization:\n" +
           url

      code = gets

      credentials = authorizer.get_and_store_credentials_from_code(
        user_id: user_id,
        code: code,
        base_url: OOB_URI,
      )
    end

    credentials
  end

  def self.load_files cache: true
    service = Google::Apis::DriveV3::DriveService.new
    service.client_options.application_name = APPLICATION_NAME
    service.authorization = authorize

    if cache && File.exist?(CACHE_FILE_PATH)
      @files = Marshal.load(File.read(CACHE_FILE_PATH))
    else
      @files = []
      next_page_token = nil

      loop do
        response = service.list_files(
          corpora: "user",
          fields: "nextPageToken, files(id, name, parents, mime_type)",
          page_token: next_page_token,
          page_size: 1_000,
        )

        @files.concat response.files

        next_page_token = response.next_page_token

        break unless next_page_token
      end

      File.write(CACHE_FILE_PATH, Marshal.dump(@files)) if cache
    end

    @files
  end

  def self.children_of file
    @files.select { |f| f.parents&.include? file.id }
  end

  def self.folder? file
    file.mime_type == "application/vnd.google-apps.folder"
  end

  def self.dig file, node
    node[file] = children_of(file).map do |child_file|
      new_node = {}
      new_node[child_file] = []

      if folder? child_file
        dig child_file, new_node
      else
        new_node
      end
    end

    node
  end

  # XXX cache: true for development
  def self.generate folder_id, cache: false
    load_files cache: cache

    root_file = @files.find { |file| file.id == folder_id }

    dig root_file, {}
  end
end
