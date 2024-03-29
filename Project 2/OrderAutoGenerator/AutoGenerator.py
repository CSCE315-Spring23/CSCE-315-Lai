from UtilityFunctions import *

if __name__ == "__main__":
    # open customer file and read lines to list of customers
    # breakpoint()
    customerFile = open("customerNames.csv")
    if (customerFile.closed):
        raise Exception(f"Couldn't open customer file")
    customers = customerFile.readlines()

    # get employee IDs
    employeeIDs = generateEmployeesList("Employees.csv")

    # get menu file
    menuFileName = input("Enter menu file name: ")
    menu = openMenu(menuFileName)

    # convert menu file into a dict of menu weights
    weightedMenu = createMenuWeights(menu)

    # get user input for start date and end date
    # convert into date object
    dateFormat = "%Y-%m-%d"

    startDateString = input("Enter start date (Y-M-D): ")
    numDaysToGenerate = int(input("Enter a number of days to generate "))

    startDate = datetime.strptime(startDateString, dateFormat).date()

    # get user input for game days
    gameDaysInput = input(
        "enter a comma separated list of game days (Y-M-D): ")
    # parse the game days into a set
    gameDays = parseGameDaysInput(gameDaysInput)

    # open appropriate output files
    orderItemFile = open("OrderItem.csv", "w")
    soldItemFile = open("SoldItem.csv", "w")

    # main loop for each day in the range
    curDate = startDate
    orderID = 0
    soldItemID = 1
    for i in range(numDaysToGenerate):
        if (isSunday(curDate)):
            curDate = incrementDate(curDate)
            continue

        # - check if game day and generate a number of orders for that day
        numberOfOrders = numOrdersForDay(curDate, gameDays)

        # - for each order
        for nthOrder in range(numberOfOrders):
            # -- generate a number of items for that order
            numItems = numItemsForOrder()

            # -- choose items for the order
            items = selectSoldItems(weightedMenu, numItems)

            # -- get prices for all those items and create an order with employee id and a customer name
            customer = getCustomerName(customers)
            order = createOrder(items, orderID, curDate,
                                customer, menu, employeeIDs)

            # -- create a string for the order
            orderString = createStringOfOrder(order)

            # -- create a string for each item sold
            itemsString = createStringOfSoldItems(
                items, menu, orderID, soldItemID)

            # -- write the strings to the output files
            orderItemFile.write(orderString)
            soldItemFile.write(itemsString)

            # increment order ID
            orderID += 1
            soldItemID += numItems

        # - increment date
        curDate = incrementDate(curDate)

    # close files
    orderItemFile.close()
    soldItemFile.close()
