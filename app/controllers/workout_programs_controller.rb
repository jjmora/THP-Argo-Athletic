class WorkoutProgramsController < ApplicationController
  before_action :current_workout_program, only: [:show, :edit, :update]

  def index
    @workout_programs = WorkoutProgram.all
  end

  def show
  end

  def new
    @workout_program = WorkoutProgram.new
    @user = current_user
    @profile = current_user.profile
    @profile_id = current_user.profile.id
    # @priority = WorkoutProgram.get_priority
    @level = @user.profile.level
    @sport = @user.profile.sport
    @role = @user.profile.sport_role
    @role_id = SportRole.where(name: @role).first.id
    @repetitions = Level.where(name: @level).first.repetitions
    @recuperation = Level.where(name: @level).first.recuperations
    @serie = Level.where(name: @level).first.series

    @rolesMGcap1 = RolesMuscularGroupCapacity.where(sport_role_id: @role_id).where(priority: 1)
    @cap_id1 = @rolesMGcap1.first.capacity_id
    @training_methods1 = TrainingMethod.where(capacity_id: @cap_id1)
    @mg_id1 = @rolesMGcap1.first.muscular_group_id
    @muscles1 = Muscle.where(muscular_group_id: @mg_id1)

    @rolesMGcap2 = RolesMuscularGroupCapacity.where(sport_role_id: @role_id).where(priority: 2)
    @cap_id2 = @rolesMGcap2.first.capacity_id
    @training_methods2 = TrainingMethod.where(capacity_id: @cap_id2)
    @mg_id2 = @rolesMGcap2.first.muscular_group_id
    @muscles2 = Muscle.where(muscular_group_id: @mg_id2)

    @rolesMGcap3 = RolesMuscularGroupCapacity.where(sport_role_id: @role_id).where(priority: 3)
    @cap_id3 = @rolesMGcap3.first.capacity_id
    @training_method = TrainingMethod.where(capacity_id: @cap_id3)
    @mg_id3 = @rolesMGcap3.first.muscular_group_id
    @muscles3 = Muscle.where(muscular_group_id: @mg_id3)


    ex_array_A = []
    @training_methods1.sample.exercises.uniq.each do |t|
      ex_array_A << t.name
    end

    ex_array_B = []
    @muscles1.each do |m|
      m.exercises.each do |x|
        ex_array_B  << x.name
      end 
    end

    @ex_array1 = ex_array_A & ex_array_B

    @var_array1 = []
    @ex_array1.each do |ex|
      @var_array1 << Exercise.where(name: ex).first.variants.uniq.sample.name 
    end

  end

  def create
    @workout_program = WorkoutProgram.new
    @user = current_user
    @profile = current_user.profile
    @profile_id = current_user.profile.id
    # @priority = WorkoutProgram.get_priority
    @level = @user.profile.level
    @sport = @user.profile.sport
    @role = @user.profile.sport_role
    @role_id = SportRole.where(name: @role).first.id
    @repetitions = Level.where(name: @level).first.repetitions
    @recuperation = Level.where(name: @level).first.recuperations
    @serie = Level.where(name: @level).first.series

    @rolesMGcap1 = RolesMuscularGroupCapacity.where(sport_role_id: @role_id).where(priority: 1)
    @cap_id1 = @rolesMGcap1.first.capacity_id
    @training_methods1 = TrainingMethod.where(capacity_id: @cap_id1)
    @mg_id1 = @rolesMGcap1.first.muscular_group_id
    @muscles1 = Muscle.where(muscular_group_id: @mg_id1)

    @rolesMGcap2 = RolesMuscularGroupCapacity.where(sport_role_id: @role_id).where(priority: 2)
    @cap_id2 = @rolesMGcap2.first.capacity_id
    @training_methods2 = TrainingMethod.where(capacity_id: @cap_id2)
    @mg_id2 = @rolesMGcap2.first.muscular_group_id
    @muscles2 = Muscle.where(muscular_group_id: @mg_id2)

    @rolesMGcap3 = RolesMuscularGroupCapacity.where(sport_role_id: @role_id).where(priority: 2)
    @cap_id3 = @rolesMGcap3.first.capacity_id
    @training_methods3 = TrainingMethod.where(capacity_id: @cap_id3)
    @mg_id3 = @rolesMGcap3.first.muscular_group_id
    @muscles3 = Muscle.where(muscular_group_id: @mg_id3)

    @ex_array1 = creating_array_exercises(@training_methods1, @muscles1)
    @ex_array2 = creating_array_exercises(@training_methods2, @muscles2)
    @ex_array3 = creating_array_exercises(@training_methods3, @muscles3)

    @var_array1 = creating_array_variants(@ex_array1)
    @var_array2 = creating_array_variants(@ex_array2)
    @var_array3 = creating_array_variants(@ex_array3)

    create_workout_program

    flash[:notice] = "Le programme d'entraînement à été crée"
    redirect_to user_path(current_user.id)

    # @workout_program = WorkoutProgram.create!(workout_program_params)

  end

  def edit
  end

  def update
    @workout_program.update(workout_program_params)

    redirect_to workout_program_path(@workout_program)
  end

  private

  def workout_program_params
    params.require(:workout_program).permit(:exercise, :training_method, :level, :repetition, :recuperation, :profile_id, :serie, :variant)
  end

  def current_workout_program
    @workout_program = WorkoutProgram.find(params[:id])
  end

  def create_workout_program
    @workout_program1 = WorkoutProgram.create!(
      exercise: @ex_array1, 
      training_method: @training_methods1.sample.name, 
      level:  @level, 
      repetition: @repetitions, 
      recuperation: @recuperation , 
      profile_id: @profile_id, 
      serie: @serie, 
      variant: @var_array1 
    )
    @workout_program2 = WorkoutProgram.create!(
      exercise: @ex_array2, 
      training_method: @training_methods2.sample.name, 
      level:  @level, 
      repetition: @repetitions, 
      recuperation: @recuperation , 
      profile_id: @profile_id, 
      serie: @serie, 
      variant: @var_array2 
    )
    @workout_program3 = WorkoutProgram.create!(
      exercise: @ex_array3, 
      training_method: @training_methods3.sample.name, 
      level:  @level, 
      repetition: @repetitions, 
      recuperation: @recuperation , 
      profile_id: @profile_id, 
      serie: @serie, 
      variant: @var_array3 
    )
  end


  # def rolesMGcap(role_id, priority)
  #   RolesMuscularGroupCapacity.where(sport_role_id: role_id).where(priority: priority)
  # end


  def creating_array_exercises(training_method, muscles)

    ex_array_A = []
    training_method.sample.exercises.uniq.each do |t|
      ex_array_A << t.name
    end

    ex_array_B = []
    muscles.each do |m|
      m.exercises.each do |x|
        ex_array_B  << x.name
      end 
    end

    ex_array = ex_array_A & ex_array_B

  end 

  def creating_array_variants(ex_array)
    var_array = []
    ex_array.each do |ex|
      var_array << Exercise.where(name: ex).first.variants.uniq.sample.name 
    end
    var_array
  end

  
end
