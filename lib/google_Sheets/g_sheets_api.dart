import 'package:gsheets/gsheets.dart';

class UserSheetsApi {
  static const _credentials = r'''
  {
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

