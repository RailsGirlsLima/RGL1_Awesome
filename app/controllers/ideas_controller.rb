class IdeasController < ApplicationController
  # GET /ideas
  # GET /ideas.json
  #Creación de una Función para Compartir El elemento, que en este caso es LA FOTO
  def share
      #Buscando a la que el usuario ha hecho en compartir
       @idea = Idea.find(params[:id])
     
    #configuracion de la gemma Twitter 

      Twitter.configure do |config|
      config.consumer_key = "kSyEvTahZySRd8ov1yMhFA"
      config.consumer_secret = "AmtWEpwHLIp70TkZOMsOEvbWH5eWj8yQBTYKFplhg"
      end
     #publicando
      twitter = Twitter::Client.new(oauth_token: session["token"], oauth_token_secret: session["secret"])
      twitter.update(@idea.picture)
      #redireccionando hacia el home
      redirect_to "/"

  end
   #aqui regresa al index
  def index
    @ideas = Idea.all
    #aqui se obtienen los datos de la persona que esta accediendo, si esque existen los datos
    @name  = request.env["omniauth.auth"]["info"]["name"] if request.env["omniauth.auth"]

    @avatar = request.env["omniauth.auth"]["info"]["image"] if request.env["omniauth.auth"]

    session["token"] = request.env["omniauth.auth"]["credentials"]["token"] if request.env["omniauth.auth"]
    session["secret"] = request.env["omniauth.auth"]["credentials"]["secret"] if request.env["omniauth.auth"]
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @ideas }
    end
  end

  # GET /ideas/1
  # GET /ideas/1.json
  def show
    @idea = Idea.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @idea }
    end
  end

  # GET /ideas/new
  # GET /ideas/new.json
  def new
    @idea = Idea.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @idea }
    end
  end

  # GET /ideas/1/edit
  def edit
    @idea = Idea.find(params[:id])
  end

  # POST /ideas
  # POST /ideas.json
  def create
    @idea = Idea.new(params[:idea])

    respond_to do |format|
      if @idea.save
        format.html { redirect_to @idea, notice: 'Idea was successfully created.' }
        format.json { render json: @idea, status: :created, location: @idea }
      else
        format.html { render action: "new" }
        format.json { render json: @idea.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /ideas/1
  # PUT /ideas/1.json
  def update
    @idea = Idea.find(params[:id])

    respond_to do |format|
      if @idea.update_attributes(params[:idea])
        format.html { redirect_to @idea, notice: 'Idea was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @idea.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ideas/1
  # DELETE /ideas/1.json
  def destroy
    @idea = Idea.find(params[:id])
    @idea.destroy

    respond_to do |format|
      format.html { redirect_to ideas_url }
      format.json { head :no_content }
    end
  end
end
