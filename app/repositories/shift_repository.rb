class ShiftRepository
  class << self
    # Uma instalação (Facility) deve estar ativa.
    # O turno deve estar ativo e não reivindicado por outra pessoa.
    # O trabalhador deve estar ativo.
    # O Trabalhador não deve ter reivindicado um turno que colida com o turno para o qual é elegível.
    # As profissões entre Turno e Trabalhador devem coincidir.
    # O Trabalhador deverá possuir todos os documentos exigidos pelas instalações.

    def shifts_for_worker_and_facility(worker, facility, start_date, end_date)
      Shift
        .active
        .unclaimed
        .with_facility(facility.id)
        .with_date_range(start_date, end_date)
        .with_profession(worker.profession)
        .with_availability_for_worker(worker, start_date, end_date)
        .distinct
    end
  end
end
