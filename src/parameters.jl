"""
Parameter struct that holds all parameters that define the default model setup.
With keywords such that default values can be changed at creation.
"""
@with_kw struct Params

    # NUMBER FORMATS
    T::DataType=Float64     # number format

    # RESOLUTION
    nlon::Int=96            # number of longitudes
    nlat::Int=48            # number of latitudes
    nlev::Int=8             # number of vertical levels
    trunc::Int=30           # spectral truncation
    ntracers::Int=1         # number of tracers (specific humidity is one)

    # PHYSICAL CONSTANTS
    R_earth::Real=6.371e6   # Radius of Earth [m]
    Ω::Real=7.292e-5        # Angular frequency of Earth's rotation [1/s]
    g::Real=9.81            # Gravitational acceleration [m/s^2]
    akap::Real=2/7          # Ratio of gas constant to specific heat of dry air
                            # at constant pressure = 1 - 1/γ where γ is the
                            # heat capacity ratio of a perfect diatomic gas (7/5)
    cp::Real=1004.0         # Specific heat at constant pressure [J/K/kg]
    R::Real=akap*cp         # Specific gas constant for dry air [J/kg/K]
    alhc::Real=2501.0       # Latent heat of condensation [J/g] for consistency with
                            # specific humidity [g/Kg]
    alhs::Real=2801.0       # Latent heat of sublimation [?]
    sbc::Real=5.67e-8       # Stefan-Boltzmann constant [W/m^2/K^4]

    # STANDARD ATMOSPHERE
    γ::Real=6.0             # Reference temperature lapse rate -dT/dz [deg/km]
    Tabs_ref::Real=288      # Reference absolute temperature at surface z=0 [K]
    Tabs_top::Real=216      # Reference absolute temperature in stratosphere [K]
    hscale::Real=7.5        # Reference scale height for pressure [km]
    p0::Real=1e5            # Reference pressure [Pa]   TODO where is this needed?
    p_ref::Real=1013        # Reference pressure [hPa]
    hshum::Real=2.5         # Reference scale height for specific humidity [km]
    rh_ref::Real=0.7        # Reference relative humidity of near-surface air
    es_ref::Real=17         # Reference saturation water vapour pressure [Pa]

    # PARAMETERIZATIONS
    seasonal_cycle::Bool=true   # Seasonal cycle?
    n_shortwave::Int=3          # Compute shortwave radiation every n steps
    sppt_on::Bool=false         # Turn on SPPT?

    # TIME STEPPING
    nstepsday::Int=36           # number of time steps in one day
    Δt::Real=86400/nstepsday    # time step in seconds
    ndays::Real=10              # number of days to integrate for

    # NUMERICS
    robert::Real=0.05           # damping factor in Robert time filter
    williams::Real=0.53         # parameter of Williams filter
    α::Real=0.5                 # coefficient for semi-implicit computations
                                # 0 -> forward step for gravity wave terms,
                                # 1 -> backward implicit
                                # 0.5 -> centered implicit

    # BOUNDARY FILES
    boundary_path::String=""      # package location is default
    boundary_file::String="surface.nc"

    # INITIAL CONDITIONS
    initial_conditions::String="rest"

    # OUTPUT
    print_dialog::Bool=true     # Print dialog for feedback
    output::Bool=false          # Store data in netCDF?
    output_dt::Real=6           # output time step [hours]
    outpath::String=pwd()       # path to output folder

    # TODO assert not allowed parameter values
    @assert α in [0,0.5,1] "Only semi-implicit α = 0, 0.5 or 1 allowed."
end
