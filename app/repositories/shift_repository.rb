class ShiftRepository
  class << self
    # O turno deve estar ativo e não reivindicado por outra pessoa.
    # Uma instalação (Facility) deve estar ativa.
    # O trabalhador deve estar ativo.
    # As profissões entre Turno e Trabalhador devem coincidir.
    # O Trabalhador deverá possuir todos os documentos exigidos pelas instalações.
    # O Trabalhador não deve ter reivindicado um turno que colida com o turno para o qual é elegível.

    def shifts_for_worker_and_facility(worker, facility, start_date, end_date)
      shifts = Shift
               .active
               .unclaimed
               .with_facility(facility.id)
               .with_profession(worker.profession)
               .with_date_range(start_date, end_date)
               .distinct

      shifts.where.not(id: overlapping_shift_ids(worker, shifts))
    end

    private

    def overlapping_shift_ids(worker, shifts)
      return if shifts.empty? || worker.shifts.empty?

      worker_shift_ranges = worker.shifts.pluck(:start, :ends_at)

      overlapping_shifts_query = worker_shift_ranges.map do |_range|
        '(start, ends_at) OVERLAPS (?, ?)'
      end.join(' OR ')

      shifts.where(overlapping_shifts_query, *worker_shift_ranges.flatten).pluck(:id)
    end
  end
end
