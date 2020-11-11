protocol ECLTaskCreating:
CityListTaskCreating,
VisitorsTaskCreating,
RateDataTaskCreating
{}

extension URLSession: ECLTaskCreating {}
extension URLSessionDataTask: Task{}
