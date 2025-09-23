import 'package:gsheets/gsheets.dart';

class UserSheetsApi {
  static const _credentials = r'''
  {
  "type": "service_account",
  "project_id": "gsheets-469308",
  "private_key_id": "7380420842af5c90118093b4529c7c95b5a9494c",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvwIBADANBgkqhkiG9w0BAQEFAASCBKkwggSlAgEAAoIBAQDKqFfLFRvpk8Fx\nPNmeWZKL+LhbHKfQfQTnpM35LDeXmdEIM0CAI2WX/jmTVkcMHKJgdQCJXXp8vjOZ\nHxj+QoYsw/wmTK889KtJxedzsA0mzw/rmuZSix1LzFiXrZ6PjxEmagJPFpgXbAib\n7tAeegyJ4BYPEQYPdgA/ymJS1E5ZdQAucuTNJZCB4wsjqOWZL2AVceyK/yZWKKFp\nen/cwiNqe1erQAfvulfV7OKiroLDPgBPjDO2nUjdWRzmcfHSqit+iFzKGBhYNzfm\nTklBPpoLaNVLBRcyX71TmEtksXJCYiyfprNdSMCq8beMcWMjayfm4n0BKQabE4rW\nsvJjfB3lAgMBAAECggEAIEiA89EBCUyIXEmdQSRzu+h7Nchy0zuXNG+EgFUS5guS\nyQOhGsiIvpW5BkeQOdW16De7RiamBIkoHxRdHuPqC+eMm21L3SH8x1vHax54ed4y\nYw3h8vRGTnTXCBKYV7YqvTvV8lNfFxwWowCAFtrKdIxF91B27q+VipPq5db8RDOe\nht8QvK49pr2Q7MfxiGcRsyjBkn2DdbKEu3IGvyNS0SXMAUnYDaEwXgDybIi+aSDf\n45o+pmrT0BXefKU3ekokvUxuurNlav2EsvvOlSyHqnFNZZEiYqWo1YZXxnjB7MSZ\n8dtLytkiwD3ECcM1TNl0eZmuQOgKRxVQNU8wnaDEAQKBgQDyO+kxQUjI8X5ZBdmj\nk+2TdeVNdNHjV49E/xzhHDuXtyq6myL/NDLuwJ1TNaWrSmjoHf7eKTRitnaC+vMd\npuKgnz6gRctdUdJLTkgPfgrAcXnYIcGQ+TL73foDU5Hav5bLxPVt+Tt9Fi9QoApF\nY6EpYOYHNKbakl67YOcGd86ARQKBgQDWLKmvui7qwJJpR8S0xUqTSZE2pTTEMN4o\nFqHVQiRp2Y1+4BrX5kNjnD4XPIDTHEIjqGC/qdFm9pYhaSYPOtg9mHFDgIU5ZakA\nlzosAbQ4xKywGDutwbUB67thc2QLgdmIttx8XRCoYMMU78GSqgt7aGjx6P6pNggA\n1I+NcgURIQKBgQDCr9Y3aTIXlsimwiXu69jZWLsoKsj6gIg8uxG595gJ0wR7oG5b\nUNfSvmpz0z1I03BHhrwuUE2zPNU5Znp5jYS99d8+r3nIkheDwPH3yaTYkRuN02ug\nmjkY54qmm8cxWiTXt4BOmC7w1SDIGyjGJlIEUMXwaqfkKhoLXdGwiCAnRQKBgQDU\n+ncHU5siQLuXzBGVPfgJ/YdVEvYk/v98V/04h9yUEg4+E/c9qTJsVMv96WGmDZzL\nvr3u+p1MyXvD379EN90fa39+g8h3qltkRf5IEq24IgQj3QVDpbQtI9EjeE8NjmPX\nKxiY5ycQeaClKkKRaV2fq9Vocq0DccKFqNrT6oWVYQKBgQCG3bZE4MHAkj+fDq+s\nBHHM8NNauejeVVyJJ4rMTRALHS/josMPEDWMrVwMXkBKmVxohTyYmV0Wqn7ITYvz\nTz2MKCGrhVC2TlfGTY1YLaUcGRtQoYzJIfxNgBQjFnwZQ66HySrLJ2Bybp0ILdzU\nrpJRiOc2EOm5FWkM7sUoWFlVnA==\n-----END PRIVATE KEY-----\n",
  "client_email": "gsheets@gsheets-469308.iam.gserviceaccount.com",
  "client_id": "110819096079694896355",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/gsheets%40gsheets-469308.iam.gserviceaccount.com",
  "universe_domain": "googleapis.com"
}
  ''';

  static final _spreadSheetId = "1le7SpvOdHCFKvMS9Bjb9HuYEqlapPpHtIaPXxA7pf8s";
  static final _gsheets = GSheets(_credentials);
  static Worksheet? _userSheet;

  static Worksheet? get userSheet => _userSheet;

  static Future init() async {
    try {
      print('🔄 Initializing Google Sheets...');
      final spreadSheet = await _gsheets.spreadsheet(_spreadSheetId);
      print('📊 Spreadsheet loaded successfully');

      _userSheet = await _getWorkSheet(spreadSheet, title: "Users");

      if (_userSheet != null) {
        print('✅ UserSheet initialized: ${_userSheet!.title}');
        print('📏 Sheet dimensions: ${_userSheet!.rowCount} rows, ${_userSheet!.columnCount} columns');

        // Try to get some sample data
        try {
          final sampleData = await _userSheet!.values.allRows();
          print('📋 Total rows in sheet: ${sampleData.length}');
          if (sampleData.isNotEmpty) {
            print('📋 First row (headers): ${sampleData.first}');
            if (sampleData.length > 1) {
              print('📋 Second row (sample data): ${sampleData[1]}');
            }
          } else {
            print('📋 Sheet is empty');
          }
        } catch (e) {
          print('⚠️ Could not fetch sample data: $e');
        }
      } else {
        print('❌ Failed to initialize UserSheet');
      }
    } catch (e, stackTrace) {
      print('💥 Error initializing Google Sheets: $e');
      print('📍 Stack trace: $stackTrace');
      rethrow;
    }
  }

  static Future<Worksheet?> _getWorkSheet(Spreadsheet spreadsheet, {required String title}) async {
    try {
      print('🔍 Looking for worksheet: $title');

      // First, try to get existing worksheet
      try {
        final existingSheet = spreadsheet.worksheetByTitle(title);
        if (existingSheet != null) {
          print('✅ Found existing worksheet: $title');
          return existingSheet;
        }
      } catch (e) {
        print('⚠️ Worksheet "$title" not found, will try to create it');
      }

      print('📝 Creating new worksheet: $title');
      try {
        return await spreadsheet.addWorksheet(title);
      } catch (e) {
        print('💥 Could not create worksheet: $e');
        return null;
      }

    } catch (e) {
      print('💥 Error getting/creating worksheet: $e');
      return null;
    }
  }

  // Helper method to add sample data for testing
  static Future<void> addSampleData() async {
    try {
      if (_userSheet == null) {
        print('❌ UserSheet not initialized');
        return;
      }

      print('📝 Adding sample data to sheet...');

      // Clear existing data first
      await _userSheet!.clear();

      // Add headers
      await _userSheet!.values.insertRow(1, [
        'rollNo', 'name', 'branch', 'year', 'busFees', 'tuitionFees', 'hostelFees', 'cgpa'
      ]);

      // Add sample student data
      await _userSheet!.values.insertRow(2, [
        '22W61A0565', 'John Doe', 'CSE', '2', '5000', '50000', '25000', '8.5'
      ]);

      await _userSheet!.values.insertRow(3, [
        '22W61A0566', 'Jane Smith', 'ECE', '3', '4500', '55000', '27000', '9.0'
      ]);

      print('✅ Sample data added successfully');

    } catch (e) {
      print('💥 Error adding sample data: $e');
    }
  }

  // Helper method to clear all data
  static Future<void> clearSheet() async {
    try {
      if (_userSheet == null) {
        print('❌ UserSheet not initialized');
        return;
      }

      print('🧹 Clearing sheet data...');
      await _userSheet!.clear();
      print('✅ Sheet cleared successfully');

    } catch (e) {
      print('💥 Error clearing sheet: $e');
    }
  }

  // Helper method to get all data for debugging
  static Future<void> debugSheetData() async {
    try {
      if (_userSheet == null) {
        print('❌ UserSheet not initialized');
        return;
      }

      print('🔍 Debugging sheet data...');

      try {
        final allRows = await _userSheet!.values.allRows();
        print('📊 All rows (${allRows.length}):');
        for (int i = 0; i < allRows.length; i++) {
          print('  Row $i: ${allRows[i]}');
        }
      } catch (e) {
        print('⚠️ allRows() failed: $e');
      }

    } catch (e) {
      print('💥 Error debugging sheet data: $e');
    }
  }

  // Method to check if sheet has data
  static Future<bool> hasData() async {
    try {
      if (_userSheet == null) return false;

      final rows = await _userSheet!.values.allRows();
      return rows.isNotEmpty;
    } catch (e) {
      print('💥 Error checking sheet data: $e');
      return false;
    }
  }
}
