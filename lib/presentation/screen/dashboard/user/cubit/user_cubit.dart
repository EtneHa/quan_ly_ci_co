import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quan_ly_ci_co/core/apps/enums/base_screen_state.dart';
import 'package:quan_ly_ci_co/data/remote/request/pagination_params.dart';
import 'package:quan_ly_ci_co/data/remote/user_repository.dart';
import 'package:quan_ly_ci_co/domain/models/user_model.dart';
import 'package:quan_ly_ci_co/presentation/screen/dashboard/user/cubit/user_state.dart';

List<UserModel> listUsers = [
  UserModel(
    id: "U001",
    name: "John Smith",
    department: "Engineering",
    role: "Senior Developer",
    onboardDate: "2022-01-15",
  ),
  UserModel(
    id: "U002",
    name: "Emma Wilson",
    department: "HR",
    role: "HR Manager",
    onboardDate: "2021-08-20",
  ),
  UserModel(
    id: "U003",
    name: "Michael Chen",
    department: "Engineering",
    role: "Technical Lead",
    onboardDate: "2021-03-10",
  ),
  UserModel(
    id: "U004",
    name: "Sarah Davis",
    department: "Marketing",
    role: "Marketing Director",
    onboardDate: "2022-02-01",
  ),
  UserModel(
    id: "U005",
    name: "James Brown",
    department: "Finance",
    role: "Financial Analyst",
    onboardDate: "2022-04-15",
  ),
  UserModel(
    id: "U006",
    name: "Lisa Wang",
    department: "Engineering",
    role: "Mobile Developer",
    onboardDate: "2022-06-01",
  ),
  UserModel(
    id: "U007",
    name: "Robert Taylor",
    department: "Sales",
    role: "Sales Manager",
    onboardDate: "2021-11-30",
  ),
  UserModel(
    id: "U008",
    name: "Maria Garcia",
    department: "Customer Support",
    role: "Support Lead",
    onboardDate: "2022-03-15",
  ),
  UserModel(
    id: "U009",
    name: "David Kim",
    department: "Engineering",
    role: "DevOps Engineer",
    onboardDate: "2022-05-20",
  ),
  UserModel(
    id: "U010",
    name: "Anna Martinez",
    department: "Product",
    role: "Product Manager",
    onboardDate: "2021-09-01",
  ),
  UserModel(
    id: "U011",
    name: "Thomas Anderson",
    department: "Engineering",
    role: "Backend Developer",
    onboardDate: "2022-07-01",
  ),
  UserModel(
    id: "U012",
    name: "Sophie Martin",
    department: "Design",
    role: "UI/UX Designer",
    onboardDate: "2022-01-10",
  ),
  UserModel(
    id: "U013",
    name: "Kevin Lee",
    department: "Engineering",
    role: "QA Engineer",
    onboardDate: "2021-12-15",
  ),
  UserModel(
    id: "U014",
    name: "Rachel Green",
    department: "Marketing",
    role: "Content Manager",
    onboardDate: "2022-04-01",
  ),
  UserModel(
    id: "U015",
    name: "Daniel Wilson",
    department: "Finance",
    role: "Finance Director",
    onboardDate: "2021-10-01",
  ),
  UserModel(
    id: "U016",
    name: "Emily Chang",
    department: "HR",
    role: "Recruiter",
    onboardDate: "2022-03-01",
  ),
  UserModel(
    id: "U017",
    name: "Alex Johnson",
    department: "Engineering",
    role: "Frontend Developer",
    onboardDate: "2022-02-15",
  ),
  UserModel(
    id: "U018",
    name: "Christine Lee",
    department: "Legal",
    role: "Legal Counsel",
    onboardDate: "2021-11-01",
  ),
  UserModel(
    id: "U019",
    name: "Peter Zhang",
    department: "Engineering",
    role: "System Architect",
    onboardDate: "2021-07-15",
  ),
  UserModel(
    id: "U020",
    name: "Diana Ross",
    department: "Sales",
    role: "Account Executive",
    onboardDate: "2022-05-01",
  ),
];

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(const UserState(screenState: BaseScreenState.none));
  final _repo = UserRepository();

  Future<void> loadUsers(int page, int limit) async {
    try {
      emit(state.copyWith(screenState: BaseScreenState.loading));
      final res =
          await _repo.getUserList(PaginationParams(page: page, limit: limit));
      if (res?.success == false) {
        emit(state.copyWith(
          screenState: BaseScreenState.error,
          errorText: res?.message ?? 'Fetch user list failed',
        ));
        return;
      }

      emit(state.copyWith(
        screenState: BaseScreenState.success,
        users: (res?.data ?? []).map((user) => user.toUserModel()).toList(),
      ));
    } catch (e) {
      emit(state.copyWith(
        screenState: BaseScreenState.error,
        errorText: e.toString(),
      ));
    }
  }

  void search(String value) {}

  void createUser() {}
}
