import 'package:bloc_firebase_test/bloc/add_data_bloc/add_data_bloc.dart';
import 'package:bloc_firebase_test/bloc/bloc/fetch_data_bloc.dart';
import 'package:bloc_firebase_test/bloc/sign_up_bloc/sign_up_bloc.dart';
import 'package:bloc_firebase_test/data/repository/auth.dart';
import 'package:bloc_firebase_test/dependency_injection/di_container.dart';
import 'package:bloc_firebase_test/presentation/widget/bottom_sheet.dart';
import 'package:bloc_firebase_test/presentation/widget/home_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _authMethods = locator<AuthMethods>();

  @override
  void initState() {
    super.initState();
    context.read<FetchDataBloc>().add(InitialFetchedData());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddDataBloc, AddDataState>(
      listener: (context, state) {
        if (state is ShowSnackBarAddDataState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: Scaffold(
          floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {
                showBottomNavigationSheet(
                  context: context,
                );
              }),
          appBar: AppBar(
            title: Text('data'),
            actions: [
              IconButton(
                  onPressed: () {
                    context.read<FetchDataBloc>().add(InitialFetchedData());
                  },
                  icon: Icon(Icons.refresh)),
              IconButton(
                  onPressed: () async {
                    try {
                      await _authMethods.logOut();
                      context.read<SignUpBloc>().add(ResetSignUpStateEvent());
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        '/signUp',
                        (Route<dynamic> route) => false,
                      );
                    } catch (e) {
                      print(e.toString());
                    }
                  },
                  icon: Icon(Icons.logout_rounded))
            ],
          ),
          body: SingleChildScrollView(
            // Wrap Column in SingleChildScrollView
            child: BlocBuilder<FetchDataBloc, FetchDataState>(
              builder: (context, state) {
                if (state is FetchDataInitial) {
                  return Column(
                    children: [
                      HomeCard(
                        title: 'Total kilometers',
                        name1: '',
                        name2: '',
                        num1: '',
                        num2: '',
                        img1:
                            'https://static.printler.com/cache/0/8/7/0/5/5/0870555a812070b1b1239a74392cae3c9defc289.jpg',
                        img2:
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTldLJAvfYgTu8FDNGKeFQUvgHHEzuXZFPizQ&usqp=CAU',
                      ),
                      HomeCard(
                        title: 'Total payed',
                        name1: '',
                        name2: '',
                        num1: '',
                        num2: '',
                        img1:
                            'https://static.printler.com/cache/0/8/7/0/5/5/0870555a812070b1b1239a74392cae3c9defc289.jpg',
                        img2:
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTldLJAvfYgTu8FDNGKeFQUvgHHEzuXZFPizQ&usqp=CAU',
                      )
                    ],
                  );
                } else if (state is FetchDataSuccess) {
                  return Column(
                    children: [
                      HomeCard(
                        title: 'Total kilometers',
                        name1: state.dataUser1.uid,
                        name2: state.dataUser1.uidConected,
                        num1: state.calculatedDataUser1.totalRange.toString(),
                        num2: state.calculatedDataUser2.totalRange.toString(),
                        img1:
                            'https://static.printler.com/cache/0/8/7/0/5/5/0870555a812070b1b1239a74392cae3c9defc289.jpg',
                        img2:
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTldLJAvfYgTu8FDNGKeFQUvgHHEzuXZFPizQ&usqp=CAU',
                      ),
                      HomeCard(
                        title: 'Total payed',
                        name1: state.dataUser1.uid,
                        name2: state.dataUser1.uidConected,
                        num1: state.calculatedDataUser1.totalMoney.toString(),
                        num2: state.calculatedDataUser2.totalMoney.toString(),
                        img1:
                            'https://static.printler.com/cache/0/8/7/0/5/5/0870555a812070b1b1239a74392cae3c9defc289.jpg',
                        img2:
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTldLJAvfYgTu8FDNGKeFQUvgHHEzuXZFPizQ&usqp=CAU',
                      ),
                      HomeCard(
                        title: 'Average usage',
                        name1: state.dataUser1.uid,
                        name2: state.dataUser1.uidConected,
                        num1: state.calculatedDataUser1.averageUsage.toString(),
                        num2: state.calculatedDataUser2.averageUsage.toString(),
                        img1:
                            'https://static.printler.com/cache/0/8/7/0/5/5/0870555a812070b1b1239a74392cae3c9defc289.jpg',
                        img2:
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTldLJAvfYgTu8FDNGKeFQUvgHHEzuXZFPizQ&usqp=CAU',
                      )
                    ],
                  );
                } else if (state is FetchDataLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is FetchDataError) {
                  return Center(
                    child: Text(state.error),
                  );
                } else {
                  return Center(child: Text('no state finded'));
                }
              },
            ),
          )),
    );
  }
}
