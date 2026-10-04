local academia = SMODS.current_mod

-- Sorting Algorithms
function academia.sort_bubble(number)
    local array = {}

    for digit in tostring(number):gmatch("%d") do
        table.insert(array, tonumber(digit))
    end

    for j = 1, #array - 1 do
        if array[j] > array[j + 1] then
            array[j], array[j + 1] = array[j + 1], array[j]
        end
    end

    local result = ""
    for i = 1, #array do
        result = result .. array[i]
    end

    return result
end

function academia.sort_heap(number)
    local array = {}

    for digit in tostring(number):gmatch("%d") do
        table.insert(array, tonumber(digit))
    end

    local function heapify(size, i)
        local left = 2 * i
        local right = 2 * i + 1
        local largest = i

        if left <= size and array[left] > array[largest] then
            largest = left
        end

        if right <= size and array[right] > array[largest] then
            largest = right
        end

        if largest ~= i then
            array[i], array[largest] = array[largest], array[i]
            heapify(size, largest)
        end
    end

    local size = #array

    -- Build heap
    for i = math.floor(size / 2), 1, -1 do
        heapify(size, i)
    end

    -- One iteration
    if size > 1 then
        array[1], array[size] = array[size], array[1]
        size = size - 1
        heapify(size, 1)
    end

    local result = ""
    for i = 1, #array do
        result = result .. array[i]
    end

    return result
end

function academia.sort_merge(number)
    local array = {}

    for digit in tostring(number):gmatch("%d") do
        table.insert(array, tonumber(digit))
    end

    local mid = math.floor(#array / 2)

    if mid < 1 or mid >= #array then
        return number
    end

    local left = {}
    local right = {}

    for i = 1, mid do
        left[i] = array[i]
    end

    for i = mid + 1, #array do
        right[i - mid] = array[i]
    end

    local i = 1
    local j = 1
    local k = 1

    while i <= #left and j <= #right do
        if left[i] <= right[j] then
            array[k] = left[i]
            i = i + 1
        else
            array[k] = right[j]
            j = j + 1
        end
        k = k + 1
    end

    while i <= #left do
        array[k] = left[i]
        i = i + 1
        k = k + 1
    end

    while j <= #right do
        array[k] = right[j]
        j = j + 1
        k = k + 1
    end

    local result = ""
    for i = 1, #array do
        result = result .. array[i]
    end
    -- ts one pissed me off so much
    return result
end

function academia.sort_quick(number)
    local array = {}

    for digit in tostring(number):gmatch("%d") do
        table.insert(array, tonumber(digit))
    end

    local low = 1
    local high = #array

    if low >= high then
        return number
    end

    local pivot = array[high]
    local i = low - 1

    for j = low, high - 1 do
        if array[j] <= pivot then
            i = i + 1
            array[i], array[j] = array[j], array[i]
        end
    end

    array[i + 1], array[high] = array[high], array[i + 1]

    local result = ""
    for i = 1, #array do
        result = result .. array[i]
    end

    return result
end